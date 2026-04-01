# `batScript`

***[English](README.md)***  

`batScript`是一个**强类型, 结构化的转译语言**, 以`.bs`作为后缀名.  
就和`JavaScript`转译为`TypeScript`一样, `batScript`转译`.bs`至`.bat`, 为陈旧简陋的`.bat`脚本带来了:  

- 合理的命名规范和使用: 批处理原生的语法简陋怪异, `batScript`提供贴近正常语言的关键字和标识符设计.  
- 类型系统: 提供三种单元类型, 包括两种基本类型(`num`, `bool`)和一种组合类型(`pair`), 以及两种可迭代类型(`str`, `arr`), 变量区分大小写.  
- 正常的控制流: `if-else-elif`基本选择分支, `while`, `loop`基本循环分支, 以及延展的`condition`状态机选择分支和`iterate`可迭代体循环分支, 及`loop`, `repeat`, `circle`语法糖.  
- 函数和过程. 分别通过`func`和`proc`声明, 强类型, 支持递归.  
- 现代的运算符. 主要运算符符合现代语言习惯, 以及和`BAT`契合的特别运算符, 如取原始运算符`$|`.  
- 基本的包管理. `pkg`导入包, `lib`导入库, 以及`bspm`包管理器.  
- 脚本特制的语法, 如`conf`配置, `match`约束等.  
- 其它语法扩展. 包括最基础的异常`err`, 输入输出`echo`和`getin`等, 原生`BAT`运行`runraw`, 成组`group`等.  

从[这里](./doc/zh/guide/01-引入batScript.md)开始阅读完整文档.  

## 速览  

### 编译器命令  

```cmd
bsc -Version :: 输出版本
bsc -Compile input_file -Output output_file :: 执行编译
bsc -Check -File check_file :: 检查代码
```

示例:  

```cmd
bsc -Compile MyScript.bs -Output MyScript.bat
```

### 包管理器命令  

```cmd
bspm /v :: 输出版本
bspm /s search_name :: 搜索库
bspm /i package_name :: 安装库
bspm /u package_name :: 卸载库
bspm /l match_name :: 列出本地库
```

示例:  

```cmd
bspm /i BatKV /c ">=1.0"
```

### 关键字及符号表

| 符号         | 说明             |
|--------------|------------------|
| `set`        | 声明变量         |
| `let`        | 声明不可变量     |
| `num`        | 数字类型         |
| `bool`       | 布尔类型         |
| `str`        | 字符串类型       |
| `arr`        | 一维数组类型     |
| `pair`       | 键值对类型       |
| `match`      | 约束             |
| `if`         | 如果             |
| `elif`       | 或者如果         |
| `else`       | 或者             |
| `condition`  | 匹配条件         |
| `while`      | 基本循环         |
| `loop`       | 无限循环         |
| `repeat`     | 次数循环         |
| `iterate`    | 可迭代体循环     |
| `circle`     | 可迭代体轮转循环 |
| `break`      | 终止循环         |
| `continue`   | 继续循环         |
| `and`        | 且               |
| `or`         | 或               |
| `not`        | 非               |
| `func`       | 函数             |
| `proc`       | 过程             |
| `return`     | 返回值           |
| `pkg`        | 文件导入         |
| `lib`        | 包导入           |
| `runraw`     | 原生内嵌         |
| `err`        | 抛出异常         |
| `endprogram` | 终止程序         |
| `pause`      | 暂停             |
| `getin`      | 输入流获取       |
| `echo`       | 输出             |
| `group`      | 成组             |
| `conf`       | 配置项           |
| `+`          | 加法             |
| `-`          | 减法             |
| `*`          | 乘法             |
| `/`          | 除法             |
| `>`          | 大于判断         |
| `>=`         | 大等于判断       |
| `==`         | 等于判断         |
| `~=`         | 不等于判断       |
| `<`          | 小于判断         |
| `<=`         | 小等于判断       |
| `=`          | 赋值             |
| `%%`         | 类型转换         |
| `!`          | 取反             |
| `?`          | 判空             |
| `&`          | 取类型字符串     |
| `@`          | 可迭代体取长     |
| `..`         | 可迭代体拼接     |
| `^`          | 可迭代体位值     |
| `$\|`        | 取原始           |
| `True`       | 真值             |
| `False`      | 假值             |
| `Nil`        | 空值             |
| `Inf`        | 无限值           |

### 标准库速览

| 库名称     | 说明       | 代表性方法/字面量                                                                   |
|------------|------------|-------------------------------------------------------------------------------------|
| `Math`     | 数学       | `abs()` `min()` `max()` `sqrt()` `random` `floor()` `ceil()` `round()` `pow()` `PI` |
| `Cmd`      | 控制台     | `setColor()` `setTitle()` `restartInAdmin()`                                        |
| `Tools`    | 系统工具   | `diskpart()` `ping()` `ipconfig()` `whoami()`                                       |
| `Windows`  | 操作系统   | `version()` `getEnv()` `setEnv()`                                                   |
| `Admin`    | 管理员权限 | `isAdmin()` `requireAdmin()` `relaunchAsAdmin` `sudo()`                             |
| `Iterable` | 可迭代体   | `arrIndexOf()` `strContain()`                                                       |

