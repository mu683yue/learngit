
@echo off
::设置7z的命令行程序路径
set tar=C:\Program Files\WinRAR\WinRAR.exe
::设置压缩包保存路径
set Save=G:\林\代码\压缩
::当天日期，备份文件名
set curdate=%date:~0,4%-%date:~5,2%-%date:~8,2%
::设置要打包压缩的文件夹

set file=G:\林\代码\原代码\CLCTPolicy\3rdparty
set n=1
::压缩命令 -xr!.svn过滤.svn文件夹
"%tar%" a  "%Save%\%curdate%-%n%.rar" "%file%"  -xr!.svn
echo  -------------第%n%次压缩-------------

::设置压缩次数
set m=3
:next
::设置要再次打包压缩的压缩包
set reZip=G:\林\代码\压缩\%curdate%-%n%.rar
echo %n%
echo %reZip%

set /a n+=1
::压缩命令 -xr!.svn过滤.svn文件夹
"%tar%" a  "%Save%\%curdate%-%n%.rar" "%reZip%"  -xr!.svn

set /a x=n-1
if %x% gtr 0  (del /f /s /q "%Save%\%curdate%-%x%.rar")

echo  -------------第%n%次压缩-------------

if  %n%==%m% pause
goto next

pause