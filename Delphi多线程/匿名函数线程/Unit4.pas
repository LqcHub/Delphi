unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, RzPanel;

type
  TForm4 = class(TForm)
    gdpnl1: TRzGridPanel;
    btnStart1: TcxButton;
    edt1: TEdit;
    btn11: TcxButton;
    edt2: TEdit;
    btnFree1: TcxButton;
    btnStop1: TcxButton;
    btnGo1: TcxButton;
    btn122: TcxButton;
    btn132: TcxButton;
    btn1311: TcxButton;
    procedure btnStart1Click(Sender: TObject);
    procedure btnStop1Click(Sender: TObject);
    procedure btnGo1Click(Sender: TObject);
    procedure btnFree1Click(Sender: TObject);
  private
    IsExit: boolean;
    myThread1, myThread2: TThread;
    { Private declarations }
    procedure MyRun1;
    procedure MyRun2;
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.btnFree1Click(Sender: TObject);
begin
  if Sender.Equals(btnFree1) then
  begin
    IsExit := true;
    myThread1.Terminate;
  end
  else
  begin
    myThread2.Terminate;    // 添加这句才是线程终止，下面的是线程终止的时候释放
    myThread2.FreeOnTerminate := True;
  end;
end;

procedure TForm4.btnGo1Click(Sender: TObject);
begin
  if Sender.Equals(btngo1) then
    myThread1.Suspended := false
  else
    myThread2.Suspended := false
end;

procedure TForm4.btnStop1Click(Sender: TObject);
begin
  if Sender.Equals(btnstop1) then
    myThread1.Suspended := True
  else
    myThread2.Suspended := True
end;

procedure TForm4.btnStart1Click(Sender: TObject);
begin
//创建线程
  if Sender.Equals(btnStart1) then
  begin
    myThread1 := TThread.CreateAnonymousThread(
      procedure
      begin
        MyRun1;
      end);
    myThread1.FreeOnTerminate := true;
    myThread1.Start;
  end
  else
  begin
    myThread2 := TThread.CreateAnonymousThread(
      procedure
      begin
        MyRun2;
      end);
    myThread2.Start;
  end;
end;

procedure TForm4.MyRun1;
begin
  while IsExit = false do
    edt1.Text := DateTimeToStr(Now);
end;

procedure TForm4.MyRun2;
begin
  while IsExit = false do
    edt2.Text := DateTimeToStr(Now);
end;

end.

