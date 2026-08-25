unit uTables;

interface
{ TYPES OF USER
   SUPORT   - S
   ADM      - A
   USER     - U
   GUEST    - G }

{ TYPES OF ENTITY
   CUSTOMER  - C
   SUPPLIER  - S
   SELLER    - E }

{ TYPES OF SALES
   RETAIL    - R
   WHOLESALE - W
   INTERNAL  - I

   NATURE OP
   PRODUCTSALE   - PS
   QUOTE         - Q
   RETURN        - R
   COMPLIMENTARY - C

   CATEGORY SALE
   IN-STORE     - S
   DELIREVY     - D
   ONLINEORDER  - OD
   OUTSIDESALES - OS}
uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Forms, Vcl.Buttons, System.IniFiles;

type
  TTables = class(TDataModule)
    FDConnection: TFDConnection;
    procedure CheckUser(query: TFDQuery; const user, sPassword: String);
    procedure EnableButtons(query: TFDQuery; AForm: TCustomForm);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    sUser: String;
    sTypeUser: String;
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

procedure TTables.DataModuleCreate(Sender: TObject);
var vIni: TIniFile;
begin
  vIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
  try
    FDConnection.Params.Clear;
    FDConnection.Params.Add('DriverID=FB');
    FDConnection.Params.Add('Database=' + vIni.ReadString('Database', 'Path', ''));
    FDConnection.Params.Add('User_name=' + vIni.ReadString('Database', 'User', ''));
    FDConnection.Params.Add('Password=' + vIni.ReadString('Database', 'Password', ''));
    FDConnection.Connected := True;
  finally
    vIni.Free;
  end;
end;

procedure TTables.EnableButtons(query: TFDQuery; AForm: TCustomForm);
var sbNew, sbDelete, sbLeft, sbRight, sbFirst, sbLast, sbRecord, sbCancel: TSpeedButton;
    bEdit: Boolean;
begin
  bEdit := false;
  if not query.Active then exit;
  if not Assigned(AForm) then exit;

   sbNew    := AForm.FindComponent('sbNew')    as TSpeedButton;
   sbDelete := AForm.FindComponent('sbDelete') as TSpeedButton;
   sbLeft   := AForm.FindComponent('sbLeft')   as TSpeedButton;
   sbRight  := AForm.FindComponent('sbRight')  as TSpeedButton;
   sbFirst  := AForm.FindComponent('sbFirst')  as TSpeedButton;
   sbLast   := AForm.FindComponent('sbLast')   as TSpeedButton;
   sbRecord := AForm.FindComponent('sbRecord') as TSpeedButton;
   sbCancel := AForm.FindComponent('sbCancel') as TSpeedButton;

  if sTypeUser <> 'G' then
  begin
   bEdit := query.State in [dsEdit,dsInsert];

    if Assigned(sbNew)    then sbNew.Enabled    := not bEdit;
    if Assigned(sbDelete) then sbDelete.Enabled := sbNew.Enabled;
    if Assigned(sbLeft)   then sbLeft.Enabled   := sbNew.Enabled;
    if Assigned(sbRight)  then sbRight.Enabled  := sbNew.Enabled;
    if Assigned(sbFirst)  then sbFirst.Enabled  := sbNew.Enabled;
    if Assigned(sbLast)   then sbLast.Enabled   := sbNew.Enabled;

    if Assigned(sbRecord) then sbRecord.Enabled  := bEdit;
    if Assigned(sbCancel) then sbCancel.Enabled  := sbRecord.Enabled ;
  end else begin
    if Assigned(sbNew)    then sbNew.Enabled     := False;
    if Assigned(sbDelete) then sbDelete.Enabled  := False;
    if Assigned(sbRecord) then sbRecord.Enabled  := False;
    if Assigned(sbCancel) then sbCancel.Enabled  := False;
  end;
end;

end.
