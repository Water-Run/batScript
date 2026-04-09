# `batScript`

***[中文](README-zh.md)***

`batScript` is a **strongly-typed, structured transpilation language** with `.bs` as its file extension.
Just as `JavaScript` transpiles to `TypeScript`, `batScript` transpiles `.bs` files to `.bat`, bringing to the old and primitive `.bat` scripts:

- Reasonable naming conventions and usage: Native batch scripting syntax is primitive and quirky; `batScript` provides keyword and identifier designs that are closer to normal languages.
- Type system: Provides three unit types, including two primitive types (`num`, `bool`) and one composite type (`pair`), as well as two iterable types (`str`, `arr`). Variables are case-sensitive.
- Normal control flow: `if-else-elif` basic conditional branching, `while` and `loop` basic loop constructs, as well as the extended `condition` state-machine branching and `iterate` iterable loop, plus `loop`, `repeat`, and `circle` syntactic sugar. Control flow keywords do not require parentheses around conditions.
- Functions and procedures: Declared via `func` and `proc` respectively, strongly typed, and support recursion.
- Modern operators: Major operators follow modern language conventions, along with special operators suited to `BAT`, such as the raw-value operator `$|`.
- Basic package management: `pkg` for file imports, `lib` for library imports, `lib*` to unpack a library into the current scope, and the `bspm` package manager.
- Structured namespaces: `group` declares data groups, supporting single-line shorthand and `func`/`proc` method binding syntax.
- Script-specific syntax, such as `conf` configuration and `match` constraints.
- Other syntax extensions: Including basic exceptions via `err`, I/O via `echo` and `getin`, native `BAT` execution via `runraw`, grouping via `group`, and more.

Start reading the full documentation [here](./doc/en/guide/01-introducing-batScript.md).

## Overview

### Compiler Commands

```cmd
bsc -Version :: print version
bsc -Compile input_file -Output output_file :: compile
bsc -Check -File check_file :: check code
```

Example:

```cmd
bsc -Compile MyScript.bs -Output MyScript.bat
```

### Package Manager Commands

```cmd
bspm /v :: print version
bspm /s search_name :: search library
bspm /i package_name :: install library
bspm /u package_name :: uninstall library
bspm /l match_name :: list local libraries
```

Example:

```cmd
bspm /i BatKV /c ">=1.0"
```

### Keyword and Symbol Table

| Symbol       | Description                                                 |
|--------------|-------------------------------------------------------------|
| `set`        | Declare variable                                            |
| `let`        | Declare immutable variable                                  |
| `num`        | Numeric type                                                |
| `bool`       | Boolean type                                                |
| `str`        | String type                                                 |
| `arr`        | One-dimensional array type                                  |
| `pair`       | Key-value pair type                                         |
| `match`      | Constraint                                                  |
| `if`         | If                                                          |
| `elif`       | Else if                                                     |
| `else`       | Else                                                        |
| `condition`  | Match condition                                             |
| `while`      | Basic loop                                                  |
| `loop`       | Infinite loop                                               |
| `repeat`     | Count loop                                                  |
| `iterate`    | Iterable loop                                               |
| `circle`     | Iterable circular loop                                      |
| `break`      | Break loop                                                  |
| `continue`   | Continue loop                                               |
| `and`        | And                                                         |
| `or`         | Or                                                          |
| `not`        | Not                                                         |
| `func`       | Function                                                    |
| `proc`       | Procedure                                                   |
| `return`     | Return value                                                |
| `pkg`        | File import                                                 |
| `lib`        | Package import                                              |
| `lib*`       | Unpacked import (expand library namespace to current scope) |
| `runraw`     | Native inline                                               |
| `err`        | Throw exception                                             |
| `endprogram` | Terminate program                                           |
| `pause`      | Pause                                                       |
| `getin`      | Input stream read                                           |
| `echo`       | Output                                                      |
| `group`      | Group                                                       |
| `conf`       | Configuration item                                          |
| `+`          | Addition                                                    |
| `-`          | Subtraction                                                 |
| `*`          | Multiplication                                              |
| `/`          | Division                                                    |
| `>`          | Greater than                                                |
| `>=`         | Greater than or equal to                                    |
| `==`         | Equal to                                                    |
| `~=`         | Not equal to                                                |
| `<`          | Less than                                                   |
| `<=`         | Less than or equal to                                       |
| `=`          | Assignment                                                  |
| `%%`         | Type cast                                                   |
| `!`          | Negate / Reverse                                            |
| `?`          | Null check                                                  |
| `&`          | Get type string                                             |
| `@`          | Get iterable length                                         |
| `..`         | Iterable concatenation                                      |
| `^`          | Iterable index value                                        |
| `$\|`        | Get raw                                                     |
| `True`       | True value                                                  |
| `False`      | False value                                                 |
| `Nil`        | Null value                                                  |
| `Inf`        | Infinite value                                              |

### Standard Library Overview

