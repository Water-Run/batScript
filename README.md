# `batScript`

> Project under development  

Windows Batch (`.bat`) is an outdated scripting language. It lacks many basic features of modern programming languages, and its keywords and operators differ significantly from contemporary standards, creating challenges for developers.  
**`batScript` is a procedural, strongly-typed scripting language. Similar to how `TypeScript` code files (`.ts`) are compiled into `JavaScript` code files (`.js`), `batScript` code files (`.bts`) are compiled into `.bat` by a compiler implemented in `C#`.**  
`batScript` aims to **bring a more modern experience to `.bat` scripting** by providing the following features (but not limited to):  

- **Type System**: Includes native support for integers (`int`), strings (`str`), and encapsulated implementations for booleans (`bool`), numbers (`num`), and optional types for arrays (`arr`).  
- **Case-Sensitive Variables and Constants**: Supports case-sensitive variables, along with the ability to declare variables using `set` and constants using `let`.  
- **Modern Control Flow**: Features include conditional statements (`if-elif-else`) and loops (`while` and its variants `loop`, `repeat`, as well as iterator-based loops `iterate`). Basic exception handling (`err`), basic scope control (`local`, etc.), and other flow control functions (e.g., `endprogram`) are also supported.  
- **Functions**: Supports functions with return values (`func`) and procedures without return values (`procedure`).  
- **Proper Commenting and Operators**: Includes support for single-line comments (`#`), multi-line comments (`/**/`), inline comments (`--<>`), and documentation comments (`@`). Operators use modern conventions, including basic arithmetic operators (e.g., `+`, `-`, `*`, `/`) and special operators, like the `?` operator for retrieving array lengths.  
- **Module Management and Standard Library**: Provides basic module management and a foundational standard library.  
- **Native `.bat` Embedding**: Allows for embedding `.bat` files using `insert` and dynamically executing native `.bat` statements using `run`.  
- **Visual Studio Code Plugin**: Includes basic features such as syntax highlighting and type suggestions.  

## Learning `batScript`

`batScript` is **simple and easy** to learn, with comprehensive documentation support.  

- [Tutorial](./doc/en/README.md)  
- [教程](./doc/zh/简介.md)  

*[GitHub](https://github.com/Water-Run/batScript)*
