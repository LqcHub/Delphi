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

procedure TMyWinService.ServiceDestroy(Sender: TObject);
begin
  SaveLog('Destroy:' + ' ----- ' + formatdatetime('dd-hh:nn:ss', now));
end;

procedure TMyWinService.MyRun;
begin
  while IsStop = false do
  begin
    SaveLog('线程执行：' + DateTimeToUnix(Now).Tostring);
    myThread.sleep(5000);
  end;
end;
// OnExecute事件不写服务就不会结束,如果写了执行完毕服务会立马结束
// OnExecute事件中如果开启线程或timer，即使线程或timer还没执行完成服务也会结束

procedure TMyWinService.ServiceStart(Sender: TService; var Started: Boolean);
begin
  myThread := TThread.CreateAnonymousThread(
    procedure
    begin
      MyRun;
    end);
  myThread.FreeOnTerminate := true;
  myThread.Start;
  SaveLog('线程启动：' + DateTimeToUnix(Now).Tostring);
end;

procedure TMyWinService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  SaveLog('Stop:' + ' ----- ' + formatdatetime('dd-hh:nn:ss', now));
  IsStop := true;
  myThread.Terminate;
  SaveLog('线程停止：' + DateTimeToUnix(Now).Tostring);
end;

end.