| Library    | Description      | Representative Methods/Literals                                                     |
|------------|------------------|-------------------------------------------------------------------------------------|
| `Math`     | Mathematics      | `abs()` `min()` `max()` `sqrt()` `random` `floor()` `ceil()` `round()` `pow()` `PI` |
| `Cmd`      | Console          | `setColor()` `setTitle()` `restartInAdmin()`                                        |
| `Tools`    | System Tools     | `diskpart()` `ping()` `ipconfig()` `whoami()`                                       |
| `Windows`  | Operating System | `version()` `getEnv()` `setEnv()`                                                   |
| `Admin`    | Administrator    | `isAdmin()` `requireAdmin()` `relaunchAsAdmin` `sudo()`                             |
| `Iterable` | Iterable         | `arrIndexOf()` `strContain()`                                                       |

Using `lib*` expands a library's namespace into the current file, allowing the prefix to be omitted on subsequent calls. For example, after `lib* Math`, `PI`, `abs()`, `sqrt()`, etc. can be used directly; with `lib Math`, the `Math.abs()` prefix is still required.

### Other Syntax Overview

- `#`: Embedded documentation
- `;`: Comment
- `"\n"`: String escape
- `''`: Raw string
- `` `Hello {hello_val}` ``: b-string
- `[1, 2, 3, 4][2:3]`: Array slice
- `{`, `}`: Code block delimiter
- `if a > b :`: Single-line statement (control flow keywords do not require parentheses around conditions)
- `func myFunc(a: num, b: str) -> bool`: Function declaration
- `lib* Math`: Unpacked import; `PI`, `abs()`, etc. directly available
- `group MyGroup { let X: num = 1 }`: Single-line group declaration
- `func MyGroup.myFunc(a: num) -> num` / `proc MyGroup.myProc()`: Group method binding

### Coding Conventions

- File: PascalCase.bs
- Variable: lowercase_with_underscores
- Constant: UPPER_CASE_WITH_UNDERSCORES
- Function and procedure: camelCase
- Group name: PascalCase
- Group method name: camelCase
- Config name: Each word capitalized, connected with underscores
- AllMan style braces
- Write doc comments for all files, groups, functions, and procedures

## Sample Programs

### HelloWorld

The most basic example, demonstrating output and console initialization.

```batscript
# Description: batScript HelloWorld sample program
# Author: WaterRun
# Date: 2026-03-30
# File: HelloWorld.bs

lib Cmd  ; import console library

Cmd.setTitle("batScript Demo")
Cmd.setColor("0A")  ; black background, bright green text

echo "HelloWorld!"
```

### Type System

The following demonstrates the various basic types and their usage in batScript, and introduces the `lib* Math` unpack example.

```batscript
# Description: batScript type system sample program
# Author: WaterRun
# Date: 2026-04-01
# File: Types.bs

lib* Math  ; unpack Math: PI, abs(), sqrt() etc. directly available

; constants
let MAX_COUNT: num = 128
let max_count: num = 64  ; separate variable from MAX_COUNT, case-sensitive

; string type
set name_1: str = "Alice"
set name_2 = "Bol"
set name_3: str? = "Siri"

; numeric type
set age_1: num = 20
set age_2 = 22.5
set age_3: num? = Nil

; boolean type
set is_alive_1: bool = True
set is_alive_2: bool = False
set is_alive_3: bool? = Nil

; array type
set scores: arr<num> = [90, 88.5, 100]
set names: arr<str> = ["Alice", "Bol", "Siri"]

; pair type
set name_age_pair_1: pair<str, num> = (name_1, age_1)
set name_age_pair_2: pair<str, num?> = (name_3, age_3)
set name_age_pair_3: pair<str, num>? = Nil

; unary and length
set name_1_len: num = @name_1
set name_1_rev: str = !name_1

; concatenation
set greeting: str = "Hello, " .. name_1

; type cast
set age_1_text: str = %str%age_1
set name_1_len_text: str = %str%name_1_len
set scores_len: num = @scores
set scores_len_text: str = %str%scores_len

; direct calls after lib* Math unpack
set dist: num = abs(age_1 - 100)          ; no need for Math.abs()
set root: num = sqrt(scores_len)           ; no need for Math.sqrt()
set area: num = PI * 5 * 5                 ; PI directly available
set dist_text: str = %str%dist
set root_text: str = %str%root
set area_text: str = %str%area

echo greeting
echo `age_1        = {age_1_text}`
echo `name_1_len   = {name_1_len_text}`
echo `scores_len   = {scores_len_text}`
echo `name_1_rev   = {name_1_rev}`
echo `abs(age-100) = {dist_text}`
echo `sqrt(len)    = {root_text}`
echo `PI*5^2       = {area_text}`
```

### Control Flow Example

