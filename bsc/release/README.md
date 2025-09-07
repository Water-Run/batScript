# bsc: batScript Compiler  

`version 0.1`  

**`bsc`是`batScript`的编译器.`batScript`是一个旨在为`.bat`的编写提供更现代的语法支持的开源的结构化,静态的脚本语言.**  
就像`.js`编译为`.ts`一样,`.bs`(`batScript`代码文件)编译为`.bat`.  
`bsc`适用于Windows 32/64位平台,以`.zip`形式分发.*md5校验码:`12312312313`.*  
`batScript`具备**完整的文档支持.**  

## 安装  

1. 从[发布页面](#)下载`batScript-release v0.1.zip`并解压到合适目录  
2. 将解压后的根目录添加至系统环境变量(及和本README.md同级目录),重启设备  

打开终端,执行  

```powershell
bsc -v
```

输出

```powershell
batScript Compiler by WaterRun: version 0.1
See more on https://github.com/Water-Run/batScript :)
```

说明安装成功.  

将以下代码块复制,新建`FirstBatScript.bs`文件并粘贴:  

```batscript
lib Std;

Std.print("My first batScript: HelloWorld!");
```

然后,在`FirstBatScript.bs`的同级目录打开终端,执行以下命令:  

```powershell
bsc -c FirstBatScript.bs FirstBatScript.bat
```

输出

```powershell
batScript: compile sucess
```

打开生成的`FirstBatScript.bat`,出现  

```cmd
My first batScript: HelloWorld!
```

你的`batScript`已经可用.  

## 链接  

[bsc内置的帮助功能]()  
[上手教程]()  
[技术手册]()  
[GitHub]()  
