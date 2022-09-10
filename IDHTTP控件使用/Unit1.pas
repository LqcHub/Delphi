unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  IdBaseComponent, IdComponent, IdHTTP, IdTCPConnection, IdTCPClient,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore,
  Vcl.StdCtrls, cxButtons, cxControls, cxContainer, cxEdit, cxTextEdit, IdURI,
  Httpapp;

type
  TForm1 = class(TForm)
    btnPost: TcxButton;
    btnGet: TcxButton;
    txtedtURL: TcxTextEdit;
    procedure btnPostClick(Sender: TObject);
    procedure btnGetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.btnGetClick(Sender: TObject);
var
  IdHttp: TIdHTTP;
  Url: string; //请求地址
  ResponseStream: TStringStream; //返回信息
  ResponseStr: string;
begin
  //创建IDHTTP控件
  IdHttp := TIdHTTP.Create(nil);
  //TStringStream对象用于保存响应信息
  ResponseStream := TStringStream.Create('');
  try
    //请求地址
    Url := txtedtURL.Text + '?uname=' + HttpEncode(AnsiToUtf8('李四')) + '&upwd=123456';
    IdHttp.Get(Url);

    try
      IdHttp.Get(Url, ResponseStream);
    except
      on e: Exception do
      begin
        ShowMessage(e.Message);
      end;
    end;
    //获取网页返回的信息
    ResponseStr := ResponseStream.DataString;
    //网页中的存在中文时，需要进行UTF8解码
    ResponseStr := UTF8Decode(ResponseStr);
    ShowMessage(ResponseStr);
  finally
    IdHttp.Free;
    ResponseStream.Free;
  end;
end;

procedure TForm1.btnPostClick(Sender: TObject);
var
  IdHttp: TIdHTTP;
  Url: string; //请求地址
  ResponseStream: TStringStream; //返回信息
  ResponseStr: string;
  RequestList: TStringList;     //请求信息
  RequestStream: TStringStream;
begin
  //创建IDHTTP控件
  IdHttp := TIdHTTP.Create(nil);
  //TStringStream对象用于保存响应信息
  ResponseStream := TStringStream.Create('');
  RequestStream := TStringStream.Create('');
  RequestList := TStringList.Create;
  try
    Url := txtedtURL.Text;
    try
      //以列表的方式提交参数
      RequestList.Add('uname=张三');
      RequestList.Add('upwd=654321');
      IdHttp.Request.ContentType := 'application/x-www-form-urlencoded; Charset=UTF-8';
      IdHttp.Post(Url, RequestList, ResponseStream);

      //以流的方式提交参数
//      RequestStream.WriteString('uname=张三');
//      IdHttp.Post(Url, RequestStream, ResponseStream);
    except
      on e: Exception do
      begin
        ShowMessage(e.Message);
      end;
    end;
    //获取网页返回的信息
    ResponseStr := ResponseStream.DataString;
    //网页中的存在中文时，需要进行UTF8解码
    ResponseStr := UTF8Decode(ResponseStr);
    ShowMessage(ResponseStr);
  finally
    IdHttp.Free;
    RequestList.Free;
    RequestStream.Free;
    ResponseStream.Free;
  end;
end;

end.

