unit uSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls;

type
  TfmSearch = class(TForm)
    pnRodape: TPanel;
    sbClose: TSpeedButton;
    sbNew: TSpeedButton;
    sbDelete: TSpeedButton;
    sbOk: TSpeedButton;
    pnClient: TPanel;
    pnTop: TPanel;
    Grid: TDBGrid;
    qSearch: TFDQuery;
    dsSearch: TDataSource;
    edSearch: TEdit;
    lbSearch: TLabel;
    pnInsert: TPanel;
    Panel1: TPanel;
    sbOkIn: TSpeedButton;
    sbCloseIn: TSpeedButton;
    edInsert: TEdit;
    lbInsert: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
    procedure sbOkClick(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure sbCloseInClick(Sender: TObject);
    procedure sbOkInClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSearch: TfmSearch;
  sSearch, sTitle: String;


implementation

{$R *.dfm}

uses uTables;

procedure TfmSearch.edSearchChange(Sender: TObject);
begin
  if (Trim(sSearch) <> '') then
  begin
    qSearch.Filter := 'UPPER(NAME) LIKE UPPER(' + QuotedStr('%' + edSearch.Text + '%') + ')';
    qSearch.Filtered := True;
  end else qSearch.Filtered := False;
end;

procedure TfmSearch.FormShow(Sender: TObject);
begin
  pnInsert.Visible := false;
  if (sTitle <> '')  then lbSearch.Caption := 'SEARCH ' + sTitle;
  if (sSearch <> '') then
  begin
    qSearch.Close;
    qSearch.SQL.Text := sSearch;
    qSearch.Open;
  end;
end;

procedure TfmSearch.GridDblClick(Sender: TObject);
begin
  sbOkClick(Sender);
end;

procedure TfmSearch.sbCloseClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfmSearch.sbCloseInClick(Sender: TObject);
begin
  pnInsert.Visible := false;
end;

procedure TfmSearch.sbDeleteClick(Sender: TObject);
begin
  if qSearch.IsEmpty then
  begin
    ShowMessage('There is no item to delete');
    Exit;
  end;

  if MessageDlg('Do you really want to delete this product?', mtConfirmation,[mbNo,mbYes], 0) = mrYes then
  begin
    qSearch.Delete;
  end;
end;

procedure TfmSearch.sbNewClick(Sender: TObject);
begin
  pnInsert.Visible := True;
  lbInsert.Caption := 'INSERT IN ' + sTitle;
  if sTitle = 'CATEGORY' then lbInsert.Left := 43;
  if sTitle = 'BRAND' then lbInsert.Left := 58;
  if sTitle = 'SUPPLIER' then lbInsert.Left := 48;
end;

procedure TfmSearch.sbOkClick(Sender: TObject);
begin
  if (qSearch.IsEmpty) then
  begin
    ShowMessage('Please select an item');
    exit;
  end;
  ModalResult := mrOk;
end;

procedure TfmSearch.sbOkInClick(Sender: TObject);
begin
  if (Trim(edInsert.Text) = '') then
  begin
    ShowMessage('This field cant be empty');
    Exit;
  end;

  try
    if (sTitle = 'CATEGORY') then
    begin
      qSearch.Connection.ExecSQL('INSERT INTO CATEGORY (NAME) VALUES (:P)',[Trim(edInsert.Text)]);
    end else if (sTitle = 'BRAND') then
    begin
      qSearch.Connection.ExecSQL('INSERT INTO BRAND (NAME) VALUES (:P)',[Trim(edInsert.Text)]);
    end else qSearch.Connection.ExecSQL('INSERT INTO ENTITY (NAME, ROLE_TYPE, ACTIVE) VALUES (:P, ''S'', ''Y'')',[Trim(edInsert.Text)]);
    qSearch.Close;
    qSearch.Open;

    edInsert.Clear;
    pnInsert.Visible := False;
  except
    on E: Exception do
     ShowMessage('Error inserting record: ' + E.Message);
  end;
end;
end.
