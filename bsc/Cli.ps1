<#
.SYNOPSIS
    batScript 编译器 CLI — 参数解析与动作分发。
.DESCRIPTION
    对外暴露 Invoke-BscCli。
    该函数解析由 Main.ps1 转发的原始参数列表，
    并将控制权交给 Invoke-BscVersion / Invoke-BscCompile / Invoke-BscCheck。
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# ── 版本字符串 ────────────────────────────────────────────────────────────────
$script:BscVersion = '0.1.0'

# ═════════════════════════════════════════════════════════════════════════════
# 私有工具函数
# ═════════════════════════════════════════════════════════════════════════════

<#
.SYNOPSIS
    向标准错误写入致命错误消息并退出进程。
.PARAMETER Message
    面向用户的错误说明。
.PARAMETER ExitCode
    进程退出码，默认为 1。
#>
function Write-BscFatalError {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Message,

        [int] $ExitCode = 1
    )

    [Console]::Error.WriteLine("[bsc] error: $Message")
    exit $ExitCode
}

<#
.SYNOPSIS
    向标准输出写入使用说明。
#>
function Write-BscUsage {
    [CmdletBinding()]
    param()

    $usageText = @'
batScript Compiler (bsc)  --  version {0}

用法:
  bsc -Version
  bsc -Compile <input.bs>  -Output <output.bat>
  bsc -Check   -File   <input.bs>

选项:
  -Version             输出版本号后退出。
  -Compile <file>      指定待编译的 .bs 源文件。
  -Output  <file>      指定输出的 .bat 文件（与 -Compile 配合使用）。
  -Check               仅进行语法与语义检查，不生成输出文件。
  -File    <file>      指定待检查的 .bs 源文件（与 -Check 配合使用）。
'@ -f $script:BscVersion

    Write-Output -InputObject $usageText
}

<#
.SYNOPSIS
    解析并验证 .bs 源文件路径。
.PARAMETER FilePath
    用户传入的相对或绝对路径。
.OUTPUTS
    System.String  文件的绝对路径。
#>
function Resolve-BscInputPath {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $FilePath
    )

    $resolved = Resolve-Path -Path $FilePath -ErrorAction SilentlyContinue

    if (-not $resolved) {
        Write-BscFatalError -Message "文件未找到: '$FilePath'"
    }

    $extension = [System.IO.Path]::GetExtension($resolved.Path)
    if ($extension -ne '.bs') {
        Write-BscFatalError -Message "期望 .bs 文件，实际扩展名为 '$extension': '$FilePath'"
    }

    return $resolved.Path
}

# ═════════════════════════════════════════════════════════════════════════════
# 公开入口
# ═════════════════════════════════════════════════════════════════════════════

<#
.SYNOPSIS
    解析原始 CLI 参数列表并分发到对应的编译器动作。
.DESCRIPTION
    由 Main.ps1 使用 $args 调用。
    使用手动扫描而非 PowerShell 参数绑定，
    以保证 flag 名称与文档中的形式完全一致。
.PARAMETER ArgumentList
    Main.ps1 转发的原始字符串参数数组。
.EXAMPLE
    Invoke-BscCli -ArgumentList @('-Version')
.EXAMPLE
    Invoke-BscCli -ArgumentList @('-Compile', 'Hello.bs', '-Output', 'Hello.bat')
.EXAMPLE
    Invoke-BscCli -ArgumentList @('-Check', '-File', 'Hello.bs')
