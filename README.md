# `batScript`

***[中文](README.zh.md)***

`batScript` is a **strongly-typed, structured transpiled language** with `.bs` as its file extension.
Just as `TypeScript` transpiles down to `JavaScript`, `batScript` transpiles `.bs` to `.bat`, bringing modern capabilities to the outdated and primitive `.bat` scripting:

- **Reasonable naming conventions and usage**: Batch's native syntax is crude and awkward. `batScript` provides keywords and identifiers designed to feel natural, like those of a normal programming language.
- **Type system**: Provides two primitive types (`num`, `bool`), one composite type (`pair`), and two iterable types (`str`, `arr`).
- **Normal control flow**: `if-else-elif` basic conditional branching, `while` and `loop` basic loop constructs, as well as the extended `match-condition` state machine branching and `iterate` iterable loops, with `repeat` and `circle` as additional syntactic sugar.
- **Functions and procedures**: Declared with `func` and `proc` respectively, strongly typed, with full recursion support.
- **Modern operators**: Core operators follow modern language conventions, alongside special operators tailored for `BAT` compatibility, such as the raw value operator `$|`.
- **Basic package management**: `pkg` for file imports, `lib` for library imports, and the `bspm` package manager.
- **Other syntax extensions**: Including basic exception handling with `err`, I/O via `echo` and `getin`, native `BAT` embedding through `runraw`, grouping with `group`, and more.

The following is a HelloWorld program written in `batScript`:

```batscript
# Description: batScript HelloWorld example
# Author: WaterRun
# Date: 2026-03-30
# File: helloWorld.bs

echo "HelloWorld!"
```

Read the full documentation [here]().

## Quick Overview

### Compiler Commands

```cmd
bsc -Version                              :: Output version
bsc -Compile -Input input_file -Output output_file  :: Compile
bsc -Check -File check_file               :: Check code
```

### Package Manager Commands

```cmd
bspm /v                  :: Output version
bspm /s search_name      :: Search for a library
bspm /i package_name     :: Install a library
bspm /u package_name     :: Uninstall a library
bspm /l match_name       :: List local libraries
```

### Keywords and Symbols

| Symbol       | Description                |
|--------------|----------------------------|
| `set`        | Declare variable           |
| `let`        | Declare immutable variable |
| `num`        | Number type                |
| `bool`       | Boolean type               |
| `str`        | String type                |
| `arr`        | One-dimensional array type |
| `pair`       | Key-value pair type        |
| `conf`       | Configuration value        |
| `if`         | If                         |
| `elif`       | Else if                    |
| `else`       | Else                       |
| `match`      | Match                      |
| `condition`  | Match condition            |
| `while`      | Basic loop                 |
| `loop`       | Infinite loop              |
| `repeat`     | Count-based loop           |
| `iterate`    | Iterable loop              |
| `circle`     | Iterable rotation loop     |
| `func`       | Function                   |
| `proc`       | Procedure                  |
| `return`     | Return value               |
| `pkg`        | File import                |
| `lib`        | Package import             |
| `runraw`     | Native embedding           |
| `err`        | Throw exception            |
| `endprogram` | Terminate program          |
| `pause`      | Pause                      |
| `getin`      | Input stream               |
| `echo`       | Output                     |
| `group`      | Grouping                   |
| `+`          | Addition                   |
| `-`          | Subtraction                |
| `*`          | Multiplication             |
| `/`          | Division                   |
| `>`          | Greater than               |
| `>=`         | Greater than or equal to   |
| `==`         | Equal to                   |
| `~=`         | Not equal to               |
| `<`          | Less than                  |
| `<=`         | Less than or equal to      |
| `=`          | Assignment                 |
| `!`          | Negation                   |
| `?`          | Null check                 |
| `&`          | Get type string            |
| `@`          | Get iterable length        |
| `..`         | Iterable concatenation     |
| `^`          | Iterable index value       |
| `$\|`        | Get raw value              |
| `True`       | True value                 |
| `False`      | False value                |
| `Nil`        | Null value                 |
| `Inf`        | Infinite value             |

### Standard Library Overview

| Library    | Description          | Representative Methods / Literals                                                   |
|------------|----------------------|-------------------------------------------------------------------------------------|
| `Math`     | Mathematics          | `abs()` `min()` `max()` `sqrt()` `random` `floor()` `ceil()` `round()` `pow()` `PI` |
| `Cmd`      | Console control      | `setColor()` `setTitle()` `restartInAdmin()`                                        |
| `Tools`    | System tools         | `diskpart()` `ping()` `ipconfig()` `whoami()`                                       |
| `Windows`  | Operating system     | `version()` `getEnv()` `setEnv()`                                                   |
| `Admin`    | Administrator access | `isAdmin()` `requireAdmin()` `relaunchAsAdmin` `sudo()`                             |
| `Iterable` | Iterable utilities   | `arrIndexOf()` `strContain()`                                                       |

### Other Syntax Overview

- `#`: Embedded documentation
- `;`: Comment
- `"\n"`: String escape sequence
- `''`: Raw string literal
- `` `Hello {hello_val}` ``: b-string
- `[1, 2, 3, 4][2:3]`: Array slicing
- `{`, `}`: Code block delimiters
- `if (a > b) :`: Single-line statement
- `func (a: num, b: str) -> bool`: Function declaration
