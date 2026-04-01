# `batScript`

***[中文](README-zh.md)***

`batScript` is a **strongly-typed, structured transpiled language** with `.bs` as its file extension.
Just as `JavaScript` transpiles to `TypeScript`, `batScript` transpiles `.bs` to `.bat`, bringing the following to the aging and rudimentary `.bat` script:

- Rational naming conventions and usage: Native batch syntax is crude and bizarre. `batScript` provides keyword and identifier designs that are closer to normal languages.
- Type system: Three unit types are provided, including two primitive types (`num`, `bool`) and one composite type (`pair`), as well as two iterable types (`str`, `arr`). Variables are case-sensitive.
- Normal control flow: `if-else-elif` basic conditional branching, `while` and `loop` basic loop branching, as well as the extended `condition` state-machine branching and `iterate` iterable loop branching, plus `loop`, `repeat`, and `circle` syntactic sugar.
- Functions and procedures. Declared via `func` and `proc` respectively, strongly typed, with recursion support.
- Modern operators. Primary operators follow modern language conventions, along with special operators tailored for `BAT`, such as the raw-value operator `$|`.
- Basic package management. `pkg` for file imports, `lib` for library imports, and the `bspm` package manager.
- Script-specific syntax, such as `conf` configuration and `match` constraints.
- Other syntax extensions. Including the most basic exception `err`, I/O via `echo` and `getin`, native `BAT` execution via `runraw`, grouping with `group`, and more.

Start reading the full documentation [here](./doc/en/guide/01-introducing-batScript.md).

## Quick Overview

### Compiler Commands

```cmd
bsc -Version :: Output version
bsc -Compile input_file -Output output_file :: Perform compilation
bsc -Check -File check_file :: Check code
```

Example:

```cmd
bsc -Compile MyScript.bs -Output MyScript.bat
```

### Package Manager Commands

```cmd
bspm /v :: Output version
bspm /s search_name :: Search for a library
bspm /i package_name :: Install a library
bspm /u package_name :: Uninstall a library
bspm /l match_name :: List local libraries
```

Example:

```cmd
bspm /i BatKV /c ">=1.0"
```

### Keywords and Symbol Table

| Symbol       | Description                   |
|--------------|-------------------------------|
| `set`        | Declare a variable            |
| `let`        | Declare an immutable variable |
| `num`        | Number type                   |
| `bool`       | Boolean type                  |
| `str`        | String type                   |
| `arr`        | One-dimensional array type    |
| `pair`       | Key-value pair type           |
| `match`      | Constraint                    |
| `if`         | If                            |
| `elif`       | Else if                       |
| `else`       | Else                          |
| `condition`  | Match condition               |
| `while`      | Basic loop                    |
| `loop`       | Infinite loop                 |
| `repeat`     | Count-based loop              |
| `iterate`    | Iterable loop                 |
| `circle`     | Iterable rotating loop        |
| `break`      | Break out of loop             |
| `continue`   | Continue loop                 |
| `and`        | Logical AND                   |
| `or`         | Logical OR                    |
| `not`        | Logical NOT                   |
| `func`       | Function                      |
| `proc`       | Procedure                     |
| `return`     | Return value                  |
| `pkg`        | File import                   |
| `lib`        | Package import                |
| `runraw`     | Native inline embedding       |
| `err`        | Throw exception               |
| `endprogram` | Terminate program             |
| `pause`      | Pause                         |
| `getin`      | Read from input stream        |
| `echo`       | Output                        |
| `group`      | Grouping                      |
| `conf`       | Configuration entry           |
| `+`          | Addition                      |
| `-`          | Subtraction                   |
| `*`          | Multiplication                |
| `/`          | Division                      |
| `>`          | Greater than                  |
| `>=`         | Greater than or equal to      |
| `==`         | Equal to                      |
| `~=`         | Not equal to                  |
| `<`          | Less than                     |
| `<=`         | Less than or equal to         |
| `=`          | Assignment                    |
| `%%`         | Type cast                     |
| `!`          | Negate / reverse              |
| `?`          | Null check                    |
| `&`          | Get type string               |
| `@`          | Get iterable length           |
| `..`         | Iterable concatenation        |
| `^`          | Iterable index access         |
| `$\|`        | Get raw value                 |
| `True`       | True value                    |
| `False`      | False value                   |
| `Nil`        | Null value                    |
| `Inf`        | Infinite value                |

### Standard Library Overview