#>
function Invoke-BscCli {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [AllowEmptyCollection()]
        [string[]] $ArgumentList
    )

    if ($ArgumentList.Count -eq 0) {
        Write-BscUsage
        exit 0
    }

    $action = $null
    $inputFile = $null
    $outputFile = $null

    # ── 线性扫描参数列表 ──────────────────────────────────────────────────────
    $index = 0
    while ($index -lt $ArgumentList.Count) {
        $current = $ArgumentList[$index]

        switch ($current) {
            '-Version' {
                $action = 'Version'
            }
            '-Compile' {
                $action = 'Compile'
                $index++
                if ($index -ge $ArgumentList.Count) {
                    Write-BscFatalError -Message '-Compile 需要紧跟一个源文件路径。'
                }
                $inputFile = $ArgumentList[$index]
            }
            '-Output' {
                $index++
                if ($index -ge $ArgumentList.Count) {
                    Write-BscFatalError -Message '-Output 需要紧跟一个目标文件路径。'
                }
                $outputFile = $ArgumentList[$index]
            }
            '-Check' {
                $action = 'Check'
            }
            '-File' {
                $index++
                if ($index -ge $ArgumentList.Count) {
                    Write-BscFatalError -Message '-File 需要紧跟一个源文件路径。'
                }
                $inputFile = $ArgumentList[$index]
            }
            default {
                Write-BscFatalError -Message "未知参数: '$current'。"
            }
        }

        $index++
    }

    # ── 分发 ──────────────────────────────────────────────────────────────────
    switch ($action) {
        'Version' {
            Invoke-BscVersion
        }
        'Compile' {
            if (-not $inputFile) {
                Write-BscFatalError -Message '-Compile 缺少源文件，请指定 .bs 文件路径。'
            }
            if (-not $outputFile) {
                Write-BscFatalError -Message '-Compile 缺少输出路径，请使用 -Output 指定目标 .bat 文件。'
            }
            Invoke-BscCompile -InputFile $inputFile -OutputFile $outputFile
        }
        'Check' {
            if (-not $inputFile) {
                Write-BscFatalError -Message '-Check 缺少源文件，请使用 -File 指定 .bs 文件路径。'
            }
            Invoke-BscCheck -InputFile $inputFile
        }
        default {
            Write-BscUsage
            exit 1
        }
    }
}

# ═════════════════════════════════════════════════════════════════════════════
# 动作实现（当前为桩；管线接入后逐步替换 TODO 注释）
# ═════════════════════════════════════════════════════════════════════════════

<#
.SYNOPSIS
    输出编译器版本号。
#>
function Invoke-BscVersion {
    [CmdletBinding()]
    param()

    Write-Output -InputObject "bsc $script:BscVersion"
}

<#
.SYNOPSIS
    将 .bs 源文件编译为 .bat 输出文件。
.PARAMETER InputFile
    源 .bs 文件的路径。
.PARAMETER OutputFile
    目标 .bat 文件的路径。
#>
function Invoke-BscCompile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $InputFile,

        [Parameter(Mandatory)]
        [string] $OutputFile
    )

    $resolvedInput = Resolve-BscInputPath -FilePath $InputFile

    Write-Output -InputObject "[bsc] 编译: $resolvedInput  →  $OutputFile"

    # TODO: 管线各阶段接入后替换以下占位逻辑
    #   $tokens   = Invoke-BscLex            -SourcePath $resolvedInput
    #   $ast      = Invoke-BscParse          -TokenList  $tokens
    #   $checkedAst = Invoke-BscSema         -Ast        $ast
    #   $lowered  = Invoke-BscLower          -Ast        $checkedAst
    #   $planned  = Invoke-BscPlanRuntime    -Ast        $lowered
    #   Invoke-BscEmitBat -Ast $planned -OutputPath $OutputFile

    Write-BscFatalError -Message '编译功能尚未实现。' -ExitCode 2
}

<#
.SYNOPSIS
    对 .bs 源文件执行诊断检查，不生成输出文件。
.PARAMETER InputFile
    待检查的 .bs 源文件路径。
#>
function Invoke-BscCheck {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $InputFile
    )

    $resolvedInput = Resolve-BscInputPath -FilePath $InputFile

    Write-Output -InputObject "[bsc] 检查: $resolvedInput"

    # TODO: 管线各阶段接入后替换以下占位逻辑
    #   $tokens     = Invoke-BscLex   -SourcePath $resolvedInput
    #   $ast        = Invoke-BscParse -TokenList  $tokens
    #   Invoke-BscSema -Ast $ast

    Write-BscFatalError -Message '检查功能尚未实现。' -ExitCode 2
}