@echo off
title ���� Cortana
cls
color 0A

rem �����ű����Թ���Ա����
%1 start "" mshta vbscript:CreateObject("Shell.Application").^
ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)^
(window.close)&&exit

taskkill /F /IM RemindersServer.exe &
taskkill /F /IM SearchUI.exe &
taskkill /F /IM PlacesServer.exe &
move "%windir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" "%windir%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy.bak"

Pause
