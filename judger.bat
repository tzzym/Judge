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
del %project%.exe
del %project%%input_expanded-name%
del %project%%output_expanded-name%