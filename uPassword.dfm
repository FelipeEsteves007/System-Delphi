object fmPassword: TfmPassword
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  ClientHeight = 154
  ClientWidth = 243
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnFundo: TPanel
    Left = 0
    Top = 0
    Width = 243
    Height = 154
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -64
    Font.Name = 'Arial Narrow'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object PassWord: TLabel
      Left = 22
      Top = 64
      Width = 196
      Height = 19
      Caption = 'Administrator Password'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object sbOk: TSpeedButton
      Left = 63
      Top = 116
      Width = 57
      Height = 22
      Cursor = crHandPoint
      Caption = '&Ok'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = sbOkClick
    end
    object sbClose: TSpeedButton
      Left = 126
      Top = 116
      Width = 57
      Height = 22
      Cursor = crHandPoint
      Caption = '&Close'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = sbCloseClick
    end
    object Label1: TLabel
      Left = 46
      Top = 6
      Width = 155
      Height = 19
      Caption = 'Administrator User'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edPassword: TEdit
      Left = 22
      Top = 89
      Width = 196
      Height = 21
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      MaxLength = 15
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 0
    end
    object edUser: TEdit
      Left = 22
      Top = 31
      Width = 196
      Height = 21
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      MaxLength = 15
      ParentFont = False
      TabOrder = 1
    end
  end
  object qUSer: TFDQuery
    Connection = Tables.FDConnection
    SQL.Strings = (
      'SELECT ID,'
      '       USER_NAME,'
      '       PASSWORD,'
      '       USER_TYPE'
      'FROM USERS')
    Left = 127
    Top = 40
    object qUSerID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qUSerUSER_NAME: TStringField
      FieldName = 'USER_NAME'
      Origin = 'USER_NAME'
      Required = True
      Size = 100
    end
    object qUSerPASSWORD: TStringField
      FieldName = 'PASSWORD'
      Origin = '"PASSWORD"'
      Required = True
      Size = 100
    end
    object qUSerUSER_TYPE: TStringField
      FieldName = 'USER_TYPE'
      Origin = 'USER_TYPE'
      Required = True
      Size = 10
    end
  end
end