### 其它语法速览

- `#`: 嵌入文档  
- `;`: 注释  
- `"\n"`: 字符串转译  
- `''`: 原始字符串字符串  
- ``Hello {hello_val}``:  b-string
- `[1, 2, 3, 4][2:3]`: 数组切片
- `{`, `}`: 代码块切分  
- `if (a > b) :`: 单行语句  
- `func (a: num, b: str) -> bool`: 函数声明  

### 编码规范  

- 文件: 大驼峰.bs  
- 变量: 小写+下划线  
- 常量: 大写+下划线  
- 函数及过程: 小驼峰  
- 组名: 大驼峰  
- 配置名: 每个词以大写开头, 使用下划线连接  
- AllMan风格括号  
- 一切文件, 组, 函数和过程编写文档注释  

## 示例程序  

### HelloWorld  

最基本的示范.  

```batscript
# Description: batScript HelloWorld示例程序
# Author: WaterRun
# Date: 2026-03-30
# File: HelloWorld.bs

echo "HelloWorld!" ; 输出HelloWorld
```

### 类型系统  

以下展示了batScript中各个基本类型和使用.  

```batscript
# Description: batScript 类型示例程序
# Author: WaterRun
# Date: 2026-04-01
# File: Types.bs

; 常量
let MAX_COUNT: num = 128
let max_count: num = 64 ; 和MAX_COUNT是两个变量, 大小写敏感, 不过编译器会提示没有遵循编码规范

; 字符串类型
set name_1: str = "Alice"
set name_2 = "Bol"
set name_3: str? = "Siri"
; name_3 = -123.456
; 上行若取消注释将报错：name_3 的类型是 str?

; 数字类型
set age_1: num = 20
set age_2 = 22.5
set age_3: num? = Nil

; 布尔类型
set is_alive_1: bool = True
set is_alive_2: bool = False
set is_alive_3: bool? = Nil

; 数组类型
set scores: arr<num> = [90, 88.5, 100]
set names: arr<str> = ["Alice", "Bol", "Siri"]

; 组合类型
set name_age_pair_1: pair<str, num> = (name_1, age_1)
set name_age_pair_2: pair<str, num?> = (name_3, age_3)
set name_age_pair_3: pair<str, num>? = Nil

; 一元与长度
set name_1_len: num = @name_1
set name_1_rev: str = !name_1

; 拼接
set greeting: str = "Hello, " .. name_1

; 类型转换与输出
set age_1_text: str = %str%age_1
set name_1_len_text: str = %str%name_1_len
set scores_len: num = @scores
set scores_len_text: str = %str%scores_len

echo greeting
echo `age_1 = {age_1_text}`
echo `name_1_len = {name_1_len_text}`
echo `scores_len = {scores_len_text}`
echo `name_1_rev = {name_1_rev}`
```

### 控制流示例  

