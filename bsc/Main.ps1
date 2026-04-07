<#
.SYNOPSIS
    batScript 编译器 (bsc) 的 PowerShell 入口点。
.DESCRIPTION
    按依赖顺序 dot-source 所有编译器模块，
    随后将原始参数列表转交给 Invoke-BscCli 处理。
.NOTES
    需要 PowerShell 5.1 或更高版本。
    请通过 bsc.cmd 调用；除测试外勿直接执行本脚本。
#>

#Requires -Version 5.1

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# ── 模块根目录（与本脚本同目录） ──────────────────────────────────────────────
$script:BscRoot = $PSScriptRoot

# ── 按依赖顺序 dot-source 所有模块 ──────────────────────────────────────────
$script:BscModules = @(
    'Diagnostics'       # 诊断与错误报告（无内部依赖）
    'Types'             # 类型系统定义
    'Symbols'           # 符号表
    'Ast'               # AST 节点定义
    'Builtins'          # 内置函数/标准库描述
    'Lexer'             # 词法分析
    'Parser'            # 语法分析
    'Sema'              # 语义分析
    'Lowering'          # AST 降级
    'RuntimePlanner'    # 运行时规划
    'EmitBat'           # BAT 代码生成
    'Cli'               # CLI 解析与分发（最后加载）
)

foreach ($module in $script:BscModules) {
    $modulePath = Join-Path -Path $script:BscRoot -ChildPath "$module.ps1"
    . $modulePath
}

# ── 将参数转发给 CLI 分发器 ──────────────────────────────────────────────────
Invoke-BscCli -ArgumentList ([string[]] $args)