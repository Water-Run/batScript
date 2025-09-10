# `batScript`

[*Chinese Documentation*](README-zh.md)  

> Project under development  

Windows batch (`.bat`) is known for its retro and simplistic syntax. Although many scripting languages (like `PowerShell`) aim to replace Windows batch, due to compatibility and other considerations, we often still need to write `.bat`.  
**`batScript` is a statically typed, procedural scripting language designed to bring a more modern programming experience to `.bat`.** Just like `TypeScript` compiles to `JavaScript`, `batScript` code files (`.bs`) compile to `.bat` (i.e., `batScript` only has a frontend).  

**`batScript` brings the following features to `.bat` writing:**  

- **Type system**: Including **string** `str`, **boolean** `bool`, **number** `num`, and **one-dimensional array** `arr`, with support for **null type** `Nil`.  
- **Case-sensitive variables and constants**: Supports **case-sensitive variable names**. Use `set` to define variables, `let` to define constants.  
- **Standard comments and operators**: Supports **single-line comments** `#` and **multi-line comments** `/**/`. Operators follow modern programming conventions, such as **arithmetic operators** `+``-``*``/`, **comparison operators** `==``~=``>=`. It also includes other operators, such as **type string operator** `@`, **null-check operator** `?`, **iterable (array/string) concatenation operator** `..`, and **length operator** `&`.  
- **Normal control flow**: Includes **conditional statements** `if-elif-else` and **loops** (`while` — standard loop, and `iterate` — iterable loop, both supporting `continue` and `break`), all **support nesting**. Also provides **basic exception handling** `err`, **scope control inside functions** (like `glob`), and other flow control (such as `endprogram`).  
- **Functions and procedures**: Supports functions (`func`) with return values and procedures (`proc`) without return values. Functions **support recursion**.  
- **Module management and standard library**: Provides **basic module management** (C-like header include mechanism) and a built-in standard library. Importing is performed via `lib` and `pkg`, with `out` controlling file exports.  
- **Native .bat embedding**: Supports embedding native `.bat` files via `insert`, or dynamically executing native `.bat` statements via `run`. Use `out` to control content exposure.  
- **Visual Studio Code plugin**: Offers a VS Code extension providing **syntax highlighting** and **type hints**.  

**Design principles of `batScript`:**  

- *Simple, elegant, and readable code*  
- *No dependencies: the compiled `.bat` is itself a valid batch file*  

> `batScript` is open source on [GitHub](https://github.com/Water-Run/batScript/tree/main), licensed under MIT.  

> `batScript` is implemented in a single `.lua` file, packaged as `.exe`.  

## Learning `batScript`

**`batScript` is very simple, with complete documentation support.** If you have some programming background (which you probably do if you’re looking at this project), getting started will be quick.  

- [Getting Started Guide](./doc/zh/guide/01-教程目录.md)  
- [Technical Manual](./doc/zh/manual/手册导引.md.md)