```batscript
# Description: batScript 控制流示例程序（含详尽注释）
# Author: WaterRun
# Date: 2026-04-01
# File: ControlFlow.bs
# Version: 1.0.1

; ==============================
; 全局常量
; ==============================

let DEFAULT_NAME = "Guest"
let MAX_CIRCLE_STEPS = 5

; ==============================
; 工具函数与过程
; ==============================

# Description: 判断字符串是否非空
# Param [v]: 待判断的字符串
# Return: 非空返回 True，否则 False
func isNonEmpty(v: str) -> bool
{
    ; ?v 表示判空，非空返回 True
    return ?v
}

# Description: 输出分节标题
# Param [title]: 标题文本
proc showTitle(title: str)
{
    ; 输出空行，分隔区块
    echo ""
    ; 输出装饰线
    echo "=============================="
    ; 输出标题
    echo title
    ; 输出装饰线
    echo "=============================="
}

; ==============================
; 主流程
; ==============================

# Description: 主流程，演示全部控制流
proc main()
{
    ; 标题
    showTitle("batScript 控制流示例")

    ; ---------- 输入与基本 if ----------
    ; 获取用户名输入，getin 返回 str
    set name_raw: str = getin "Input your name>>"
    ; 预置默认用户名
    set user_name: str = DEFAULT_NAME

    ; 如果输入非空，使用输入值；否则使用默认值
    if (isNonEmpty(name_raw))
    {
        set user_name = name_raw
    }
    else
    {
        set user_name = DEFAULT_NAME
    }

    ; 输出欢迎语
    echo `Hello {user_name}`

    ; ---------- if / elif / else 与 condition ----------
    showTitle("if / elif / else 与 condition")

    ; 获取年龄输入（期望 10/20/30）
    set age_raw: str = getin "Input age (10/20/30)>>"
    ; 先给一个明确的数值初值
    set age: num = 0

    ; 用 condition 进行字符串匹配，仅允许固定值
    condition age_raw
    {
        "10": set age = %num%age_raw
        "20": set age = %num%age_raw
        "30": set age = %num%age_raw
        /: err "Age must be 10, 20, or 30"
    }

    ; 将 age 转为字符串以便 b-string 插值
    set age_text: str = %str%age

    ; 年龄组默认值
    set age_group: str = "Unknown"

    ; 依据年龄区间设置年龄组
    if (age < 18)
    {
        set age_group = "Child"
    }
    elif (age < 30)
    {
        set age_group = "Adult"
    }
    else
    {
        set age_group = "Senior"
    }

    ; 输出年龄与年龄组
    echo `age = {age_text}`
    echo `group = {age_group}`

    ; if 单行语法示例（仅单动作）
    if (age >= 18): echo "Access granted"

    ; ---------- condition 的字符串分支 ----------
    ; 获取操作符输入
    set op_raw: str = getin "Choose op (add/sub/other)>>"

    ; condition 分支仅允许单行动作
    condition op_raw
    {
        "add": echo "You chose add"
        "sub": echo "You chose sub"
        /: echo "You chose other"
    }

    ; ---------- while / continue ----------
    showTitle("while / continue")

    ; while 计数器
    set while_count: num = 0

    ; 基本 while 循环
    while (while_count < 5)
    {
        ; 先自增
        set while_count = while_count + 1

        ; 当计数为 2 时跳过输出
        if (while_count == 2)
        {
            continue
        }

        ; 输出当前计数
        set while_count_text: str = %str%while_count
        echo `while_count = {while_count_text}`
    }

    ; while 单行语法示例（仅单动作）
    set quick_count: num = 0
    while (quick_count < 2): set quick_count = quick_count + 1
    echo "while 单行语法已执行"

    ; ---------- loop / break ----------
    showTitle("loop / break")

    ; loop 计数器
    set loop_count: num = 0

    ; 无限 loop，用 break 退出
    loop
    {
        set loop_count = loop_count + 1
        set loop_count_text: str = %str%loop_count
        echo `loop_count = {loop_count_text}`

        ; 达到 3 时退出
        if (loop_count >= 3)
        {
            break
        }
    }

    ; loop 单行语法示例（仅单动作）
    loop: break

    ; ---------- repeat ----------
    showTitle("repeat")

    ; repeat 单行语法示例
    repeat 3: echo "repeat single-line"

    ; repeat 带索引示例
    repeat 3 => i
    {
        set i_text: str = %str%i
        echo `repeat index = {i_text}`
    }

    ; ---------- iterate ----------
    showTitle("iterate")

    ; 数组迭代
    set nums: arr<num> = [1, 2, 3]
    iterate (nums) => n
    {
        set n_text: str = %str%n
        echo `n = {n_text}`
    }

    ; 字符串迭代（逐字符）
    set word: str = "bat"
    iterate (word) => ch
    {
        echo ch
    }

    ; ---------- circle ----------
    showTitle("circle")

    ; 可迭代体轮转示例
    set colors: arr<str> = ["R", "G", "B"]
    set circle_count: num = 0

    ; circle 无限轮转，依赖 break 退出
    circle (colors) => c
    {
        set circle_count = circle_count + 1
        echo c

        ; 达到上限次数退出
        if (circle_count >= MAX_CIRCLE_STEPS)
        {
            break
        }
    }

    ; 结束语
    echo "Done."
}

; 入口调用
main()
```

### 交互式四则计算器  

