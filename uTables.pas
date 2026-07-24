unit uTables;

interface
{ TYPES OF USER
   SUPORT   - S
   ADM      - A
   USER     - U
   GUEST    - G }

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TTables = class(TDataModule)
    FDConnection: TFDConnection;
    procedure CheckUser(query: TFDQuery; const user, sPassword: String);
  private
    { Private declarations }
  public
    sUser: String;
  end;

var
  Tables: TTables;

implementation

{$R *.dfm}

{ TTables }

procedure TTables.CheckUser(query: TFDQuery; const user, sPassword: String);
begin
  query.Close;
  query.SQL.Clear;
  with query.SQL do
  begin
    Add(' SELECT ID, ' +
        '        USER_NAME, ' +
        '        PASSWORD, ' +
        '        USER_TYPE ' +
        ' FROM USERS ' +
        ' WHERE USER_NAME = :USER ' +
        ' AND PASSWORD = :PASS ');
  end;
  query.ParamByName('USER').AsString := user;
  query.ParamByName('PASS').AsString := sPassword;
  query.Open;
end;

end.
