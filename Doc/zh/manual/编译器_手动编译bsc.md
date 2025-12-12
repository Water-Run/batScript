# 手动编译batScript编译器  

`batScript`的编译器`bsc.exe`是由单`.lua`实现的.  
`batScript`的源码位于[GitHub链接](https://github.com/Water-Run/batScript),源码位于`bsc/src`下的`bsc.lua`.  
如果你不想使用提供下载的`bsc.exe`或有其它需求(如跨平台),你可以自行将`bsc.lua`打包为`.exe`,或者就直接使用`lua`解释器执行.不过,`batScript`有一套推荐的手动编译流程.  

## 推荐的手动编译流程  

1. 从[GitHub链接](https://github.com/Water-Run/batScript)拉取源码  
2. 使用[luaToEXE](https://github.com/Water-Run/luaToEXE/tree/main)将`bsc/src/bsc.lua`打包编译为`bsc.exe`可执行文件  
3. 使用[图标封装器]()封装位于`resources/batScript.ico`图标.本步骤是可选的.  

> 需要注意的是,编译后的`bsc.exe`并不是即刻可用的.你还需要将`batScript`的内置库`bslib`目录放在同级目录  