```batscript
# Description: batScript control flow sample program (with detailed comments)
# Author: WaterRun
# Date: 2026-04-01
# File: ControlFlow.bs
# Version: 1.0.1

lib Cmd

; ==============================
; global constants (single-line group)
; ==============================

group Constants { let DEFAULT_NAME: str = "Guest"; let MAX_CIRCLE_STEPS: num = 5 }

; ==============================
; utility functions and procedures
; ==============================

# Description: Check if a string is non-empty
# Param [v]: string to check
# Return: True if non-empty, False otherwise
func isNonEmpty(v: str) -> bool
{
    return ?v
}

# Description: Print a section title
# Param [title]: title text
proc showTitle(title: str)
{
    echo ""
    echo "=============================="
    echo title
    echo "=============================="
}

; ==============================
; main flow
; ==============================

# Description: Main flow, demonstrates all control flow constructs
proc main()
{
    Cmd.setTitle("Control Flow Demo")
    showTitle("batScript Control Flow Demo")

    ; ---------- input and basic if ----------
    set name_raw: str = getin "Input your name>>"
    set user_name: str = Constants.DEFAULT_NAME

    if isNonEmpty(name_raw)
    {
        set user_name = name_raw
    }
    else
    {
        set user_name = Constants.DEFAULT_NAME
    }

    echo `Hello {user_name}`

    ; ---------- if / elif / else and condition ----------
    showTitle("if / elif / else and condition")

    set age_raw: str = getin "Input age (10/20/30)>>"
    set age: num = 0

    condition age_raw
    {
        "10": set age = %num%age_raw
        "20": set age = %num%age_raw
        "30": set age = %num%age_raw
        /: err "Age must be 10, 20, or 30"
    }

    set age_text: str = %str%age
    set age_group: str = "Unknown"

    if age < 18
    {
        set age_group = "Child"
    }
    elif age < 30
    {
        set age_group = "Adult"
    }
    else
    {
        set age_group = "Senior"
    }

    echo `age   = {age_text}`
    echo `group = {age_group}`

    ; if single-line syntax example
    if age >= 18 : echo "Access granted"

    ; ---------- condition string branches ----------
    set op_raw: str = getin "Choose op (add/sub/other)>>"

    condition op_raw
    {
        "add": echo "You chose add"
        "sub": echo "You chose sub"
        /: echo "You chose other"
    }

    ; ---------- while / continue ----------
    showTitle("while / continue")

    set while_count: num = 0

    while while_count < 5
    {
        set while_count = while_count + 1
        if while_count == 2 : continue
        set while_count_text: str = %str%while_count
        echo `while_count = {while_count_text}`
    }

    set quick_count: num = 0
    while quick_count < 2 : set quick_count = quick_count + 1
    echo "while single-line syntax executed"

    ; ---------- loop / break ----------
    showTitle("loop / break")

    set loop_count: num = 0

    loop
    {
        set loop_count = loop_count + 1
        set loop_count_text: str = %str%loop_count
        echo `loop_count = {loop_count_text}`
        if loop_count >= 3 : break
    }

    loop : break  ; example of infinite loop with immediate exit

    ; ---------- repeat ----------
    showTitle("repeat")

    repeat 3 : echo "repeat single-line"

    repeat 3 => i
    {
        set i_text: str = %str%i
        echo `repeat index = {i_text}`
    }

    ; ---------- iterate ----------
    showTitle("iterate")

    set nums: arr<num> = [1, 2, 3]
    iterate nums => n
    {
        set n_text: str = %str%n
        echo `n = {n_text}`
    }

    set word: str = "bat"
    iterate word => ch
    {
        echo ch
    }

    ; ---------- circle ----------
    showTitle("circle")

    set colors: arr<str> = ["R", "G", "B"]
    set circle_count: num = 0

    circle colors => c
    {
        set circle_count = circle_count + 1
        echo c
        if circle_count >= Constants.MAX_CIRCLE_STEPS : break
    }

    echo "Done."
}

main()
```

### Interactive Four-Operation Calculator

