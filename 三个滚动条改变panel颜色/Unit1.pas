unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    scrlbr1: TScrollBar;
    scrlbr2: TScrollBar;
    scrlbr3: TScrollBar;
    procedure scrlbr1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.scrlbr1Change(Sender: TObject);
begin
  Panel1.Color := Tcolor(RGB(scrlbr1.Position, scrlbr2.Position, scrlbr3.Position));
end;

end.

