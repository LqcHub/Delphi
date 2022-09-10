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
  Url: string; //�����ַ
  ResponseStream: TStringStream; //������Ϣ
  ResponseStr: string;
begin
  //����IDHTTP�ؼ�
  IdHttp := TIdHTTP.Create(nil);
  //TStringStream�������ڱ�����Ӧ��Ϣ
  ResponseStream := TStringStream.Create('');
  try
    //�����ַ
    Url := txtedtURL.Text + '?uname=' + HttpEncode(AnsiToUtf8('����')) + '&upwd=123456';
    IdHttp.Get(Url);

    try
      IdHttp.Get(Url, ResponseStream);
    except
      on e: Exception do
      begin
        ShowMessage(e.Message);
      end;
    end;
    //��ȡ��ҳ���ص���Ϣ
    ResponseStr := ResponseStream.DataString;
    //��ҳ�еĴ�������ʱ����Ҫ����UTF8����
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
  Url: string; //�����ַ
  ResponseStream: TStringStream; //������Ϣ
  ResponseStr: string;
  RequestList: TStringList;     //������Ϣ
  RequestStream: TStringStream;
begin
  //����IDHTTP�ؼ�
  IdHttp := TIdHTTP.Create(nil);
  //TStringStream�������ڱ�����Ӧ��Ϣ
  ResponseStream := TStringStream.Create('');
  RequestStream := TStringStream.Create('');
  RequestList := TStringList.Create;
  try
    Url := txtedtURL.Text;
    try
      //���б�ķ�ʽ�ύ����
      RequestList.Add('uname=����');
      RequestList.Add('upwd=654321');
      IdHttp.Request.ContentType := 'application/x-www-form-urlencoded; Charset=UTF-8';
      IdHttp.Post(Url, RequestList, ResponseStream);

      //�����ķ�ʽ�ύ����
//      RequestStream.WriteString('uname=����');
//      IdHttp.Post(Url, RequestStream, ResponseStream);
    except
      on e: Exception do
      begin
        ShowMessage(e.Message);
      end;
    end;
    //��ȡ��ҳ���ص���Ϣ
    ResponseStr := ResponseStream.DataString;
    //��ҳ�еĴ�������ʱ����Ҫ����UTF8����
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