| Library    | Description      | Representative Methods / Literals                                                   |
|------------|------------------|-------------------------------------------------------------------------------------|
| `Math`     | Mathematics      | `abs()` `min()` `max()` `sqrt()` `random` `floor()` `ceil()` `round()` `pow()` `PI` |
| `Cmd`      | Console          | `setColor()` `setTitle()` `restartInAdmin()`                                        |
| `Tools`    | System utilities | `diskpart()` `ping()` `ipconfig()` `whoami()`                                       |
| `Windows`  | Operating system | `version()` `getEnv()` `setEnv()`                                                   |
| `Admin`    | Admin privileges | `isAdmin()` `requireAdmin()` `relaunchAsAdmin` `sudo()`                             |
| `Iterable` | Iterables        | `arrIndexOf()` `strContain()`                                                       |

### Other Syntax Overview

- `#`: Embedded documentation
- `;`: Comment
- `"\n"`: String escape sequence
- `''`: Raw string literal
- `` Hello {hello_val} ``: b-string
- `[1, 2, 3, 4][2:3]`: Array slicing
- `{`, `}`: Code block delimiters
- `if (a > b) :`: Single-line statement
- `func (a: num, b: str) -> bool`: Function declaration

### Coding Conventions

- Files: PascalCase.bs
- Variables: lowercase_with_underscores
- Constants: UPPER_CASE_WITH_UNDERSCORES
- Functions and procedures: camelCase
- Group names: PascalCase
- Configuration names: Each word capitalized, joined with underscores
- Allman style braces
- All files, groups, functions, and procedures must have documentation comments

## Example Programs

### HelloWorld

The most basic example.

```batscript
# Description: batScript HelloWorld example program
# Author: WaterRun
# Date: 2026-03-30
# File: HelloWorld.bs

echo "HelloWorld!" ; Output HelloWorld
```

### Type System

The following demonstrates each primitive type and its usage in batScript.

```batscript
# Description: batScript type system example program
# Author: WaterRun
# Date: 2026-04-01
# File: Types.bs

; Constants
let MAX_COUNT: num = 128
let max_count: num = 64 ; This is a separate variable from MAX_COUNT — case-sensitive, though the compiler will warn about the naming convention violation

; String type
set name_1: str = "Alice"
set name_2 = "Bol"
set name_3: str? = "Siri"
; name_3 = -123.456
; Uncommenting the line above will cause an error: the type of name_3 is str?

; Number type
set age_1: num = 20
set age_2 = 22.5
set age_3: num? = Nil

; Boolean type
set is_alive_1: bool = True
set is_alive_2: bool = False
set is_alive_3: bool? = Nil

; Array type
set scores: arr<num> = [90, 88.5, 100]
set names: arr<str> = ["Alice", "Bol", "Siri"]

; Composite type
set name_age_pair_1: pair<str, num> = (name_1, age_1)
set name_age_pair_2: pair<str, num?> = (name_3, age_3)
set name_age_pair_3: pair<str, num>? = Nil

; Unary and length
set name_1_len: num = @name_1
set name_1_rev: str = !name_1

; Concatenation
set greeting: str = "Hello, " .. name_1

; Type cast and output
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

### Control Flow Example

```batscript
# Description: batScript control flow example program (with detailed comments)
# Author: WaterRun
# Date: 2026-04-01
# File: ControlFlow.bs
# Version: 1.0.1

; ==============================
; Global constants
; ==============================

let DEFAULT_NAME = "Guest"
let MAX_CIRCLE_STEPS = 5

; ==============================
; Utility functions and procedures
; ==============================

# Description: Check whether a string is non-empty
# Param [v]: The string to check
# Return: True if non-empty, otherwise False
func isNonEmpty(v: str) -> bool
{
    ; ?v checks for null — returns True if non-empty
    return ?v
}

# Description: Print a section header
# Param [title]: Header text
proc showTitle(title: str)
{
    ; Print blank line to separate sections
    echo ""
    ; Print decorative line
    echo "=============================="
    ; Print title
    echo title
    ; Print decorative line
    echo "=============================="
}

; ==============================
; Main flow
; ==============================

