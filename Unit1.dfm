object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 416
  ClientWidth = 708
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 449
    Height = 79
    Lines.Strings = (
      'Rua Marechal Floriano, 654, Centro, Governador Valadares, MG')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 488
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo2: TMemo
    Left = 8
    Top = 93
    Width = 449
    Height = 276
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
