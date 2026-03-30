# `batScript`

***[English](README.md)***  

`batScript`是一个**强类型, 结构化的转译语言**, 以`.bs`作为后缀名.  
就和`JavaScript`转译为`TypeScript`一样, `batScript`转译`.bs`至`.bat`, 为陈旧简陋的`.bat`脚本带来了:  

- 合理的命名规范和使用: 批处理原生的语法简陋怪异, `batScript`提供贴近正常语言的关键字和标识符设计.  
- 类型系统: 提供两种基本类型(`num`, `bool`), 一种组合类型(`pair`)和两种可迭代类型(`str`, `arr`).  
- 正常的控制流: `if-else-elif`基本选择分支, `while`, `loop`基本循环分支, 以及延展的`match-condition`状态机选择分支和`iterate`可迭代体循环分支, 及`loop`, `repeat`, `circle`语法糖.  
- 函数和过程. 分别通过`func`和`proc`声明, 强类型, 支持递归.  
- 现代的运算符. 主要运算符符合现代语言习惯, 以及和`BAT`契合的特别运算符, 如取原始运算符`$|`.  
- 基本的包管理. `pkg`导入包, `lib`导入库, 以及`bspm`包管理器.  
- 其它语法扩展. 包括最基础的异常`err`, 输入输出`echo`和`getin`等, 原生`BAT`运行`runraw`, 成组`group`等.  

以下是使用`batScript`编写的HelloWorld程序示例:  

```batscript
# Description: batScript HelloWorld示例程序
# Author: WaterRun
# Date: 2026-03-30
# File: helloWorld.bs

echo "HelloWorld!"
```

从[这里]()开始阅读完整文档.  

## 速览  

### 编译器命令  

```cmd
bsc -Version :: 输出版本
bsc -Compile -Input input_file -Output output_file :: 执行编译
bsc -Check -File check_file :: 检查代码
```

### 包管理器命令  

```cmd
bspm /v :: 输出版本
bspm /s search_name :: 搜索库
bspm /i package_name :: 安装库
bspm /u package_name :: 卸载库
bspm /l match_name :: 列出本地库
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
| `conf`       | 配置值           |
| `if`         | 如果             |
| `elif`       | 或者如果         |
| `else`       | 或者             |
| `match`      | 匹配             |
| `condition`  | 匹配条件         |
| `while`      | 基本循环         |
| `loop`       | 无限循环         |
| `repeat`     | 次数循环         |
| `iterate`    | 可迭代体循环     |
| `circle`     | 可迭代体轮转循环 |
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
