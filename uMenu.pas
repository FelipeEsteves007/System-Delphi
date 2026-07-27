unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.Buttons, System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfmMenu = class(TForm)
    pnBase: TPanel;
    pnBottom: TPanel;
    pnClient: TPanel;
    pnTop: TPanel;
    pnButton: TPanel;
    sbClose: TSpeedButton;
    sCustomer: TSpeedButton;
    sbSale: TSpeedButton;
    sbReport: TSpeedButton;
    sbFin: TSpeedButton;
    sbSet: TSpeedButton;
    sbProducts: TSpeedButton;
    sbStock: TSpeedButton;
    qUSer: TFDQuery;
    qUSerID: TIntegerField;
    qUSerUSER_NAME: TStringField;
    qUSerPASSWORD: TStringField;
    qUSerUSER_TYPE: TStringField;
    lbTitleUse: TLabel;
    lbUSer: TLabel;
    lbPositonTitle: TLabel;
    lbPositon: TLabel;
    procedure sbCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sCustomerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMenu: TfmMenu;

implementation

{$R *.dfm}

uses uTables, uLogin, uCustomer;

procedure TfmMenu.FormShow(Sender: TObject);
var sPassword: String;
begin
  lbUSer.Caption := fmLogin.edUser.Text;
  sPassword := fmLogin.edPassword.Text;

  Tables.CheckUser(qUser,fmLogin.edUser.Text,sPassword);

  if not qUSer.IsEmpty then
  begin
    if qUSerUSER_TYPE.AsString = 'A' then lbPositon.Caption := 'ADM'
    else if qUSerUSER_TYPE.AsString = 'G' then lbPositon.Caption := 'GUEST'
    else if qUSerUSER_TYPE.AsString = 'S' then lbPositon.Caption := 'SUPORT'
    else lbPositon.Caption := 'USER'
  end;

  if qUSerUSER_TYPE.AsString = 'U' then
  begin
    sbFin.Enabled := False;
  end;

  if qUSerUSER_TYPE.AsString = 'G' then
  begin
    sbFin.Enabled := False;
    sbSale.Enabled := False;
    sbStock.Enabled := False;
  end;

end;

procedure TfmMenu.sbCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfmMenu.sCustomerClick(Sender: TObject);
begin
  Application.CreateForm(TfmCustomer,fmCustomer);
  try
    fmCustomer.ShowModal;
  finally
    FreeAndNil(fmCustomer);
  end;
end;

end.