```batscript
# Description: Interactive four-operation calculator (with expression parsing, precedence, and parentheses)
# Author: ChatGPT
# Date: 2026-04-01
# File: Calculator.bs
# Version: 1.0.0

lib Cmd

; ==============================
; parser state (single-line group)
; ==============================

group Parser { set g_tokens: arr<str> = []; set g_tok_len: num = 0; set g_pos: num = 0 }

; ==============================
; Parser group methods
; ==============================

# Description: Initialize parser state
# Param [tokens]: tokenization result
proc Parser.init(tokens: arr<str>)
{
    set Parser.g_tokens = tokens
    set Parser.g_tok_len = @tokens
    set Parser.g_pos = 0
}

# Description: Whether there are unread tokens
# Return: True if there are remaining tokens
func Parser.hasMore() -> bool
{
    return Parser.g_pos < Parser.g_tok_len
}

# Description: Peek at current token without advancing
# Return: current token or empty string
func Parser.peek() -> str
{
    if Parser.hasMore() : return Parser.g_tokens[Parser.g_pos]
    return ""
}

# Description: Advance cursor by one
proc Parser.advance()
{
    set Parser.g_pos = Parser.g_pos + 1
}

; ==============================
; character classification utility functions
; ==============================

# Description: Check if character is a digit 0-9
# Param [ch]: single-character string
# Return: True if digit
func isDigit(ch: str) -> bool
{
    return ch >= "0" and ch <= "9"
}

# Description: Check if character is whitespace
# Param [ch]: single-character string
# Return: True if whitespace
func isSpace(ch: str) -> bool
{
    return ch == " " or ch == "\t"
}

; ==============================
; lexical analysis
; ==============================

# Description: Split expression string into token array
# Param [expr]: raw expression string
# Return: token array (arr<str>)
func tokenize(expr: str) -> arr<str>
{
    set tokens: arr<str> = []
    set i: num = 0
    set n: num = @expr

    while i < n
    {
        set j: num = i + 1
        set ch: str = expr[i:j]

        if isSpace(ch)
        {
            set i = i + 1
        }
        elif isDigit(ch) or ch == "."
        {
            set num_buf: str = ""
            loop
            {
                if i >= n : break
                set j = i + 1
                set ch = expr[i:j]
                if isDigit(ch) or ch == "."
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
        elif ch == "+" or ch == "-" or ch == "*" or ch == "/" or ch == "(" or ch == ")"
        {
            tokens^ ch
            set i = i + 1
        }
        else
        {
            echo `Invalid char: {ch}`
            err "Invalid character in expression"
        }
    }

    return tokens
}

; ==============================
; recursive descent parser
; supports: + - * /, parentheses, unary +/-
; ==============================

# Description: Parse factor: numeric literal, parenthesized expression, unary +/-
# Return: numeric result
func parseFactor() -> num
{
    if not Parser.hasMore() : err "Unexpected end of expression"

    set tok: str = Parser.peek()

    if tok == "+"
    {
        Parser.advance()
        return parseFactor()
    }

    if tok == "-"
    {
        Parser.advance()
        set val_neg: num = parseFactor()
        return 0 - val_neg
    }

    if tok == "("
    {
        Parser.advance()
        set inner: num = parseExpr()
        if not Parser.hasMore() : err "Missing closing parenthesis"
        if Parser.peek() ~= ")" : err "Missing closing parenthesis"
        Parser.advance()
        return inner
    }

    set tok_val: str = Parser.peek()
    Parser.advance()
    return %num%tok_val
}

# Description: Parse term: handle * /
# Return: numeric result
func parseTerm() -> num
{
    set value: num = parseFactor()

    while Parser.hasMore()
    {
        set op: str = Parser.peek()
        if op == "*"
        {
            Parser.advance()
            set value = value * parseFactor()
        }
        elif op == "/"
        {
            Parser.advance()
            set rhs: num = parseFactor()
            if rhs == 0 : err "Divide by zero"
            set value = value / rhs
        }
        else
        {
            break
        }
    }

    return value
}

# Description: Parse expression: handle + -
# Return: numeric result
func parseExpr() -> num
{
    set value: num = parseTerm()

    while Parser.hasMore()
    {
        set op: str = Parser.peek()
        if op == "+"
        {
            Parser.advance()
            set value = value + parseTerm()
        }
        elif op == "-"
        {
            Parser.advance()
            set value = value - parseTerm()
        }
        else
        {
            break
        }
    }

    return value
}

; ==============================
; evaluation wrapper
; ==============================

# Description: Tokenize, parse, and output result
# Param [expr]: expression string
proc evalExpression(expr: str)
{
    Parser.init(tokenize(expr))
    set result: num = parseExpr()
    if Parser.g_pos < Parser.g_tok_len : err "Unexpected token after valid expression"
    set result_text: str = %str%result
    echo `= {result_text}`
}

; ==============================
; main flow: interactive REPL
; ==============================

# Description: Interactive calculator main entry
proc main()
{
    Cmd.setTitle("Interactive Calculator")
    echo "Interactive Calculator (type q to quit)"
    echo "Supports + - * /, parentheses, unary +/-"

    loop
    {
        set expr: str = getin "calc>>"
        if expr == "q" : break
        if expr == "" : continue
        evalExpression(expr)
    }

    echo "Bye."
}

main()
```

### Student Grade Management System

