@echo off
title ���� ShellExperienceHost
cls
color 0A

rem �����ű����Թ���Ա����
%1 start "" mshta vbscript:CreateObject("Shell.Application").^
ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)^
(window.close)&&exit

taskkill /F /IM ShellExperienceHost.exe &
taskkill /F /IM ShellExperienceHost.exe &
move "%windir%\SystemApps\ShellExperienceHost_cw5n1h2txyewy" "%windir%\SystemApps\ShellExperienceHost_cw5n1h2txyewy.bak"

Pause
