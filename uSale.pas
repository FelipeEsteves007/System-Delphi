unit uSale;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  Vcl.ComCtrls;

type
  TfmSale = class(TForm)
    pnTop: TPanel;
    pnBottom: TPanel;
    pnClient: TPanel;
    qSales: TFDQuery;
    dsSales: TDataSource;
    qSalesID: TIntegerField;
    qSalesCUSTOMER_ID: TIntegerField;
    qSalesSALE_DATE: TSQLTimeStampField;
    qSalesSUBTOTAL: TFMTBCDField;
    qSalesDISCOUNT: TFMTBCDField;
    qSalesTOTAL: TFMTBCDField;
    qItem: TFDQuery;
    dsItem: TDataSource;
    qItemID: TIntegerField;
    qItemSALE_ID: TIntegerField;
    qItemPRODUCT_ID: TIntegerField;
    qItemQUANTITY: TFMTBCDField;
    qItemUNIT_PRICE: TFMTBCDField;
    qItemTOTAL_PRICE: TFMTBCDField;
    dbeCode: TDBEdit;
    lcCode: TLabel;
    pnRodape: TPanel;
    dbGridItems: TDBGrid;
    sbNew: TSpeedButton;
    sbRecord: TSpeedButton;
    sbCancel: TSpeedButton;
    sbDelete: TSpeedButton;
    sbClose: TSpeedButton;
    Panel1: TPanel;
    Label4: TLabel;
    lbCustomer: TLabel;
    sbSearchC: TSpeedButton;
    lbSeller: TLabel;
    sbSearchS: TSpeedButton;
    dt: TDateTimePicker;
    lbSaleType: TLabel;
    lbNature: TLabel;
    lbCategory: TLabel;
    cbNature: TComboBox;
    cbCategory: TComboBox;
    pnTotais: TPanel;
    lbDiscount: TLabel;
    lbViDiscount: TLabel;
    dbtTOTAL: TDBText;
    dbGridInfo: TDBGrid;
    lbSubTotal: TLabel;
    lbSub: TLabel;
    edCustomer: TEdit;
    edSeller: TEdit;
    cbSaleType: TComboBox;
    qSalesSALE_TYPE: TStringField;
    qSalesNATURE_OP: TStringField;
    qSalesCATEGORY_SALE: TStringField;
    edDiscount: TEdit;
    edViDiscount: TEdit;
    procedure sbCloseClick(Sender: TObject);
    procedure goSearch(Sender: TObject; sSQL, sNameT: String; ed: TEdit; var id: Integer);
    procedure sbSearchCClick(Sender: TObject);
    procedure sbSearchSClick(Sender: TObject);
    procedure dtChange(Sender: TObject);
  private

    idCustomer, idSeller: Integer;
  public
  end;

var
  fmSale: TfmSale;

implementation

{$R *.dfm}

uses uTables, uSearch, uUseful;

procedure TfmSale.dtChange(Sender: TObject);
begin
  if (dt.Date > Date) then
  begin
    ShowMessage('The registration date cannot be in the future!');   
    dt.Date := Date;
  end;
  inStateEdit(qSales);
end;

procedure TfmSale.goSearch(Sender: TObject; sSQL, sNameT: String; ed: TEdit; var id: Integer);
var fSearch: TfmSearch;
begin
  fSearch := TfmSearch.Create(Self);
  try
    sSearch := sSQL;
    sTitle  := sNameT;
    if fSearch.ShowModal = mrOk then
    begin
      inStateEdit(qSales);
      id := fSearch.qSearch.Fields[0].AsInteger;
      ed.Text := fSearch.qSearch.Fields[1].AsString;   
    end;
  finally
    FreeAndNil(fSearch);
  end;
end;

procedure TfmSale.sbCloseClick(Sender: TObject);
begin
 Close;
end;

procedure TfmSale.sbSearchCClick(Sender: TObject);
begin
  goSearch(Self,'SELECT ID, NAME FROM ENTITY WHERE ROLE_TYPE = ''C''', 'CUSTOMER' ,edCustomer, idCustomer);
end;

procedure TfmSale.sbSearchSClick(Sender: TObject);
begin
  goSearch(Self,'SELECT ID, NAME FROM ENTITY WHERE ROLE_TYPE = ''E''', 'SELLER' ,edSeller, idSeller);
end;

end.
