#!/usr/bin/env bash
# obsidian-ai-cocreation · 一键初始化
# 用法：
#   bash init-vault.sh                      # 就地个性化（git clone 后在仓库根运行）
#   bash init-vault.sh /path/to/new-vault   # 复制模板到新目录再个性化（保持克隆目录干净）
#   可选：--areas "领域A,领域B,领域C"（默认保留示例五领域）
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
TARGET=""
AREAS=""

while [ $# -gt 0 ]; do
  case "$1" in
    --areas) AREAS="${2:?--areas 需要参数}"; shift 2 ;;
    *) TARGET="$1"; shift ;;
  esac
done

# 0) 目标目录：带参数 = 复制模板；不带 = 就地个性化克隆
if [ -n "$TARGET" ]; then
  mkdir -p "$TARGET"
  TARGET="$(cd "$TARGET" && pwd)"
  tar -C "$SRC" --exclude=./.git -cf - . | tar -C "$TARGET" -xf -
  echo "✓ 模板已复制 → $TARGET"
else
  TARGET="$SRC"
fi

# 1) 填入 MCP 绝对路径（.mcp.json 用 Windows 混合风格，.mcp.linux.json 用 POSIX 风格）
MIX_PATH="$(command -v cygpath >/dev/null 2>&1 && cygpath -m "$TARGET" || realpath "$TARGET")"
POS_PATH="$(command -v cygpath >/dev/null 2>&1 && cygpath -u "$TARGET" || realpath "$TARGET")"
sed -i "s|__VAULT_PATH__|$MIX_PATH|g" "$TARGET/.mcp.json"
sed -i "s|__VAULT_PATH__|$POS_PATH|g" "$TARGET/.mcp.linux.json"
echo "✓ MCP 路径已写入（$MIX_PATH）"

# 2) 自定义领域（未提供且非交互环境时保留示例五领域）
if [ -z "$AREAS" ] && [ -t 0 ]; then
  read -r -p "自定义领域（逗号分隔，直接回车 = 保留示例五领域）: " INPUT
  AREAS="$INPUT"
fi

if [ -n "$AREAS" ]; then
  IFS=',' read -ra ARR <<< "$AREAS"
  rm -rf "$TARGET"/02-Areas/*
  rows=""
  idx=""
  today="$(date +%F)"
  for a in "${ARR[@]}"; do
    a="$(echo "$a" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
    [ -z "$a" ] && continue
    case "$a" in *[/\\]*) echo "✗ 非法领域名：$a"; exit 1 ;; esac
    mkdir -p "$TARGET/02-Areas/$a"
    cat > "$TARGET/02-Areas/$a/_context.md" <<EOF
---
type: area-context
area: $a
updated: $today
---
# _context：$a

> 领域压缩上下文，控制在 500 词内。AI 命中路由关键词时先读这里，再深入检索。

## 领域定位
长期 Area，永不"完成"。AI 只读本目录；创作产出进 03-Projects/，用 frontmatter area 字段软关联。

## 当前关注
-

## 关键结论 / 已验证的判断
-

## 相关项目
-
EOF
    rows="${rows}| $a | [[02-Areas/$a/_context]] | $a（请补触发关键词） |
"
    idx="${idx}- [[02-Areas/$a/_context|$a]]
"
  done
  if [ -z "$rows" ]; then echo "✗ 领域列表为空"; exit 1; fi
  awk -v rows="$rows" '/<!--area-rows-start-->/{print; printf "%s", rows; skip=1; next} /<!--area-rows-end-->/{skip=0} !skip' "$TARGET/CLAUDE.md" > "$TARGET/CLAUDE.md.tmp" && mv "$TARGET/CLAUDE.md.tmp" "$TARGET/CLAUDE.md"
  awk -v idx="$idx" '/<!--area-rows-start-->/{print; printf "%s", idx; skip=1; next} /<!--area-rows-end-->/{skip=0} !skip' "$TARGET/_INDEX.md" > "$TARGET/_INDEX.md.tmp" && mv "$TARGET/_INDEX.md.tmp" "$TARGET/_INDEX.md"
  echo "✓ 领域已生成（记得在各 _context.md 与 CLAUDE.md 路由表补触发关键词）"
fi

# 3) git（复制模式下初始化；就地模式沿用克隆的 .git）
if [ ! -d "$TARGET/.git" ]; then
  git -C "$TARGET" init -q
  git -C "$TARGET" add -A
  git -C "$TARGET" -c user.name="init" -c user.email="init@local" commit -qm "init: obsidian-ai-cocreation"
  echo "✓ git 已初始化并完成首次提交"
fi

cat <<'EOF'

初始化完成。接下来：
  1. 用 Obsidian「打开文件夹作为仓库」打开本目录，信任并启用插件；
  2. 设置 → 核心插件 → 打开「模板」（模板目录已预配置）；
  3. 在本目录启动外部 AI 工具（如 claude），批准两个 MCP server；
  4. 读《使用指南.md》第 4 章开始第一个项目（或直接跑 /produce/new）。
  详细文档见 README.md 与 使用指南.md。
EOF