# Description: Main flow demonstrating all control flow constructs
proc main()
{
    ; Title
    showTitle("batScript Control Flow Example")

    ; ---------- Input and basic if ----------
    ; Get username input; getin returns str
    set name_raw: str = getin "Input your name>>"
    ; Pre-set default username
    set user_name: str = DEFAULT_NAME

    ; Use input value if non-empty; otherwise use default
    if (isNonEmpty(name_raw))
    {
        set user_name = name_raw
    }
    else
    {
        set user_name = DEFAULT_NAME
    }

    ; Print greeting
    echo `Hello {user_name}`

    ; ---------- if / elif / else and condition ----------
    showTitle("if / elif / else and condition")

    ; Get age input (expected: 10/20/30)
    set age_raw: str = getin "Input age (10/20/30)>>"
    ; Give an explicit initial numeric value
    set age: num = 0

    ; Use condition for string matching — only fixed values are allowed
    condition age_raw
    {
        "10": set age = %num%age_raw
        "20": set age = %num%age_raw
        "30": set age = %num%age_raw
        /: err "Age must be 10, 20, or 30"
    }

    ; Convert age to string for b-string interpolation
    set age_text: str = %str%age

    ; Default age group value
    set age_group: str = "Unknown"

    ; Set age group based on age range
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

    ; Print age and age group
    echo `age = {age_text}`
    echo `group = {age_group}`

    ; Single-line if syntax example (single action only)
    if (age >= 18): echo "Access granted"

    ; ---------- condition string branching ----------
    ; Get operator input
    set op_raw: str = getin "Choose op (add/sub/other)>>"

    ; condition branches only allow single-line actions
    condition op_raw
    {
        "add": echo "You chose add"
        "sub": echo "You chose sub"
        /: echo "You chose other"
    }

    ; ---------- while / continue ----------
    showTitle("while / continue")

    ; while counter
    set while_count: num = 0

    ; Basic while loop
    while (while_count < 5)
    {
        ; Increment first
        set while_count = while_count + 1

        ; Skip output when count is 2
        if (while_count == 2)
        {
            continue
        }

        ; Print current count
        set while_count_text: str = %str%while_count
        echo `while_count = {while_count_text}`
    }

    ; Single-line while syntax example (single action only)
    set quick_count: num = 0
    while (quick_count < 2): set quick_count = quick_count + 1
    echo "while single-line executed"

    ; ---------- loop / break ----------
    showTitle("loop / break")

    ; loop counter
    set loop_count: num = 0

    ; Infinite loop, exit with break
    loop
    {
        set loop_count = loop_count + 1
        set loop_count_text: str = %str%loop_count
        echo `loop_count = {loop_count_text}`

        ; Exit when reaching 3
        if (loop_count >= 3)
        {
            break
        }
    }

    ; Single-line loop syntax example (single action only)
    loop: break

    ; ---------- repeat ----------
    showTitle("repeat")

    ; Single-line repeat syntax example
    repeat 3: echo "repeat single-line"

    ; repeat with index example
    repeat 3 => i
    {
        set i_text: str = %str%i
        echo `repeat index = {i_text}`
    }

    ; ---------- iterate ----------
    showTitle("iterate")

    ; Array iteration
    set nums: arr<num> = [1, 2, 3]
    iterate (nums) => n
    {
        set n_text: str = %str%n
        echo `n = {n_text}`
    }

    ; String iteration (character by character)
    set word: str = "bat"
    iterate (word) => ch
    {
        echo ch
    }

    ; ---------- circle ----------
    showTitle("circle")

    ; Iterable rotating loop example
    set colors: arr<str> = ["R", "G", "B"]
    set circle_count: num = 0

    ; circle rotates infinitely; relies on break to exit
    circle (colors) => c
    {
        set circle_count = circle_count + 1
        echo c

        ; Exit when the step limit is reached
        if (circle_count >= MAX_CIRCLE_STEPS)
        {
            break
        }
    }

    ; Closing message
    echo "Done."
}

; Entry point call
main()
```

### Interactive Four-Operation Calculator

```batscript
# Description: Interactive four-operation calculator (with expression parsing, operator precedence, and parentheses)
# Author: ChatGPT
# Date: 2026-04-01
# File: Calculator.bs
# Version: 1.0.0

; ==============================
; Utility functions: character classification
; ==============================

# Description: Check whether a character is a digit 0-9
# Param [ch]: A single-character string
# Return: True if digit, otherwise False
func isDigit(ch: str) -> bool
{
    if (ch >= "0" and ch <= "9")
    {
        return True
    }
    return False
}

# Description: Check whether a character is whitespace (space or tab)
# Param [ch]: A single-character string
# Return: True if whitespace, otherwise False
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
; Lexer: split the expression string into a token sequence
; ==============================

# Description: Split an expression into a token array (numbers, operators, parentheses)
# Param [expr]: Raw expression string
# Return: Token array (arr<str>)
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
; Recursive descent parser (using a global cursor)
; Supports: + - * /, parentheses, unary plus/minus
; ==============================

