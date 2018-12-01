###############
# Name: auto source file
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: PowerShell iex(New-Object Net.WebClient).DownloadString('https://dwz.cn/mPPBKOv2')
###############

function AutoSource($FilePath, $LocalPath, $RemoteUri)
{
    # ����Ĭ�ϱ���·��
    if (($LocalPath -eq "") -or ($LocalPath -eq $null))
    {
        $LocalPath = "$env:ScriptLocalPath"
    }
    # ����Ĭ��Զ��·��
    if (($RemoteUri -eq "") -or ($RemoteUri -eq $null))
    {
        $RemoteUri = "$env:ScriptRemoteUri"
    }
    # �ű�ִ��
    if (Test-Path "$LocalPath/$FilePath")
    {
        . "$LocalPath/$FilePath"
    }
    else
    {
        iex(New-Object Net.WebClient).DownloadString("$RemoteUri/$FilePath")
    }
}
