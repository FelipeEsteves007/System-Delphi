object fmUser: TfmUser
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 170
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 425
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = -4
    object Label1: TLabel
      Left = 57
      Top = 3
      Width = 31
      Height = 15
      Caption = 'USER'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 246
      Top = 3
      Width = 68
      Height = 15
      Caption = 'PASSWORD'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 5
      Top = 3
      Width = 32
      Height = 16
      Caption = 'CODE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbeCODE: TDBEdit
      Left = 5
      Top = 22
      Width = 46
      Height = 21
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'ID'
      DataSource = dsUser
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object dbePASS: TDBEdit
      Left = 246
      Top = 22
      Width = 169
      Height = 21
      CharCase = ecUpperCase
      DataField = 'PASSWORD'
      DataSource = dsUser
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 1
    end
    object dbeUSER: TDBEdit
      Left = 57
      Top = 22
      Width = 183
      Height = 21
      CharCase = ecUpperCase
      DataField = 'USER_NAME'
      DataSource = dsUser
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object pnRodape: TPanel
    Left = 0
    Top = 128
    Width = 425
    Height = 42
    Align = alBottom
    BevelWidth = 2
    Color = clGradientInactiveCaption
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 280
    ExplicitWidth = 545
    object sbNew: TSpeedButton
      AlignWithMargins = True
      Left = 7
      Top = 2
      Width = 63
      Height = 38
      Hint = 'New user'
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = '&New'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbNewClick
    end
    object sbRecord: TSpeedButton
      AlignWithMargins = True
      Left = 75
      Top = 2
      Width = 63
      Height = 38
      Hint = 'Salve user'
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = '&Record'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbRecordClick
    end
    object sbCancel: TSpeedButton
      AlignWithMargins = True
      Left = 143
      Top = 2
      Width = 63
      Height = 38
      Hint = 'Cancel edit'
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = '&Cancel'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbCancelClick
      ExplicitTop = 3
    end
    object sbDelete: TSpeedButton
      AlignWithMargins = True
      Left = 211
      Top = 2
      Width = 63
      Height = 38
      Hint = 'Delete user'
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = '&Delete'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbDeleteClick
    end
    object sbLeft: TSpeedButton
      AlignWithMargins = True
      Left = 277
      Top = 2
      Width = 36
      Height = 38
      Hint = 'Prior'
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = '<-'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbLeftClick
      ExplicitLeft = 438
      ExplicitTop = 1
    end
    object sbClose: TSpeedButton
      AlignWithMargins = True
      Left = 352
      Top = 2
      Width = 63
      Height = 38
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Align = alRight
      Caption = '&Close'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = sbCloseClick
      ExplicitLeft = 346
    end
    object sbRight: TSpeedButton
      AlignWithMargins = True
      Left = 316
      Top = 2
      Width = 36
      Height = 38
      Hint = 'Next'
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = '->'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbRightClick
      ExplicitLeft = 438
      ExplicitTop = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 425
    Height = 79
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitLeft = -4
    ExplicitHeight = 36
  end
  object DBRadioGroup1: TDBRadioGroup
    Left = 11
    Top = 49
    Width = 404
    Height = 78
    Caption = 'USERS'
    DataField = 'USER_TYPE'
    DataSource = dsUser
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Items.Strings = (
      'ADM'
      'USER'
      'GUEST')
    ParentFont = False
    TabOrder = 3
    Values.Strings = (
      'A'
      'U'
      'G')
  end
  object qUSer: TFDQuery
    Active = True
    Connection = Tables.FDConnection
    SQL.Strings = (
      'SELECT ID,'
      '       USER_NAME,'
      '       PASSWORD,'
      '       USER_TYPE'
      'FROM USERS')
    Left = 359
    Top = 72
    object qUSerID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
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
  object dsUser: TDataSource
    DataSet = qUSer
    OnStateChange = dsUserStateChange
    Left = 320
    Top = 49
  end
end
