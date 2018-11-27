###############
# Name: �Ƴ�Ӧ��
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
###############

$reply = Read-Host "�Ƿ��Ƴ�����Ӧ�� [Y/n]"
if ($reply -match "[yY]")
{
    # ��ȡ����Ȩ
    takeown /f %ProgramFiles%\WindowsApps /a /r /d Y
    # ��ȡӦ������Ȩ
    icacls %ProgramFiles%\WindowsApps /grant "ALL APPLICATION PACKAGES:(OI)(CI)F" /t /q
    # ɾ������Ӧ��
    Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null
    Get-AppxPackage -AllUsers | Remove-AppxPackage 2>&1 | Out-Null
    exit 0
}

$Apps = @(
@{
    Name = "3dbuilder";
    DisplayName = "3D Builder";
}
@{
    Name = "officehub";
    DisplayName = "Office";
}
@{
    Name = "skypeapp";
    DisplayName = "Skype";
}
@{
    Name = "zunemusic";
    DisplayName = "";
}
@{
    Name = "solitairecollection";
    DisplayName = "";
}
@{
    Name = "zunevideo";
    DisplayName = "";
}
@{
    Name = "bingfinance";
    DisplayName = "��Ӧ����";
}
@{
    Name = "bingnews";
    DisplayName = "��Ӧ����";
}
@{
    Name = "onenote";
    DisplayName = "OneNote";
}
@{
    Name = "bingsports";
    DisplayName = "��Ӧ����";
}
@{
    Name = "xboxapp";
    DisplayName = "Xbox";
}
@{
    Name = "Print3D";
    DisplayName = "Print 3D";
}
@{
    Name = "game";
    DisplayName = "��Ϸ";
}
@{
    Name = "MarchofEmpires";
    DisplayName = "�۹�����";
}
@{
    Name = "BubbleWitch3Saga";
    DisplayName = "����ħŮ����";
}
)

foreach ($App in $Apps)
{
    $reply = Read-Host "�Ƿ���� - $( $App.DisplayName ) [Y/n]"
    if ($reply -match "[yY]")
    {
        Get-AppxPackage *$App.Name * | Remove-AppxPackage
    }
    else
    {
        Write-Warning -Message "������ $( $Service.DisplayName ) Ӧ��"
    }
}
