###############
# Name: ���÷���
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: PowerShell iex(New-Object Net.WebClient).DownloadString('http://dwz.cn/3F1DAOwT')
###############

$Services = @(
@{
    Name = "diagnosticshub.standardcollector.service";
    DisplayName = "Microsoft (R) ������ı�׼�ռ�������";
    Intro = "������ã�������ı�׼�ռ�������";
}
@{
    Name = "DiagTrack";
    DisplayName = "Connected User Experiences and Telemetry";
    Intro = "������ã����ڸĽ� Windows ƽ̨�����������";
}
@{
    Name = "dmwappushservice";
    DisplayName = "dmwappushsvc";
    Intro = "������ã�WAP ����Ϣ·�ɷ���";
}
@{
    Name = "lfsvc";
    DisplayName = "Geolocation Service";
    Intro = "������ã����ڻ�ȡ��Ȼλ����Ϣ�ķ��񣬽��ý��޷���λ��";
}
@{
    Name = "MapsBroker";
    DisplayName = "Downloaded Maps Manager";
    Intro = "������ã���Ӧ�ó�����������ص�ͼ�ķ��񣬽���Ӧ�ó����޷����ʵ�ͼ";
}
@{
    Name = "NetTcpPortSharing";
    DisplayName = "Net.Tcp Port Sharing Service";
    Intro = "������ã��ṩͨ�� net.tcp Э�鹲�� TCP �˿ڵĹ���";
}
@{
    Name = "RemoteAccess";
    DisplayName = "Routing and Remote Access";
    Intro = "������ã��ھ������Լ�������������Ϊ��ҵ�ṩ·�ɷ���";
}
@{
    Name = "RemoteRegistry";
    DisplayName = "Remote Registry";
    Intro = "������ã�����Զ���޸�ע���";
}
@{
    Name = "SharedAccess";
    DisplayName = "Internet Connection Sharing (ICS)";
    Intro = "������ã�Ϊ��ͥ��С�Ͱ칫�����ṩ�����ַת����Ѱַ�����ƽ�����/�����ֱ�������";
}
@{
    Name = "TrkWks";
    DisplayName = "Distributed Link Tracking Client";
    Intro = "������ã�ά��ĳ��������ڻ�ĳ�������еļ������ NTFS �ļ�֮�������";
}
@{
    Name = "WbioSrvc";
    DisplayName = "Windows Biometric Service";
    Intro = "������ã�����ʶ�����";
}
@{
    Name = "WlanSvc";
    DisplayName = "WLAN AutoConfig";
    Intro = "������ã��������������鿪��";
}
@{
    Name = "WMPNetworkSvc";
    DisplayName = "Windows Media Player Network Sharing Service";
    Intro = "������ã����弴���豸���������粥�Ż���ý���豸����ý���";
}
@{
    Name = "WSearch";
    DisplayName = "Windows Search";
    Intro = "������ã�Ϊ�ļ��������ʼ������������ṩ�������������Ի�����������";
}
@{
    Name = "XblAuthManager";
    DisplayName = "Xbox Live �����֤������";
    Intro = "�������";
}
@{
    Name = "XblGameSave";
    DisplayName = "Xbox Live ��Ϸ����";
    Intro = "�������";
}
@{
    Name = "XboxNetApiSvc";
    DisplayName = "Xbox Live �������";
    Intro = "�������";
}
@{
    Name = "DusmSvc";
    DisplayName = "����ʹ����";
    Intro = "�������";
}
@{
    Name = "vmms";
    DisplayName = "Hyper-V ���������";
    Intro = "�������";
}
@{
    Name = "CDPSvc";
    DisplayName = "�����豸ƽ̨����";
    Intro = "�������";
}
)

foreach ($Service in $Services)
{
    $reply = Read-Host "�Ƿ���� - $( $Service.DisplayName ) - $( $Service.Intro ) [Y/n]"
    if ($reply -match "[yY]")
    {
        Get-Service -Name $Service.Name | Set-Service -StartupType Disabled
    }
    else
    {
        Write-Warning -Message "������ $( $Service.DisplayName ) ����"
    }
}