; Global token list and cursor
set g_tokens: arr<str> = []
set g_tok_len: num = 0
set g_pos: num = 0

# Description: Check whether there are unread tokens remaining
# Return: True if tokens remain, otherwise False
func hasMoreTokens() -> bool
{
    return g_pos < g_tok_len
}

# Description: Peek at the current token without advancing; returns empty string if none
# Return: Current token or empty string
func peekToken() -> str
{
    if (hasMoreTokens())
    {
        return g_tokens[g_pos]
    }
    return ""
}

# Description: Advance the token cursor by one position
proc advanceToken()
{
    set g_pos = g_pos + 1
}

# Description: Parse a factor: number, parenthesized expression, or unary plus/minus
# Return: Numeric result
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

# Description: Parse a term: handle * /
# Return: Numeric result
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

# Description: Parse an expression: handle + -
# Return: Numeric result
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
; Expression evaluation wrapper
; ==============================

# Description: Tokenize, parse, and print the result of an input expression
# Param [expr]: Expression string
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
; Main flow: interactive REPL
; ==============================

# Description: Interactive four-operation calculator entry point
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

; Entry point call
main()
```

### Student Grade Management System

```batscript
# Description: Student grade management system (using SimpKv for persistence, semicolon-delimited lists)
# Author: ChatGPT
# Date: 2026-04-01
# File: StudentGradeSystem.bs
# Version: 1.0.0

lib SimpKv

; --------------------------------
; Global configuration
; --------------------------------
set storage_file: str = "students.db" ; Used if SimpKv requires external configuration

; --------------------------------
; Validation and utility functions
; --------------------------------

# Description: Check whether a string is non-empty
# Param [v]: String to check
# Return: True if non-empty, otherwise False
func isNonEmpty(v: str) -> bool
{
    return ?v
}

# Description: Check whether a name (student or subject) is valid: non-empty and contains no ';' or '='
# Param [name]: Name to check
# Return: True if valid
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

# Description: Check whether a score text is validly formatted (digits and at most one decimal point, up to two decimal places)
# Param [txt]: Raw score input
# Return: True if valid
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

    ; A lone "." is not allowed
    if (digit_count > 0 and dot_count == 1 and dec_len == 0)
    {
        return False
    }

    ; Range check
    set val: num = %num%txt
    if (val < 0 or val > 100)
    {
        return False
    }

    return True
}

# Description: Convert valid score text to a numeric value
# Param [txt]: Score text that has already passed format validation
# Return: Numeric score
func toScore(txt: str) -> num
{
    if (not isValidScoreText(txt))
    {
        err "Score format invalid (0-100, up to 2 decimals)"
    }

    set val: num = %num%txt
    return val
}

# Description: Split a string by a single-character delimiter
# Param [src]: Source string
# Param [sep]: Single-character delimiter
# Return: Array of split segments
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

# Description: Join a string array with a separator
# Param [items]: String array
# Param [sep]: Separator
# Return: Joined string
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

# Description: Check whether a student exists (based on stored records)
# Param [name]: Student name
# Return: True if exists
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
; Storage operation wrappers
; --------------------------------

# Description: Read the raw student record ("subject=score" entries separated by semicolons)
# Param [name]: Student name
# Return: Record string, or empty string if none
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

# Description: Save a raw student record
# Param [name]: Student name
# Param [data]: Record string
proc saveStudentRaw(name: str, data: str)
{
    set key: str = "student:" .. name
    SimpKv.set(key, data)
}

# Description: Get a student's subject-score pair array (e.g. ["Math=95", ...])
# Param [name]: Student name
# Return: Array; empty array if no record exists
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

# Description: Save a subject-score pair array
# Param [name]: Student name
# Param [pairs]: Array of the form ["Math=95", ...]
proc saveStudentPairs(name: str, pairs: arr<str>)
{
    set data: str = ""
    if (@pairs > 0)
    {
        set data = joinArrWithSep(pairs, ";")
    }
    saveStudentRaw(name, data)
}

# Description: Insert or update the global student list (global key "students")
# Param [name]: Student name
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

# Description: Remove a specific student from the student list
# Param [name]: Student name
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

# Description: Delete a student record (set to empty)
# Param [name]: Student name
proc deleteStudentRecord(name: str)
{
    saveStudentRaw(name, "")
}

; --------------------------------
; Business logic
; --------------------------------

