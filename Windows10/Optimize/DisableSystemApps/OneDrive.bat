@echo off
title ɾ�� OneDrive
cls
color 0A

rem �����ű����Թ���Ա����
%1 start "" mshta vbscript:CreateObject("Shell.Application").^
ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)^
(window.close)&&exit

::��ʾ�û�����
echo.
echo ����ɾ��OneDrive���Ƿ������
echo.
echo �ǣ��밴�����������
echo �񣺵�����Ͻǣ��رձ����ڡ�
echo.
echo ���а�ȫ�������������ʾ�����м��ɡ�
pause

:: �������� (�������޷�ɾ���ļ�)
taskkill /f /im OneDrive.exe
taskkill /f /im explorer.exe

:: ����ж�ع���
if exist %SYSTEMROOT%\SysWOW64\OneDriveSetup.exe (
    %SYSTEMROOT%\SysWOW64\OneDriveSetup.exe /uninstall
) else (
    %SYSTEMROOT%\System32\OneDriveSetup.exe /uninstall
)

:: ɾ�������ļ�
rd  /s /q "%USERPROFILE%\OneDrive"
rd  /s /q "%LOCALAPPDATA%\Microsoft\OneDrive"
rd  /s /q "%PROGRAMDATA%\Microsoft OneDrive"

:: �Ƴ������ OneDrive ͼ��
reg delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
reg delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f

:: ���� explorer
start explorer

Pause
