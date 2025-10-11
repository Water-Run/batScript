# `batScript`

[*Chinese Documentation*](README-zh.md)  

> Project under development  

Windows batch (`.bat`) is known for its retro and simplistic syntax. Although many scripts aim to replace Windows batch, however, due to the fact that `.bat` runtime is pre-installed on all Windows devices (including very old devices), as well as significant startup speed advantages (especially on older devices, even if the device has `powershell` pre-installed), and compatibility considerations, we often still need to endure writing `.bat`.  

**`batScript` is a procedural, strongly-typed scripting language designed to bring a more modern programming experience to `.bat` writing, with simple design and very easy to get started.** Just like `TypeScript` compiles to `JavaScript`, `batScript` code files (`.bs`) compile to `.bat` (i.e., `batScript` only has a frontend).  

**`batScript` brings the following features to `.bat` writing:**  

- **Type system**: Including **string** `str`, **boolean** `bool`, **number** `num`, **one-dimensional array** `arr`, and **null type** `Nil`  
- **Case-sensitive variables and constants**: Supports **case-sensitive variable names**. Use `set` to define variables, use `let` to define constants  
- **Normal comments and operators**: Supports **single-line comments** `#` and **multi-line comments** `/**/` (can be nested). Operators are designed according to modern programming language conventions, such as **arithmetic operators** `+`, `-`, `*`, `/`, **relational operators** `==`, `~=`, `>`. As well as other operators, such as **type string operator** `@`, **null-check operator** `?`, **iterable (array and string) concatenation operator** `..`, **length operator** `&`, etc.  
- **Normal and useful control flow**: Including **conditional statements** `if-elif-else` and **loop statements** (`while` ordinary loop and iterable loop `iterate`, including `continue` and `break`), **all support nesting**, as well as single-line representation and counting variable syntax sugar. The most basic **exception handling** `err` (can define exception type and prompt information), and other flow control statements (such as `endprogram`)  
- **Functions and procedures**: Supports functions with return values (**`func`**) and procedures without return values (**`proc`**). Functions support recursion, with variable scope defaulting to within the function, including declaring/calling global scope with `glob`  
- **Module management and standard library**: Provides **basic module management** (C-like header file inclusion mechanism) and a built-in standard library. Import through keywords `lib` and `pkg`, `expose` controls content exposed by files  
- **Native .bat embedding**: Can use `insert` to embed native `.bat` files, or dynamically execute native `.bat` statements through `run`  
- **Visual Studio Code plugin**: Provides a VS Code plugin, including basic features like **syntax highlighting** and **type hints**  

`batScript` follows these **design principles**:  

- *Simple, elegant, and readable code*  
- *No dependencies: the compiled `.bat` is itself a valid batch file*  

> `batScript` is open source on [GitHub](https://github.com/Water-Run/batScript/tree/main), using MIT license  

> `batScript` is implemented by a single `.lua` file and packaged as `.exe`  

## Learning `batScript`

**`batScript` is very simple, with complete documentation support.** If you have some programming language background (otherwise, you probably wouldn't know about this project), getting started will be very quick.  

- [Getting Started Tutorial](./doc/zh/guide/01-教程目录.md)  
- [Technical Manual](./doc/zh/manual/手册导引.md)  
