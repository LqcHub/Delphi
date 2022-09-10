object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 420
  ClientWidth = 745
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object gdpnl1: TRzGridPanel
    Left = 0
    Top = 0
    Width = 745
    Height = 150
    BorderOuter = fsNone
    Align = alTop
    ColumnCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 80.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 80.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 80.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 80.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 80.000000000000000000
      end
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = btnStart1
        Row = 0
      end
      item
        Column = 5
        Control = edt1
        Row = 0
      end
      item
        Column = 0
        Control = btn11
        Row = 1
      end
      item
        Column = 5
        Control = edt2
        Row = 1
      end
      item
        Column = 1
        Control = btnFree1
        Row = 0
      end
      item
        Column = 2
        Control = btnStop1
        Row = 0
      end
      item
        Column = 3
        Control = btnGo1
        Row = 0
      end
      item
        Column = 1
        Control = btn122
        Row = 1
      end
      item
        Column = 2
        Control = btn132
        Row = 1
      end
      item
        Column = 3
        Control = btn1311
        Row = 1
      end>
    RowCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 50.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 50.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 50.000000000000000000
      end>
    TabOrder = 0
    object btnStart1: TcxButton
      Left = 0
      Top = 0
      Width = 80
      Height = 50
      Align = alClient
      Caption = #21551#21160#32447#31243'1'
      TabOrder = 0
      OnClick = btnStart1Click
      ExplicitLeft = -6
      ExplicitTop = -6
    end
    object edt1: TEdit
      Left = 400
      Top = 0
      Width = 345
      Height = 50
      Align = alClient
      TabOrder = 1
      TextHint = 'edt1'
      ExplicitLeft = 106
      ExplicitWidth = 645
    end
    object btn11: TcxButton
      Left = 0
      Top = 50
      Width = 80
      Height = 50
      Align = alClient
      Caption = #21551#21160#32447#31243'2'
      TabOrder = 2
      ExplicitLeft = 86
      ExplicitTop = 12
      ExplicitWidth = 75
      ExplicitHeight = 25
    end
    object edt2: TEdit
      Left = 400
      Top = 50
      Width = 345
      Height = 50
      Align = alClient
      TabOrder = 3
      TextHint = 'edt2'
      ExplicitLeft = 314
      ExplicitTop = 56
      ExplicitWidth = 80
    end
    object btnFree1: TcxButton
      Left = 80
      Top = 0
      Width = 80
      Height = 50
      Align = alClient
      Caption = #20572#27490#32447#31243'1'
      TabOrder = 4
      OnClick = btnFree1Click
      ExplicitLeft = 86
      ExplicitTop = -6
    end
    object btnStop1: TcxButton
      Left = 160
      Top = 0
      Width = 80
      Height = 50
      Align = alClient
      Caption = #26242#20572#32447#31243'1'
      TabOrder = 5
      OnClick = btnStop1Click
      ExplicitLeft = 154
      ExplicitTop = -6
    end
    object btnGo1: TcxButton
      Left = 240
      Top = 0
      Width = 80
      Height = 50
      Align = alClient
      Caption = #32487#32493#32447#31243'1'
      TabOrder = 6
      OnClick = btnGo1Click
      ExplicitLeft = 246
      ExplicitTop = -6
    end
    object btn122: TcxButton
      Left = 80
      Top = 50
      Width = 80
      Height = 50
      Align = alClient
      Caption = #20572#27490#32447#31243'2'
      TabOrder = 7
      OnClick = btnStart1Click
      ExplicitLeft = 86
      ExplicitTop = -6
      ExplicitWidth = 75
      ExplicitHeight = 25
    end
    object btn132: TcxButton
      Left = 160
      Top = 50
      Width = 80
      Height = 50
      Align = alClient
      Caption = #26242#20572#32447#31243'2'
      TabOrder = 8
      OnClick = btnStop1Click
      ExplicitLeft = 166
      ExplicitTop = 56
    end
    object btn1311: TcxButton
      Left = 240
      Top = 50
      Width = 80
      Height = 50
      Align = alClient
      Caption = #32487#32493#32447#31243'2'
      TabOrder = 9
      OnClick = btnStart1Click
      ExplicitLeft = 234
      ExplicitTop = -6
      ExplicitWidth = 75
      ExplicitHeight = 25
    end
  end
end