```batscript
# Description: Student grade management system (using SimpKv for persistence, semicolon-separated lists)
# Author: ChatGPT
# Date: 2026-04-01
# File: StudentGradeSystem.bs
# Version: 1.0.0

lib SimpKv
lib Cmd
lib* Iterable  ; unpack Iterable: arrIndexOf(), strContain(), etc. directly available

; ================================
; global config (single-line group)
; ================================

group Config { let STORE_PREFIX: str = "student:"; let LIST_KEY: str = "students"; let SEP: str = ";" }

# Description: Build student storage key
# Param [name]: student name
# Return: storage key
func Config.buildKey(name: str) -> str
{
    return Config.STORE_PREFIX .. name
}

; ================================
; string utility group
; ================================

group StrUtils
{
    ; general string helper methods
}

# Description: Split string by single-character separator
# Param [src]: source string
# Param [sep]: single-character separator
# Return: array of split segments
func StrUtils.split(src: str, sep: str) -> arr<str>
{
    set result: arr<str> = []
    set n: num = @src
    set start: num = 0
    set i: num = 0

    while i < n
    {
        set i1: num = i + 1
        if src[i:i1] == sep
        {
            result^ src[start:i]
            set start = i + 1
        }
        set i = i + 1
    }

    result^ src[start:n]
    return result
}

# Description: Join string array with separator
# Param [items]: string array
# Param [sep]: separator
# Return: joined string
func StrUtils.join(items: arr<str>, sep: str) -> str
{
    set total: num = @items
    if total == 0 : return ""

    set acc: str = items[0]
    set idx: num = 1

    while idx < total
    {
        set acc = acc .. sep .. items[idx]
        set idx = idx + 1
    }

    return acc
}

; ================================
; validation utility group
; ================================

group Validator
{
    ; input validity validation
}

# Description: Check if string is non-empty
# Param [v]: string to check
# Return: True if non-empty
func Validator.isNonEmpty(v: str) -> bool
{
    return ?v
}

# Description: Check if name is valid (non-empty and contains no ';' or '=')
# Param [name]: name to check
# Return: True if valid
func Validator.isValidName(name: str) -> bool
{
    if not ?name : return False
    iterate name => ch
    {
        if ch == ";" or ch == "=" : return False
    }
    return True
}

# Description: Check if score text format is valid (0-100, up to two decimal places)
# Param [txt]: raw score input
# Return: True if valid
func Validator.isValidScore(txt: str) -> bool
{
    if not ?txt : return False

    set dot_count: num = 0
    set digit_count: num = 0
    set dec_len: num = 0
    set after_dot: bool = False

    iterate txt => ch
    {
        if ch == "."
        {
            if dot_count >= 1 : return False
            set dot_count = dot_count + 1
            set after_dot = True
        }
        elif ch >= "0" and ch <= "9"
        {
            set digit_count = digit_count + 1
            if after_dot
            {
                set dec_len = dec_len + 1
                if dec_len > 2 : return False
            }
        }
        else
        {
            return False
        }
    }

    if digit_count == 0 : return False
    if dot_count == 1 and dec_len == 0 : return False

    set val: num = %num%txt
    if val < 0 or val > 100 : return False

    return True
}

; ================================
; persistence operations group
; ================================

group StudentStore
{
    ; encapsulate SimpKv student CRUD
}

# Description: Check if student exists
# Param [name]: student name
# Return: True if exists
func StudentStore.exists(name: str) -> bool
{
    set val: str? = SimpKv.get(Config.buildKey(name))
    return ?val and val ~= ""
}

# Description: Load student subject-score pair array (["Math=95", ...])
# Param [name]: student name
# Return: pair array, empty array if no records
func StudentStore.loadPairs(name: str) -> arr<str>
{
    set raw: str? = SimpKv.get(Config.buildKey(name))
    if not ?raw or raw == "" : return []

    set all: arr<str> = StrUtils.split(raw, Config.SEP)
    set cleaned: arr<str> = []
    iterate all => p
    {
        if ?p : cleaned^ p
    }
    return cleaned
}

# Description: Save subject-score pair array
# Param [name]: student name
# Param [pairs]: pair array
proc StudentStore.savePairs(name: str, pairs: arr<str>)
{
    set data: str = ""
    if @pairs > 0 : set data = StrUtils.join(pairs, Config.SEP)
    SimpKv.set(Config.buildKey(name), data)
}

# Description: Append student name to global list (idempotent)
# Param [name]: student name
proc StudentStore.upsertList(name: str)
{
    set raw: str? = SimpKv.get(Config.LIST_KEY)
    if not ?raw or raw == ""
    {
        SimpKv.set(Config.LIST_KEY, name)
        return
    }

    set names: arr<str> = StrUtils.split(raw, Config.SEP)
    set found: bool = False
    iterate names => nm
    {
        if nm == name
        {
            set found = True
            break
        }
    }

    if not found
    {
        names^ name
        SimpKv.set(Config.LIST_KEY, StrUtils.join(names, Config.SEP))
    }
}

# Description: Remove student name from global list
# Param [name]: student name
proc StudentStore.removeFromList(name: str)
{
    set raw: str? = SimpKv.get(Config.LIST_KEY)
    if not ?raw or raw == "" : return

    set names: arr<str> = StrUtils.split(raw, Config.SEP)
    set new_names: arr<str> = []
    iterate names => nm
    {
        if nm ~= name and ?nm : new_names^ nm
    }

    set updated: str = ""
    if @new_names > 0 : set updated = StrUtils.join(new_names, Config.SEP)
    SimpKv.set(Config.LIST_KEY, updated)
}

# Description: Delete student record (set to empty)
# Param [name]: student name
proc StudentStore.delete(name: str)
{
    SimpKv.set(Config.buildKey(name), "")
}

; ================================
; business logic group
; ================================

group GradeManager
{
    ; grade add/delete/query logic
}

# Description: Extract subject name from "Sub=Score" pair
# Param [p]: score pair string
# Return: subject name
func GradeManager.subject(p: str) -> str
{
    set parts: arr<str> = StrUtils.split(p, "=")
    return parts[0]
}

# Description: Extract score text from "Sub=Score" pair
# Param [p]: score pair string
# Return: score text
func GradeManager.score(p: str) -> str
{
    set parts: arr<str> = StrUtils.split(p, "=")
    return parts[1]
}

# Description: Set or update a subject score
# Param [name]: student name
# Param [subject]: subject name
# Param [score_txt]: score text
proc GradeManager.setScore(name: str, subject: str, score_txt: str)
{
    if not Validator.isValidScore(score_txt) : err "Invalid score format"

    set pairs: arr<str> = StudentStore.loadPairs(name)
    set updated: arr<str> = []
    set replaced: bool = False

    iterate pairs => p
    {
        if GradeManager.subject(p) == subject
        {
            updated^ subject .. "=" .. score_txt
            set replaced = True
        }
        else
        {
            updated^ p
        }
    }

    if not replaced : updated^ subject .. "=" .. score_txt

    StudentStore.savePairs(name, updated)
    StudentStore.upsertList(name)
}

# Description: Print all scores and average for a student
# Param [name]: student name
proc GradeManager.printReport(name: str)
{
    if not StudentStore.exists(name)
    {
        echo "Student not found"
        return
    }

    set pairs: arr<str> = StudentStore.loadPairs(name)
    set total: num = @pairs
    echo `Student: {name}`

    if total == 0
    {
        echo "No score records"
        return
    }

    set sum_score: num = 0
    iterate pairs => p
    {
        set sub: str = GradeManager.subject(p)
        set val_txt: str = GradeManager.score(p)
        set val_num: num = %num%val_txt
        echo `  {sub}: {val_txt}`
        set sum_score = sum_score + val_num
    }

    set avg: num = sum_score / %num%total
    set avg_txt: str = %str%avg
    echo `Average: {avg_txt}`
}

; ================================
; menu interaction procedures
; ================================

# Description: Add a student
proc doAddStudent()
{
    set name: str = getin "Student name>>"
    if not Validator.isValidName(name) : err "Name cannot be empty and must not contain ';' or '='"

    if not StudentStore.exists(name)
    {
        StudentStore.savePairs(name, [])
        StudentStore.upsertList(name)
        echo "Student created"
    }
    else
    {
        echo "Student already exists (no changes made)"
    }
}

# Description: Enter or update a score
proc doInputScore()
{
    set name: str = getin "Student name>>"
    if not Validator.isValidName(name) : err "Invalid name"

    if not StudentStore.exists(name)
    {
        echo "Student not found, automatically creating empty record"
        StudentStore.savePairs(name, [])
        StudentStore.upsertList(name)
    }

    set subject: str = getin "Subject>>"
    if not Validator.isValidName(subject) : err "Invalid subject"

    set score_txt: str = getin "Score (0-100, up to 2 decimal places)>>"
    GradeManager.setScore(name, subject, score_txt)
    echo "Score saved"
}

# Description: Query student scores
proc doQueryStudent()
{
    set name: str = getin "Student name>>"
    GradeManager.printReport(name)
}

# Description: List all students
proc doListStudents()
{
    set raw: str? = SimpKv.get(Config.LIST_KEY)
    if not ?raw or raw == ""
    {
        echo "No student records"
        return
    }

    set names: arr<str> = StrUtils.split(raw, Config.SEP)
    set shown: bool = False
    iterate names => nm
    {
        if ?nm
        {
            echo nm
            set shown = True
        }
    }

    if not shown : echo "No student records"
}

# Description: Delete a student
proc doDeleteStudent()
{
    set name: str = getin "Student name>>"
    if not StudentStore.exists(name)
    {
        echo "Student not found"
        return
    }
    StudentStore.removeFromList(name)
    StudentStore.delete(name)
    echo "Deleted"
}

# Description: Show menu
proc showMenu()
{
    echo ""
    echo "==== Student Grade Management System ===="
    echo "1) Add Student"
    echo "2) Enter/Update Score"
    echo "3) Query Student Scores"
    echo "4) List All Students"
    echo "5) Delete Student"
    echo "6) Exit"
}

# Description: Main flow
proc main()
{
    Cmd.setTitle("Student Grade Management System")

    loop
    {
        showMenu()
        set choice: str = getin "Choice>>"

        if choice == "6" : break

        condition choice
        {
            "1": doAddStudent()
            "2": doInputScore()
            "3": doQueryStudent()
            "4": doListStudents()
            "5": doDeleteStudent()
            /: echo "Invalid option"
        }
    }

    echo "Exited"
}

main()
```

