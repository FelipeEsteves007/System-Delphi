object Tables: TTables
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 500
  Width = 567
  object FDConnection: TFDConnection
    Params.Strings = (
      'Protocol=TCPIP'
      'User_Name=SYSDBA'
      'Password=pfglessa'
      'Database=C:\system\data\FF_V5.FDB'
      'Server=127.0.0.1'
      'Port=3080'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 8
  end
end