```batscript
# Description: 交互式四则计算器（含表达式解析、优先级与括号）
# Author: ChatGPT
# Date: 2026-04-01
# File: Calculator.bs
# Version: 1.0.0

; ==============================
; 工具函数：字符分类
; ==============================

# Description: 判断字符是否为数字 0-9
# Param [ch]: 单字符字符串
# Return: 是数字返回 True，否则 False
func isDigit(ch: str) -> bool
{
    if (ch >= "0" and ch <= "9")
    {
        return True
    }
    return False
}

# Description: 判断字符是否为空白（空格或制表符）
# Param [ch]: 单字符字符串
# Return: 是空白返回 True，否则 False
func isSpace(ch: str) -> bool
{
    if (ch == " ")
    {
        return True
    }
    if (ch == "\t")
    {
        return True
    }
    return False
}

; ==============================
; 词法分析：把表达式字符串切成记号序列
; ==============================

# Description: 将表达式切分为记号数组（数字、运算符、括号）
# Param [expr]: 原始表达式字符串
# Return: 记号数组（arr<str>）
func tokenize(expr: str) -> arr<str>
{
    set tokens: arr<str> = []
    set i: num = 0
    set n: num = @expr

    while (i < n)
    {
        set j: num = i + 1
        set ch: str = expr[i:j]

        if (isSpace(ch))
        {
            set i = i + 1
        }
        elif (isDigit(ch) or ch == ".")
        {
            set num_buf: str = ""
            loop
            {
                if (i >= n)
                {
                    break
                }

                set j = i + 1
                set ch = expr[i:j]

                if (isDigit(ch) or ch == ".")
                {
                    set num_buf = num_buf .. ch
                    set i = i + 1
                }
                else
                {
                    break
                }
            }
            tokens^ num_buf
        }
        elif (ch == "+" or ch == "-" or ch == "*" or ch == "/" or ch == "(" or ch == ")")
        {
            tokens^ ch
            set i = i + 1
        }
        else
        {
            echo `Invalid char: {ch}`
            err! "Invalid character in expression"
        }
    }

    return tokens
}

; ==============================
; 递归下降解析器（使用全局游标）
; 支持：+ - * /，括号，一元正负号
; ==============================

; 全局记号表与游标
set g_tokens: arr<str> = []
set g_tok_len: num = 0
set g_pos: num = 0

# Description: 是否还有未读记号
# Return: 有剩余返回 True，否则 False
func hasMoreTokens() -> bool
{
    return g_pos < g_tok_len
}

# Description: 查看当前记号，不前进；若无则返回空串
# Return: 当前记号或空串
func peekToken() -> str
{
    if (hasMoreTokens())
    {
        return g_tokens[g_pos]
    }
    return ""
}

# Description: 记号游标前进一位
proc advanceToken()
{
    set g_pos = g_pos + 1
}

# Description: 解析因子：数字、括号表达式、一元正负号
# Return: 数值结果
func parseFactor() -> num
{
    if (not hasMoreTokens())
    {
        err! "Unexpected end of expression"
    }

    set tok: str = peekToken()

    if (tok == "+")
    {
        advanceToken()
        set val: num = parseFactor()
        return val
    }

    if (tok == "-")
    {
        advanceToken()
        set val_neg: num = parseFactor()
        return 0 - val_neg
    }

    if (tok == "(")
    {
        advanceToken()
        set inner: num = parseExpr()

        if (not hasMoreTokens())
        {
            err! "Missing closing parenthesis"
        }

        set closing: str = peekToken()

        if (closing ~= ")")
        {
            err! "Missing closing parenthesis"
        }

        advanceToken()
        return inner
    }

    advanceToken()
    set num_val: num = %num%tok
    return num_val
}

# Description: 解析项：处理 * /
# Return: 数值结果
func parseTerm() -> num
{
    set value: num = parseFactor()

    while (hasMoreTokens())
    {
        set op: str = peekToken()

        if (op == "*")
        {
            advanceToken()
            set rhs: num = parseFactor()
            set value = value * rhs
        }
        elif (op == "/")
        {
            advanceToken()
            set rhs: num = parseFactor()

            if (rhs == 0)
            {
                err! "Divide by zero"
            }

            set value = value / rhs
        }
        else
        {
            break
        }
    }

    return value
}

# Description: 解析表达式：处理 + -
# Return: 数值结果
func parseExpr() -> num
{
    set value: num = parseTerm()

    while (hasMoreTokens())
    {
        set op: str = peekToken()

        if (op == "+")
        {
            advanceToken()
            set rhs: num = parseTerm()
            set value = value + rhs
        }
        elif (op == "-")
        {
            advanceToken()
            set rhs: num = parseTerm()
            set value = value - rhs
        }
        else
        {
            break
        }
    }

    return value
}

; ==============================
; 表达式求值封装
; ==============================

# Description: 对输入表达式进行分词、解析并输出结果
# Param [expr]: 表达式字符串
proc evalExpression(expr: str)
{
    set g_tokens = tokenize(expr)
    set g_tok_len = @g_tokens
    set g_pos = 0

    set result: num = parseExpr()

    if (g_pos < g_tok_len)
    {
        err! "Unexpected token after valid expression"
    }

    set result_text: str = %str%result
    echo `= {result_text}`
}

; ==============================
; 主流程：交互式 REPL
; ==============================

# Description: 交互式四则计算器主入口
proc main()
{
    echo "Interactive Calculator (type q to quit)"
    echo "Supports + - * /, parentheses, unary +/-"

    loop
    {
        set expr: str = getin "calc>>"

        if (expr == "q")
        {
            break
        }

        if (expr == "")
        {
            continue
        }

        evalExpression(expr)
    }

    echo "Bye."
}

; 入口调用
main()
```

### 学生成绩管理系统  