### Integration with Native BAT Inline

```batscript
# Description: Demonstrate batScript and native BAT inline combination (runraw and $|)
# Author: ChatGPT
# Date: 2026-04-01
# File: NativeBridge.bs
# Version: 1.0.0

lib* Windows  ; unpack Windows: version(), getEnv(), setEnv() directly available
lib Admin
lib Cmd

; state group (single-line group)
group BridgeState { set counter: num = 42; set admin_checked: bool = False }

# Description: Check administrator status and output
proc BridgeState.checkAdmin()
{
    set BridgeState.admin_checked = Admin.isAdmin()
    set admin_txt: str = %str%BridgeState.admin_checked
    echo `isAdmin = {admin_txt}`
}

# Description: Demonstrate batScript and native BAT interop
proc showNativeInterop()
{
    echo "=== batScript Section ==="

    ; direct call to version() via lib* Windows
    set os_ver: str = version()
    echo `OS version = {os_ver}`

    ; direct call to getEnv() via lib* Windows
    set userprofile: str = getEnv("USERPROFILE")
    echo `USERPROFILE = {userprofile}`

    ; administrator status check
    BridgeState.checkAdmin()

    ; get raw variable name for runraw expansion
    set counter_raw: str = $|BridgeState.counter
    set counter_txt: str = %str%BridgeState.counter
    echo `counter (batScript) = {counter_txt}`

    ; single-line runraw example
    runraw: "echo [BAT] single-line runraw reached."

    ; block runraw: mix of strings and raw variable name expansion
    runraw
    {
        "@echo off",
        "echo --- Native BAT block start ---",
        "echo Working dir (BAT):",
        "cd",
        "echo.",
        "echo Expanding batScript variable via native BAT:",
        "echo counter = %", counter_raw, "%",
        "echo.",
        "echo Current directory listing:",
        "dir /b",
        "echo --- Native BAT block end ---"
    }
}

# Description: Main entry
proc main()
{
    Cmd.setTitle("NativeBridge Demo")
    showNativeInterop()
    echo "Back in batScript after runraw."
}

main()
```

