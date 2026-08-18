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
    procedure FormShow(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
    procedure sbOkClick(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
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
  if (sTitle <> '')  then lbSearch.Caption := sTitle;
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

procedure TfmSearch.sbOkClick(Sender: TObject);
begin
  if (qSearch.IsEmpty) then
  begin
    ShowMessage('Please select an item');
    exit;
  end;
  ModalResult := mrOk;
end;

end.