```batscript
# Description: 学生成绩管理系统（使用 SimpKv 持久化，分号分隔列表）
# Author: ChatGPT
# Date: 2026-04-01
# File: StudentGradeSystem.bs
# Version: 1.0.0

lib SimpKv

; --------------------------------
; 全局配置
; --------------------------------
set storage_file: str = "students.db" ; 供 SimpKv 若需要外部配置时使用

; --------------------------------
; 校验与工具函数
; --------------------------------

# Description: 判断字符串是否非空
# Param [v]: 待检测字符串
# Return: 非空返回 True，否则 False
func isNonEmpty(v: str) -> bool
{
    return ?v
}

# Description: 检查名称（学生名或科目）是否合法：非空且不含 ';' 或 '='
# Param [name]: 待检测名称
# Return: 合法返回 True
func isValidName(name: str) -> bool
{
    if (not ?name)
    {
        return False
    }

    iterate (name) => ch
    {
        if (ch == ";" or ch == "=")
        {
            return False
        }
    }

    return True
}

# Description: 检查成绩文本是否格式合法（仅数字与可选一个小数点，最多两位小数）
# Param [txt]: 成绩原始输入
# Return: 合法返回 True
func isValidScoreText(txt: str) -> bool
{
    if (not ?txt)
    {
        return False
    }

    set dot_count: num = 0
    set digit_count: num = 0
    set dec_len: num = 0
    set after_dot: bool = False

    iterate (txt) => ch
    {
        if (ch == ".")
        {
            if (dot_count >= 1)
            {
                return False
            }
            set dot_count = dot_count + 1
            set after_dot = True
        }
        elif (ch >= "0" and ch <= "9")
        {
            set digit_count = digit_count + 1

            if (after_dot)
            {
                set dec_len = dec_len + 1
                if (dec_len > 2)
                {
                    return False
                }
            }
        }
        else
        {
            return False
        }
    }

    if (digit_count == 0)
    {
        return False
    }

    ; 仅 "." 不允许
    if (digit_count > 0 and dot_count == 1 and dec_len == 0)
    {
        return False
    }

    ; 范围检查
    set val: num = %num%txt
    if (val < 0 or val > 100)
    {
        return False
    }

    return True
}

# Description: 将合法的成绩文本转为数值
# Param [txt]: 已通过格式校验的成绩文本
# Return: 数值成绩
func toScore(txt: str) -> num
{
    if (not isValidScoreText(txt))
    {
        err "Score format invalid (0-100, up to 2 decimals)"
    }

    set val: num = %num%txt
    return val
}

# Description: 按单字符分隔符切分字符串
# Param [src]: 原串
# Param [sep]: 单字符分隔符
# Return: 切分结果数组
func splitStrByChar(src: str, sep: str) -> arr<str>
{
    set result: arr<str> = []
    set n: num = @src
    set start: num = 0
    set i: num = 0

    while (i < n)
    {
        set next_i: num = i + 1
        set ch: str = src[i:next_i]

        if (ch == sep)
        {
            set segment: str = src[start:i]
            result^ segment
            set start = i + 1
        }

        set i = i + 1
    }

    set tail: str = src[start:n]
    result^ tail

    return result
}

# Description: 用分隔符拼接字符串数组
# Param [items]: 字符串数组
# Param [sep]: 分隔符
# Return: 拼接后的字符串
func joinArrWithSep(items: arr<str>, sep: str) -> str
{
    set total: num = @items
    if (total == 0)
    {
        return ""
    }

    set idx: num = 0
    set acc: str = items[0]
    set idx = 1

    while (idx < total)
    {
        set acc = acc .. sep .. items[idx]
        set idx = idx + 1
    }

    return acc
}

# Description: 判断学生是否存在（依据存储记录）
# Param [name]: 学生名
# Return: 存在返回 True
func studentExists(name: str) -> bool
{
    set key: str = "student:" .. name
    set val: str? = SimpKv.get(key)
    if (?val and val ~= "")
    {
        return True
    }
    return False
}

; --------------------------------
; 存储操作封装
; --------------------------------

# Description: 读取学生原始记录（"科目=分数"以分号分隔）
# Param [name]: 学生名
# Return: 记录字符串，若无则空串
func loadStudentRaw(name: str) -> str
{
    set key: str = "student:" .. name
    set val: str? = SimpKv.get(key)

    if (?val)
    {
        return val
    }

    return ""
}

# Description: 保存学生原始记录
# Param [name]: 学生名
# Param [data]: 记录串
proc saveStudentRaw(name: str, data: str)
{
    set key: str = "student:" .. name
    SimpKv.set(key, data)
}

# Description: 获取学生的科目-成绩对数组（形如 ["Math=95", ...]）
# Param [name]: 学生名
# Return: 数组，若无记录则空数组
func getStudentPairs(name: str) -> arr<str>
{
    set raw: str = loadStudentRaw(name)

    if (not ?raw)
    {
        set empty_arr: arr<str> = []
        return empty_arr
    }

    set pairs: arr<str> = splitStrByChar(raw, ";")
    set cleaned: arr<str> = []
    set i: num = 0
    set n: num = @pairs

    while (i < n)
    {
        set p: str = pairs[i]
        if (?p)
        {
            cleaned^ p
        }
        set i = i + 1
    }

    return cleaned
}

# Description: 保存科目-成绩对数组
# Param [name]: 学生名
# Param [pairs]: 形如 ["Math=95", ...]
proc saveStudentPairs(name: str, pairs: arr<str>)
{
    set data: str = ""
    if (@pairs > 0)
    {
        set data = joinArrWithSep(pairs, ";")
    }
    saveStudentRaw(name, data)
}

# Description: 更新/追加学生列表（全局 key "students"）
# Param [name]: 学生名
proc upsertStudentList(name: str)
{
    set list_raw: str? = SimpKv.get("students")
    if (not ?list_raw or list_raw == "")
    {
        SimpKv.set("students", name)
        return
    }

    set names: arr<str> = splitStrByChar(list_raw, ";")
    set found: bool = False
    set i: num = 0
    set n: num = @names

    while (i < n)
    {
        set nm: str = names[i]
        if (nm == name)
        {
            set found = True
            break
        }
        set i = i + 1
    }

    if (not found)
    {
        names^ name
        set updated: str = joinArrWithSep(names, ";")
        SimpKv.set("students", updated)
    }
}

# Description: 从学生列表中删除指定学生
# Param [name]: 学生名
proc removeStudentFromList(name: str)
{
    set list_raw: str? = SimpKv.get("students")
    if (not ?list_raw or list_raw == "")
    {
        return
    }

    set names: arr<str> = splitStrByChar(list_raw, ";")
    set new_names: arr<str> = []
    set i: num = 0
    set n: num = @names

    while (i < n)
    {
        set nm: str = names[i]
        if (nm ~= name and ?nm)
        {
            new_names^ nm
        }
        set i = i + 1
    }

    set updated: str = ""
    if (@new_names > 0)
    {
        set updated = joinArrWithSep(new_names, ";")
    }

    SimpKv.set("students", updated)
}

# Description: 删除学生记录（置空）
# Param [name]: 学生名
proc deleteStudentRecord(name: str)
{
    saveStudentRaw(name, "")
}

; --------------------------------
; 业务逻辑
; --------------------------------

# Description: 设置或更新某学生某科目成绩
# Param [name]: 学生名
# Param [subject]: 科目名
# Param [score_txt]: 成绩文本
proc setSubjectScore(name: str, subject: str, score_txt: str)
{
    set _ = toScore(score_txt) ; 确保合法

    set pairs: arr<str> = getStudentPairs(name)
    set updated: arr<str> = []
    set replaced: bool = False
    set i: num = 0
    set n: num = @pairs

    while (i < n)
    {
        set p: str = pairs[i]
        ; 拆分 p 为 sub=val
        set eq_idx: num = -1
        set j: num = 0
        set m: num = @p

        while (j < m)
        {
            set jj: num = j + 1
            set ch: str = p[j:jj]
            if (ch == "=")
            {
                set eq_idx = j
                break
            }
            set j = j + 1
        }

        if (eq_idx >= 0)
        {
            set sub: str = p[0:eq_idx]
            set val: str = p[eq_idx + 1:m]

            if (sub == subject)
            {
                set new_pair: str = subject .. "=" .. score_txt
                updated^ new_pair
                set replaced = True
            }
            else
            {
                updated^ p
            }
        }

        set i = i + 1
    }

    if (not replaced)
    {
        set new_pair_2: str = subject .. "=" .. score_txt
        updated^ new_pair_2
    }

    saveStudentPairs(name, updated)
    upsertStudentList(name)
}

# Description: 查询并输出某学生全部科目成绩及平均分
# Param [name]: 学生名
proc queryStudent(name: str)
{
    if (not studentExists(name))
    {
        echo "学生不存在"
        return
    }

    set pairs: arr<str> = getStudentPairs(name)
    set total: num = @pairs

    echo `学生: {name}`

    if (total == 0)
    {
        echo "无成绩记录"
        return
    }

    set sum_score: num = 0
    set i: num = 0

    while (i < total)
    {
        set p: str = pairs[i]
        set eq_idx: num = -1
        set j: num = 0
        set m: num = @p

        while (j < m)
        {
            set jj: num = j + 1
            set ch: str = p[j:jj]
            if (ch == "=")
            {
                set eq_idx = j
                break
            }
            set j = j + 1
        }

        if (eq_idx >= 0)
        {
            set sub: str = p[0:eq_idx]
            set val_txt: str = p[eq_idx + 1:m]
            set val_num: num = %num%val_txt
            set val_txt_out: str = val_txt
            echo `  {sub}: {val_txt_out}`
            set sum_score = sum_score + val_num
        }

        set i = i + 1
    }

    set avg: num = sum_score / %num%total
    set avg_txt: str = %str%avg
    echo `平均分: {avg_txt}`
}

# Description: 列出所有学生
proc listStudents()
{
    set list_raw: str? = SimpKv.get("students")

    if (not ?list_raw or list_raw == "")
    {
        echo "当前无学生记录"
        return
    }

    set names: arr<str> = splitStrByChar(list_raw, ";")
    set i: num = 0
    set n: num = @names
    set shown: bool = False

    while (i < n)
    {
        set nm: str = names[i]
        if (?nm)
        {
            echo nm
            set shown = True
        }
        set i = i + 1
    }

    if (not shown)
    {
        echo "当前无学生记录"
    }
}

# Description: 添加或确保学生存在（仅创建空记录）
proc addStudent()
{
    set name: str = getin "学生姓名>>"

    if (not isValidName(name))
    {
        err "姓名不能为空且不能含 ';' 或 '='"
    }

    if (not studentExists(name))
    {
        saveStudentPairs(name, [])
        upsertStudentList(name)
        echo "已创建学生"
    }
    else
    {
        echo "学生已存在（未作更改）"
    }
}

# Description: 录入或更新某科目成绩
proc inputScore()
{
    set name: str = getin "学生姓名>>"

    if (not isValidName(name))
    {
        err "姓名不能为空且不能含 ';' 或 '='"
    }

    if (not studentExists(name))
    {
        echo "学生不存在，自动创建空记录"
        saveStudentPairs(name, [])
        upsertStudentList(name)
    }

    set subject: str = getin "科目>>"

    if (not isValidName(subject))
    {
        err "科目不能为空且不能含 ';' 或 '='"
    }

    set score_txt: str = getin "成绩(0-100,至多两位小数)>>"

    if (not isValidScoreText(score_txt))
    {
        err "成绩格式非法"
    }

    setSubjectScore(name, subject, score_txt)
    echo "已保存成绩"
}

# Description: 删除学生及其成绩
proc deleteStudent()
{
    set name: str = getin "学生姓名>>"

    if (not studentExists(name))
    {
        echo "学生不存在"
        return
    }

    removeStudentFromList(name)
    deleteStudentRecord(name)
    echo "已删除"
}

# Description: 菜单显示
proc showMenu()
{
    echo ""
    echo "==== 学生成绩管理系统 ===="
    echo "1) 添加学生"
    echo "2) 录入/更新成绩"
    echo "3) 查询学生成绩"
    echo "4) 列出所有学生"
    echo "5) 删除学生"
    echo "6) 退出"
}

# Description: 主流程
proc main()
{
    loop
    {
        showMenu()
        set choice: str = getin "选择>>"

        if (choice == "1")
        {
            addStudent()
        }
        elif (choice == "2")
        {
            inputScore()
        }
        elif (choice == "3")
        {
            set name_q: str = getin "学生姓名>>"
            queryStudent(name_q)
        }
        elif (choice == "4")
        {
            listStudents()
        }
        elif (choice == "5")
        {
            deleteStudent()
        }
        elif (choice == "6")
        {
            echo "已退出"
            break
        }
        else
        {
            echo "无效选项"
        }
    }
}

; 入口
main()
```

