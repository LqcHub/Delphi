unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs, IniFiles, win.Registry, Winapi.ShellAPI,
  Winsvc, DateUtils, Vcl.ExtCtrls, ActiveX;

type
  TMyWinService = class(TService)
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceDestroy(Sender: TObject);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
  private
    myThread: TThread;
    IsStop: boolean;
    procedure MyRun;
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  MyWinService: TMyWinService;

implementation

{$R *.dfm}

procedure SaveLog(LogString: string);
var
  LogFile: TextFile;
  LogFileName: string;
  Dir: string;
  Flist: TStringlist;
begin
  try
    Dir := ExtractFileDir(ParamStr(0)) + 'log\';
    if not FileExists(Dir) then
    begin
      ForceDirectories(Dir);
    end;
    LogFileName := Dir + '��־.log';
    if not FileExists(LogFileName) then
    begin
      AssignFile(LogFile, LogFileName);
      Rewrite(LogFile);
      CloseFile(LogFile); // �ر�ʱ�Զ������ļ�
    end;
    AssignFile(LogFile, LogFileName);
    Append(LogFile);
    Writeln(LogFile, LogString);
    Writeln(LogFile, '');
    CloseFile(LogFile);
  except
    on e: Exception do
    begin
      Flist := TStringlist.Create;
      Flist.Add(e.Message);
      Flist.SaveToFile(ExtractFileDir(ParamStr(0)) + '\erro.log');
      Flist.Free;
    end;
  end;
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  MyWinService.Controller(CtrlCode);
end;

function TMyWinService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TMyWinService.ServiceAfterInstall(Sender: TService);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    with reg do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      if OpenKey('SYSTEM\CurrentControlSet\Services\' + Name, false) then
      begin
        WriteString('Description', '����win����'); //���win��������
      end;
      CloseKey;
    end;
  finally
    reg.Free;
  end;
  SaveLog('AfterInstall:' + ' ----- ' + formatdatetime('dd-hh:nn:ss', now));
  SaveLog('����װ�ɹ�:' + ' ----- ' + formatdatetime('dd-hh:nn:ss', now));
end;

procedure TMyWinService.ServiceDestroy(Sender: TObject);
begin
  SaveLog('Destroy:' + ' ----- ' + formatdatetime('dd-hh:nn:ss', now));
end;

procedure TMyWinService.MyRun;
begin
  while IsStop = false do
  begin
    SaveLog('�߳�ִ�У�' + DateTimeToUnix(Now).Tostring);
    myThread.sleep(5000);
  end;
end;
// OnExecute�¼���д����Ͳ������,���д��ִ����Ϸ�����������
// OnExecute�¼�����������̻߳�timer����ʹ�̻߳�timer��ûִ����ɷ���Ҳ�����

procedure TMyWinService.ServiceStart(Sender: TService; var Started: Boolean);
begin
  myThread := TThread.CreateAnonymousThread(
    procedure
    begin
      MyRun;
    end);
  myThread.FreeOnTerminate := true;
  myThread.Start;
  SaveLog('�߳�������' + DateTimeToUnix(Now).Tostring);
end;

procedure TMyWinService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  SaveLog('Stop:' + ' ----- ' + formatdatetime('dd-hh:nn:ss', now));
  IsStop := true;
  myThread.Terminate;
  SaveLog('�߳�ֹͣ��' + DateTimeToUnix(Now).Tostring);
end;

end.

