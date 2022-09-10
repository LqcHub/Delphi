object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 302
  ClientWidth = 679
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 465
    Height = 302
    ActivePage = ts3
    Align = alLeft
    DockSite = True
    DragCursor = crMultiDrag
    DragKind = dkDock
    TabOrder = 0
    object ts1: TTabSheet
      Caption = 'ts1'
      ExplicitWidth = 497
      ExplicitHeight = 203
    end
    object ts2: TTabSheet
      Caption = 'ts2'
      ImageIndex = 1
      ExplicitWidth = 497
      ExplicitHeight = 203
    end
    object ts3: TTabSheet
      Caption = 'ts3'
      ImageIndex = 2
      ExplicitLeft = 8
      ExplicitTop = 28
    end
  end
  object cxButton1: TcxButton
    Left = 584
    Top = 136
    Width = 75
    Height = 25
    Caption = 'cxButton1'
    TabOrder = 1
    OnClick = cxButton1Click
  end
end