### 和原生BAT的内嵌结合  

```batscript
# Description: 演示 batScript 与原生 BAT 内嵌结合（runraw 与 $|）
# Author: ChatGPT
# Date: 2026-04-01
# File: NativeBridge.bs
# Version: 1.0.0

# Description: 演示如何将 batScript 变量传入原生 BAT，并在 runraw 中使用
proc showNativeInterop()
{
    ; 准备一个数值变量
    set counter: num = 42
    ; 取得编译后原生变量名（不含 %），用于 BAT 段展开
    set counter_raw: str = $|counter

    echo "=== batScript 部分 ==="
    set counter_txt: str = %str%counter
    echo `counter (batScript) = {counter_txt}`

    ; 单行 runraw 示例
    runraw: "echo [BAT] single-line runraw reached."

    ; 块状 runraw 示例（可混合字符串与变量片段）
    runraw
    {
        "@echo off",
        "echo --- Native BAT block start ---",
        "echo Working dir (BAT):",
        "cd",
        "echo.",
        "echo 通过原生 BAT 展开 batScript 变量：",
        "echo counter = %", counter_raw, "%",
        "echo.",
        "echo 当前目录列表 (BAT dir):",
        "dir",
        "echo --- Native BAT block end ---"
    }
}

# Description: 主入口
proc main()
{
    showNativeInterop()
    echo "Back in batScript after runraw."
}

; 入口调用
main()
```

