object Tables: TTables
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 500
  Width = 567
  object FDConnection: TFDConnection
    Params.Strings = (
      'Protocol='
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 24
    Top = 8
  end
end
