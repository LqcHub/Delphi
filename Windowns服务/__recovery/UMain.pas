unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs, IniFiles, win.Registry, Winapi.ShellAPI,
  Winsvc, DateUtils;

type
  TMyWinService = class(TService)
    procedure ServiceExecute(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceDestroy(Sender: TObject);
    procedure ServiceShutdown(Sender: TService);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceAfterUninstall(Sender: TService);
  private
    SelfPath: string;
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
    LogFileName := Dir + '日志.log';
    if not FileExists(LogFileName) then
    begin
      AssignFile(LogFile, LogFileName);
      Rewrite(LogFile);
      CloseFile(LogFile); // 关闭时自动保存文件
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

procedure TMyWinService.MyRun;
var
  LogFile: TextFile;
  LogFileName: string;
  Dir: string;
begin
  Dir := ExtractFileDir(ParamStr(0)) + 'log\';
  if not FileExists(Dir) then
  begin
    ForceDirectories(Dir);
  end;
  LogFileName := Dir + '线程.log';
  if not FileExists(LogFileName) then
  begin
    AssignFile(LogFile, LogFileName);
    Rewrite(LogFile);
    CloseFile(LogFile); // 关闭时自动保存文件
  end;
  AssignFile(LogFile, LogFileName);
  Append(LogFile);
  Writeln(LogFile, LogFileName);
  CloseFile(LogFile);
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
        WriteString('Description', '测试win服务'); //添加win服务描述
      end;
      CloseKey;
    end;
  finally
    reg.Free;
  end;
  SaveLog('AfterInstall:' + ' ----- ' + formatdatetime('dd-hh:nn:ss', now));
  SaveLog('服务安装成功:' + ' ----- ' + formatdatetime('dd-hh:nn:ss', now));
end;

procedure TMyWinService.ServiceAfterUninstall(Sender: TService);
begin
  SaveLog('服务卸载成功:' + ' ----- ' + formatdatetime('dd-hh:nn:ss', now));
end;

procedure TMyWinService.ServiceDestroy(Sender: TObject);
begin
  SaveLog('Destroy:' + ' ----- ' + formatdatetime('dd-hh:nn:ss', now));
end;

procedure TMyWinService.ServiceExecute(Sender: TService);
var
  ID: THandle;
  myThread: TThread;
begin
  SaveLog('Execute执行' + ' ----- ' + formatdatetime('dd-hh:nn:ss', now));

           //创建线程
  myThread := TThread.CreateAnonymousThread(
    procedure
    begin
      while True do
      begin
        if (DateTimeToUnix(Now) mod 60) = 0 then
        begin
          MyRun;
        end;
      end;
    end);

  myThread.Start;
end;

procedure TMyWinService.ServicePause(Sender: TService; var Paused: Boolean);
begin
  SaveLog('Pause:' + ' ----- ' + formatdatetime('dd-hh:nn:ss', now));
end;

procedure TMyWinService.ServiceShutdown(Sender: TService);
begin
  SaveLog('Shutdown:' + ' ----- ' + formatdatetime('dd-hh:nn:ss', now));
end;

procedure TMyWinService.ServiceStart(Sender: TService; var Started: Boolean);
begin

  SaveLog('Start:' + ' ----- ' + formatdatetime('dd-hh:nn:ss', now));
end;

procedure TMyWinService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  SaveLog('Stop:' + ' ----- ' + formatdatetime('dd-hh:nn:ss', now));
end;

end.