# Description: Set or update a subject score for a given student
# Param [name]: Student name
# Param [subject]: Subject name
# Param [score_txt]: Score text
proc setSubjectScore(name: str, subject: str, score_txt: str)
{
    set _ = toScore(score_txt) ; Ensure validity

    set pairs: arr<str> = getStudentPairs(name)
    set updated: arr<str> = []
    set replaced: bool = False
    set i: num = 0
    set n: num = @pairs

    while (i < n)
    {
        set p: str = pairs[i]
        ; Split p into sub=val
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

# Description: Query and print all subject scores and average score for a given student
# Param [name]: Student name
proc queryStudent(name: str)
{
    if (not studentExists(name))
    {
        echo "Student does not exist"
        return
    }

    set pairs: arr<str> = getStudentPairs(name)
    set total: num = @pairs

    echo `Student: {name}`

    if (total == 0)
    {
        echo "No grade records"
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
    echo `Average score: {avg_txt}`
}

# Description: List all students
proc listStudents()
{
    set list_raw: str? = SimpKv.get("students")

    if (not ?list_raw or list_raw == "")
    {
        echo "No student records"
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
        echo "No student records"
    }
}

# Description: Add a student or ensure the student exists (creates an empty record only)
proc addStudent()
{
    set name: str = getin "Student name>>"

    if (not isValidName(name))
    {
        err "Name must be non-empty and must not contain ';' or '='"
    }

    if (not studentExists(name))
    {
        saveStudentPairs(name, [])
        upsertStudentList(name)
        echo "Student created"
    }
    else
    {
        echo "Student already exists (no changes made)"
    }
}

# Description: Enter or update a subject score
proc inputScore()
{
    set name: str = getin "Student name>>"

    if (not isValidName(name))
    {
        err "Name must be non-empty and must not contain ';' or '='"
    }

    if (not studentExists(name))
    {
        echo "Student does not exist — creating empty record automatically"
        saveStudentPairs(name, [])
        upsertStudentList(name)
    }

    set subject: str = getin "Subject>>"

    if (not isValidName(subject))
    {
        err "Subject must be non-empty and must not contain ';' or '='"
    }

    set score_txt: str = getin "Score (0-100, up to 2 decimal places)>>"

    if (not isValidScoreText(score_txt))
    {
        err "Invalid score format"
    }

    setSubjectScore(name, subject, score_txt)
    echo "Score saved"
}

# Description: Delete a student and their grades
proc deleteStudent()
{
    set name: str = getin "Student name>>"

    if (not studentExists(name))
    {
        echo "Student does not exist"
        return
    }

    removeStudentFromList(name)
    deleteStudentRecord(name)
    echo "Deleted"
}

# Description: Display the menu
proc showMenu()
{
    echo ""
    echo "==== Student Grade Management System ===="
    echo "1) Add student"
    echo "2) Enter / update grade"
    echo "3) Query student grades"
    echo "4) List all students"
    echo "5) Delete student"
    echo "6) Exit"
}

# Description: Main flow
proc main()
{
    loop
    {
        showMenu()
        set choice: str = getin "Choose>>"

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
            set name_q: str = getin "Student name>>"
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
            echo "Exited"
            break
        }
        else
        {
            echo "Invalid option"
        }
    }
}

; Entry point
main()
```

### Combining with Native BAT Inline Embedding

```batscript
# Description: Demonstrates combining batScript with native BAT inline embedding (runraw and $|)
# Author: ChatGPT
# Date: 2026-04-01
# File: NativeBridge.bs
# Version: 1.0.0

# Description: Demonstrates how to pass batScript variables into native BAT and use them inside runraw
proc showNativeInterop()
{
    ; Prepare a numeric variable
    set counter: num = 42
    ; Get the compiled native variable name (without %) for BAT segment expansion
    set counter_raw: str = $|counter

    echo "=== batScript section ==="
    set counter_txt: str = %str%counter
    echo `counter (batScript) = {counter_txt}`

    ; Single-line runraw example
    runraw: "echo [BAT] single-line runraw reached."

    ; Block runraw example (can mix string literals and variable fragments)
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
        "echo Current directory listing (BAT dir):",
        "dir",
        "echo --- Native BAT block end ---"
    }
}

# Description: Main entry point
proc main()
{
    showNativeInterop()
    echo "Back in batScript after runraw."
}

; Entry point call
main()
```

### Comprehensive Reference for Other Syntax

```batscript
# Description: batScript comprehensive syntax demo (covering features not heavily showcased before)
# Author: ChatGPT
# Date: 2026-04-01
# File: OtherSyntaxDemo.bs
# Version: 1.0.0

; =====================================================
; Group and documentation comment example
; =====================================================

# Description: Demonstrates global grouping and constants
# Author: ChatGPT
group DemoGroup
{
    set greeting_prefix: str = "Hi"
    let MAX_NAME_LEN: num = 12
}

; =====================================================
; Constraint functions (for match binding)
; =====================================================

# Description: Check whether a numeric value is non-negative
# Param [v]: Value to validate
# Return: True if non-negative
func isNonNegative(v: num) -> bool
{
    return v >= 0
}

# Description: Check whether a string is non-empty and does not exceed a given length limit
# Param [v]: String to validate
# Param [limit]: Maximum length
# Return: True if compliant
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
; Helper procedures
; =====================================================

# Description: Safely print a type string
# Param [label]: Name label
# Param [val_type]: Type string
proc showType(label: str, val_type: str)
{
    echo `type({label}) = {val_type}`
}

# Description: Print a section header
# Param [title]: Title
proc section(title: str)
{
    echo ""
    echo "----"
    echo title
    echo "----"
}

; =====================================================
; Main flow
; =====================================================

# Description: Main flow covering conf flags, slicing, pair access, ! swap, constraints, and more
proc main()
{
    ; ---------- conf example ----------
    ; If /d is passed at runtime, print a debug hint (e.g.: MyScript.bat /d)
    if (conf d): echo "Debug flag /d detected"

    section("match constraint binding")
    ; Once bound, every assignment is automatically validated; the initial value must satisfy the constraint
    set balance: num = 0 match isNonNegative(balance)
    set balance_text: str = %str%balance
    echo `balance = {balance_text}`

    ; One-time deposit amount demo (requires valid numeric input)
    set deposit_raw: str = getin "Deposit amount (num >= 0)>>"
    set deposit_val: num = %num%deposit_raw
    set balance = balance + deposit_val
    set balance_text = %str%balance
    echo `balance updated = {balance_text}`

    section("group and constant/variable access")
    echo `greeting_prefix = {DemoGroup.greeting_prefix}`
    set max_len_text: str = %str%DemoGroup.MAX_NAME_LEN
    echo `MAX_NAME_LEN = {max_len_text}`

    section("nullable types and Nil/Inf")
    set maybe_score: num? = Nil
    if (?maybe_score)
    {
        set score_txt: str = %str%maybe_score
        echo `score = {score_txt}`
    }
    else
    {
        echo "maybe_score is Nil, assigning default 95"
        set maybe_score = 95
        set score_txt = %str%maybe_score
        echo `score = {score_txt}`
    }

    set infinite_val: num = Inf
    set inf_type: str = &infinite_val
    showType("infinite_val", inf_type)
    if (infinite_val == Inf): echo "Inf comparison works"

    section("array append / delete / slice / negative index")
    set nums: arr<num> = [1, 2, 3, 4]
    nums^ 5                  ; Append
    ^nums 1                  ; Delete element at index 1 (no return value)
    ^nums                    ; Delete last element
    ; At this point nums is [1, 3, 4]
    set last_num: num = nums[-1]
    set last_num_txt: str = %str%last_num
    echo `last_num = {last_num_txt}`
    set slice_nums: arr<num> = nums[0:2]   ; Take first two elements
    set slice_len_txt: str = %str%@slice_nums
    echo `slice_len = {slice_len_txt}`

    section("string slicing and reversal")
    set word: str = "batScript"
    set part: str = word[3:9]      ; Expected: "Script"
    set word_rev: str = !word      ; Reverse
    echo `part = {part}`
    echo `word_rev = {word_rev}`

    section("pair access and swap !pair")
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

    section("type string operator & and raw variable name $|")
    set t_balance: str = &balance
    showType("balance", t_balance)
    set raw_name_balance: str = $|balance
    echo `raw var name of balance = {raw_name_balance}`

    section("b-string interpolation with variables only (conversion demo)")
    set len_word: num = @word
    set len_word_txt: str = %str%len_word
    echo `len(word) = {len_word_txt}`

    section("correct use of condition (value branches, single-line only)")
    set op: str = getin "Choose op (+/-/other)>>"
    condition op
    {
        "+": echo "add selected"
        "-": echo "sub selected"
        /: echo "other selected"
    }

    section("loop => iteration counter demo (finite demo then break)")
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

; Entry point
main()
```