### Comprehensive Other Syntax Reference

```batscript
# Description: batScript comprehensive other syntax demo (covering features not heavily shown before)
# Author: ChatGPT
# Date: 2026-04-01
# File: OtherSyntaxDemo.bs
# Version: 1.0.0

lib* Math     ; PI, abs(), sqrt(), floor(), ceil(), round(), pow() etc. directly available
lib* Windows  ; version(), getEnv(), setEnv() directly available
lib* Iterable ; arrIndexOf(), strContain() directly available
lib Admin
lib Cmd

; =====================================================
; application info (single-line group)
; =====================================================

group AppInfo { let APP_NAME: str = "OtherSyntaxDemo"; let APP_VER: str = "1.0.0" }

; =====================================================
; math utility group (using lib* Math unpacked symbols)
; =====================================================

group MathUtils
{
    ; geometric calculations, depends on PI from lib* Math unpack
}

# Description: Calculate circle area (using unpacked PI)
# Param [r]: radius
# Return: area
func MathUtils.circleArea(r: num) -> num
{
    return PI * r * r
}

# Description: Calculate circle circumference
# Param [r]: radius
# Return: circumference
func MathUtils.circlePerim(r: num) -> num
{
    return 2 * PI * r
}

# Description: Convert degrees to radians
# Param [deg]: degree value
# Return: radian value
func MathUtils.toRad(deg: num) -> num
{
    return deg * PI / 180
}

; =====================================================
; output format utility group
; =====================================================

group Fmt
{
    ; formatting helpers
}

# Description: Print section title
# Param [title]: title
proc Fmt.section(title: str)
{
    echo ""
    echo "----"
    echo title
    echo "----"
}

# Description: Print type string
# Param [label]: label
# Param [val_type]: type string
proc Fmt.showType(label: str, val_type: str)
{
    echo `type({label}) = {val_type}`
}

; =====================================================
; constraint functions (for match binding)
; =====================================================

# Description: Check if value is non-negative
# Param [v]: numeric value
# Return: True if non-negative
func isNonNeg(v: num) -> bool
{
    return v >= 0
}

# Description: Check if string length does not exceed limit
# Param [v]: string
# Param [limit]: length limit
# Return: True if compliant
func isWithinLen(v: str, limit: num) -> bool
{
    if not ?v : return False
    return @v <= limit
}

; =====================================================
; main flow
; =====================================================

# Description: Main flow, covering various syntax features
proc main()
{
    Cmd.setTitle(`{AppInfo.APP_NAME} v{AppInfo.APP_VER}`)

    ; ---------- conf configuration signal ----------
    if conf d : echo "Debug flag /d detected"

    ; ---------- lib* Math unpack usage ----------
    Fmt.section("lib* Math Unpack Direct Usage")

    set r: num = 5
    set area: num = MathUtils.circleArea(r)
    set perim: num = MathUtils.circlePerim(r)
    set rad: num = MathUtils.toRad(90)
    set root2: num = sqrt(2)       ; sqrt from lib* Math
    set floored: num = floor(3.7)  ; floor from lib* Math
    set area_txt: str = %str%area
    set perim_txt: str = %str%perim
    set rad_txt: str = %str%rad
    set root2_txt: str = %str%root2
    set floored_txt: str = %str%floored
    echo `circleArea(5)  = {area_txt}`
    echo `circlePerim(5) = {perim_txt}`
    echo `toRad(90)      = {rad_txt}`
    echo `sqrt(2)        = {root2_txt}`
    echo `floor(3.7)     = {floored_txt}`
    echo `PI             = {%str%PI}`

    ; ---------- lib* Windows unpack usage ----------
    Fmt.section("lib* Windows Unpack Direct Usage")

    set os_ver: str = version()       ; Windows.version(), already unpacked
    set home: str = getEnv("USERPROFILE")
    echo `OS version   = {os_ver}`
    echo `USERPROFILE  = {home}`

    ; ---------- lib* Iterable unpack usage ----------
    Fmt.section("lib* Iterable Unpack Direct Usage")

    set fruits: arr<str> = ["apple", "banana", "cherry"]
    set idx_banana: num = arrIndexOf(fruits, "banana")  ; already unpacked
    set has_cherry: bool = strContain("I like cherry pie", "cherry")
    set idx_txt: str = %str%idx_banana
    set has_txt: str = %str%has_cherry
    echo `indexOf banana = {idx_txt}`
    echo `has cherry     = {has_txt}`

    ; ---------- lib Admin ----------
    Fmt.section("lib Admin (namespace preserved)")

    set is_adm: bool = Admin.isAdmin()
    set is_adm_txt: str = %str%is_adm
    echo `isAdmin = {is_adm_txt}`
    if not is_adm : echo "Running without admin privileges."

    ; ---------- match constraint binding ----------
    Fmt.section("match Constraint Binding")

    set balance: num = 0 match isNonNeg(balance)
    set dep_raw: str = getin "Deposit (>=0)>>"
    set dep: num = %num%dep_raw
    set balance = balance + dep
    set bal_txt: str = %str%balance
    echo `balance = {bal_txt}`

    set tag: str = "hello" match isWithinLen(tag, 8)
    echo `tag = {tag}`

    ; ---------- nullable type and Nil/Inf ----------
    Fmt.section("Nullable Types and Nil / Inf")

    set maybe: num? = Nil
    if ?maybe
    {
        set maybe_txt: str = %str%maybe
        echo `maybe = {maybe_txt}`
    }
    else
    {
        echo "maybe is Nil, defaulting to 99"
        set maybe = 99
        set maybe_txt: str = %str%maybe
        echo `maybe = {maybe_txt}`
    }

    set inf_val: num = Inf
    Fmt.showType("inf_val", &inf_val)
    if inf_val == Inf : echo "Inf comparison OK"

    ; ---------- array append / delete / slice / negative index ----------
    Fmt.section("Array Append / Delete / Slice / Negative Index")

    set nums: arr<num> = [1, 2, 3, 4]
    nums^ 5          ; append 5 → [1,2,3,4,5]
    ^nums 1          ; delete index 1 → [1,3,4,5]
    ^nums            ; delete last → [1,3,4]

    set last: num = nums[-1]
    set last_txt: str = %str%last
    echo `last = {last_txt}`

    set sliced: arr<num> = nums[0:2]
    set slice_len_txt: str = %str%@sliced
    echo `slice len = {slice_len_txt}`

    ; ---------- string slice and reverse ----------
    Fmt.section("String Slice and Reverse")

    set word: str = "batScript"
    set part: str = word[3:9]
    set word_rev: str = !word
    echo `part     = {part}`
    echo `word_rev = {word_rev}`

    ; ---------- pair field access and swap ----------
    Fmt.section("pair Field Access and Swap")

    set p: pair<num, str> = (7, "ok")
    set fst: num = ^p
    set snd: str = p^
    set fst_txt: str = %str%fst
    echo `first  = {fst_txt}`
    echo `second = {snd}`

    set swapped: pair<str, num> = !p
    set sw_fst: str = ^swapped
    set sw_snd: num = swapped^
    set sw_snd_txt: str = %str%sw_snd
    echo `swapped.first  = {sw_fst}`
    echo `swapped.second = {sw_snd_txt}`

    ; ---------- & type string and $| raw variable name ----------
    Fmt.section("& Type String and $| Raw Variable Name")

    Fmt.showType("balance", &balance)
    set raw_name: str = $|balance
    echo `raw var name = {raw_name}`

    ; ---------- condition proper usage ----------
    Fmt.section("condition")

    set op: str = getin "Choose op (+/-/*)>>"
    condition op
    {
        "+": echo "add"
        "-": echo "sub"
        "*": echo "mul"
        /: echo "other"
    }

    ; ---------- loop => count index ----------
    Fmt.section("loop => Count Index")

    set tick: num = 0
    loop => i
    {
        set tick = tick + 1
        set i_txt: str = %str%i
        echo `loop i = {i_txt}`
        if tick >= 3 : break
    }

    echo ""
    echo "Demo finished."
}

main()
```
