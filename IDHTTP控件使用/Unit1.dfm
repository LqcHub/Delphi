object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 351
  ClientWidth = 573
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnPost: TcxButton
    Left = 184
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Post'
    TabOrder = 2
    OnClick = btnPostClick
  end
  object btnGet: TcxButton
    Left = 48
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Get'
    TabOrder = 1
    OnClick = btnGetClick
  end
  object txtedtURL: TcxTextEdit
    Left = 0
    Top = 0
    Align = alTop
    AutoSize = False
    TabOrder = 0
    TextHint = 'URL'
    ExplicitWidth = 688
    Height = 41
    Width = 573
  end
end