### 其它语法综合参照  

```batscript
# Description: batScript 其它语法综合示例（覆盖此前未重点展示的特性）
# Author: ChatGPT
# Date: 2026-04-01
# File: OtherSyntaxDemo.bs
# Version: 1.0.0

; =====================================================
; 组与文档注释示例
; =====================================================

# Description: 演示全局分组与常量
# Author: ChatGPT
group DemoGroup
{
    set greeting_prefix: str = "Hi"
    let MAX_NAME_LEN: num = 12
}

; =====================================================
; 约束函数（match 绑定用）
; =====================================================

# Description: 检查数值是否非负
# Param [v]: 待校验的数值
# Return: 非负返回 True
func isNonNegative(v: num) -> bool
{
    return v >= 0
}

# Description: 检查字符串是否非空且长度不超过给定上限
# Param [v]: 待校验字符串
# Param [limit]: 长度上限
# Return: 合规返回 True
func isShorterThan(v: str, limit: num) -> bool
{
    if (not ?v)
    {
        return False
    }

    if (@v <= limit)
    {
        return True
    }

    return False
}

; =====================================================
; 辅助过程
; =====================================================

# Description: 安全输出类型字符串
# Param [label]: 名称标签
# Param [val_type]: 类型字符串
proc showType(label: str, val_type: str)
{
    echo `type({label}) = {val_type}`
}

# Description: 输出分节标题
# Param [title]: 标题
proc section(title: str)
{
    echo ""
    echo "----"
    echo title
    echo "----"
}

; =====================================================
; 主流程
; =====================================================

# Description: 主流程，覆盖配置信号、切片、pair 取位、! 对调、约束等特性
proc main()
{
    ; ---------- 配置 conf 示例 ----------
    ; 运行时若传入 /d 则输出调试提示（例如：MyScript.bat /d）
    if (conf d): echo "Debug flag /d detected"

    section("match 约束绑定")
    ; 绑定后，每次赋值都会自动校验；初始值需符合约束
    set balance: num = 0 match isNonNegative(balance)
    set balance_text: str = %str%balance
    echo `balance = {balance_text}`

    ; 读取一次存款金额演示（需输入合法数字）
    set deposit_raw: str = getin "Deposit amount (num)>=0 >>"
    set deposit_val: num = %num%deposit_raw
    set balance = balance + deposit_val
    set balance_text = %str%balance
    echo `balance updated = {balance_text}`

    section("group 与常量/变量访问")
    echo `greeting_prefix = {DemoGroup.greeting_prefix}`
    set max_len_text: str = %str%DemoGroup.MAX_NAME_LEN
    echo `MAX_NAME_LEN = {max_len_text}`

    section("可空类型与 Nil/Inf")
    set maybe_score: num? = Nil
    if (?maybe_score)
    {
        set score_txt: str = %str%maybe_score
        echo `score = {score_txt}`
    }
    else
    {
        echo "maybe_score is Nil, assign default 95"
        set maybe_score = 95
        set score_txt = %str%maybe_score
        echo `score = {score_txt}`
    }

    set infinite_val: num = Inf
    set inf_type: str = &infinite_val
    showType("infinite_val", inf_type)
    if (infinite_val == Inf): echo "Inf comparison works"

    section("数组追加/删除/切片/负索引")
    set nums: arr<num> = [1, 2, 3, 4]
    nums^ 5                  ; 追加
    ^nums 1                  ; 删除下标 1 的元素（不返回值）
    ^nums                    ; 删除末尾
    ; 此时 nums 为 [1,3,4]
    set last_num: num = nums[-1]
    set last_num_txt: str = %str%last_num
    echo `last_num = {last_num_txt}`
    set slice_nums: arr<num> = nums[0:2]   ; 取前两项
    set slice_len_txt: str = %str%@slice_nums
    echo `slice_len = {slice_len_txt}`

    section("字符串切片与反转")
    set word: str = "batScript"
    set part: str = word[3:9]      ; 期望 "Script"
    set word_rev: str = !word      ; 反转
    echo `part = {part}`
    echo `word_rev = {word_rev}`

    section("pair 取位与对调 !pair")
    set p: pair<num, str> = (7, "ok")
    set first_val: num = ^p
    set second_val: str = p^
    set first_txt: str = %str%first_val
    echo `first = {first_txt}`
    echo `second = {second_val}`
    set swapped: pair<str, num> = !p
    set swapped_first: str = ^swapped
    set swapped_second: num = swapped^
    set swapped_second_txt: str = %str%swapped_second
    echo `swapped_first = {swapped_first}`
    echo `swapped_second = {swapped_second_txt}`

    section("类型字符串运算符 & 与原始变量名 $|")
    set t_balance: str = &balance
    showType("balance", t_balance)
    set raw_name_balance: str = $|balance
    echo `raw var name of balance = {raw_name_balance}`

    section("b-string 插值仅变量（演示转换）")
    set len_word: num = @word
    set len_word_txt: str = %str%len_word
    echo `len(word) = {len_word_txt}`

    section("condition 正确用法（仅值分支、单行）")
    set op: str = getin "Choose op (+/-/other)>>"
    condition op
    {
        "+": echo "add selected"
        "-": echo "sub selected"
        /: echo "other selected"
    }

    section("loop => 计次变量示意（只做有限演示后 break）")
    set limit: num = 3
    set tick: num = 0
    loop => i
    {
        set tick = tick + 1
        set i_txt: str = %str%i
        echo `loop i = {i_txt}`
        if (tick >= limit)
        {
            break
        }
    }

    echo ""
    echo "Demo finished."
}

; 入口
main()
```
