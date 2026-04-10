# 自己在家制作了一个测试C++程序的批处理 #
优点：

1. 不需要提前编译，不需要在程序中进行输入输出重定向
2. 加入变量，使批处理代码可读性强，应对不同题目测试时不需要在批处理代码中修改
3. 将已有测试数据的编号写在$%project%_judger-number.txt$中，因为txt文件比批处理文件编辑起来要容易一些
4. 最后批处理会自动清理垃圾

注意：

1. 著作权归tzzym所有
2. 使用前必须检查$g++.exe$是否在环境变量$PATH$下，否则会出错
3. 使用前必须仔细阅读《使用说明》，不懂的见
[样例](https://pan.baidu.com/s/1av-OESEeMJHhjMwzEOnkvQ?pwd=yi5vhttps://pan.baidu.com/s/1av-OESEeMJHhjMwzEOnkvQ?pwd=yi5v)
及《样例说明》

使用说明：

1. 确定批处理中的变量的取值
	1. $%project%$，编程题目的英文名
	2. $%input_expanded-name%$，输入测试数据扩展名，一般为$.in$
	3. $%output_expanded-name%$，输出测试数据扩展名，有时为$.out$，csp为$.ans$
	4. $%x%$，优化级别，为数字（$1$则为不优化，$2$则为O2优化，$3$则为O3优化……
2. 确定已有测试数据的编号，每个编号一行，写在$%project%_judger-number.txt$中
3. 准备好源程序，命名为$%project%.cpp$，不需要编译，不要加freopen语句；准备好测试数据命名为$%project%%input_expanded-name%$或$%project%%output_expanded-name%$。以上内容和
4. 打开批处理，依次按提示输入变量取值
5. 等待编译，编译失败后会报错。完成后按任意键。如果编译失败且目录下没有保留之前编译好的%project%.exe，程序就会退出，否则会开始测试
6. 每测试一个测试数据，如果正确，则显示$FC: 找不到差异$，否则会显示出差异
7. 测试完成后程序自动退出

样例说明：

- $%project%$为$candy$
- $%input_expanded-name%$为$.in$
- $%output_expanded-name%$为$.ans$

代码：
```
@echo off

echo program: judger
echo writter:	 Zhao Yanming (All Rights)
echo.
    
setlocal
set /P project=project:
set /P input_expanded-name=input_expanded-name:
set /P output_expanded-name=output_expanded-name:
set /P x=-O

echo start compiling on %date% %time%
if %x%=="" (
    g++.exe "%~dp0%project%.cpp" -o "%~dp0%project%.exe" -Wextra -I"%CppIncludeDir0%" -I"%CppIncludeDir1%" -I"%CppIncludeDir2%" -I"%CppIncludeDir2%\c++" -L"%LibDir0%" -L"%LibDir1%" -static-libgcc
) else g++.exe "%~dp0%project%.cpp" -o "%~dp0%project%.exe" -O%x% -Wextra -I"%CppIncludeDir0%" -I"%CppIncludeDir1%" -I"%CppIncludeDir2%" -I"%CppIncludeDir2%\c++" -L"%LibDir0%" -L"%LibDir1%" -static-libgcc
pause
    
for /f %%i IN (%project%_judger-number.txt) do (
    echo.
    copy %project%%%i%input_expanded-name% %project%%input_expanded-name% >nul
    echo #%%i starting judging...
    echo %time%_beginning
    %project%.exe <%project%%input_expanded-name% >%project%%output_expanded-name%
    echo %time%_end
    FC %project%%%i%output_expanded-name% %project%%output_expanded-name%
    pause
)
::垃圾清理
del %project%.exe
del %project%%input_expanded-name%
del %project%%output_expanded-name%
```