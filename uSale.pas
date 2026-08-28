unit uSale;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.UITypes,
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
    dsItem: TDataSource;
    dbeCode: TDBEdit;
    lcCode: TLabel;
    pnRodape: TPanel;
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
    dbGridInfo: TDBGrid;
    lbSubTotal: TLabel;
    edCustomer: TEdit;
    edSeller: TEdit;
    cbSaleType: TComboBox;
    qSalesSALE_TYPE: TStringField;
    qSalesNATURE_OP: TStringField;
    qSalesCATEGORY_SALE: TStringField;
    edDiscount: TEdit;
    edViDiscount: TEdit;
    qProduct: TFDQuery;
    qProductID: TIntegerField;
    qProductNAME: TStringField;
    qProductBARCODE: TStringField;
    qProductREFERENCE: TStringField;
    qProductUNIT_MEASURE: TStringField;
    qProductCOST_PRICE: TFMTBCDField;
    qProductSALE_PRICE: TFMTBCDField;
    qProductLOCATION: TStringField;
    qProductKIT: TStringField;
    qProductACTIVE: TStringField;
    qProductREGISTRATION_DATE: TDateField;
    qProductCATEGORY_ID: TIntegerField;
    qProductBRAND_ID: TIntegerField;
    qProductQUANTITY: TFMTBCDField;
    qProductMIN_STOCK: TFMTBCDField;
    qProductSUPPLIER_ID: TIntegerField;
    qProductSUPPLIER: TStringField;
    qProductBRAND: TStringField;
    qProductCATEGORY: TStringField;
    dsProduct: TDataSource;
    lbDate: TLabel;
    qItem: TFDQuery;
    qItemID: TIntegerField;
    qItemSALE_ID: TIntegerField;
    qItemPRODUCT_ID: TIntegerField;
    qItemQUANTITY: TFMTBCDField;
    qItemUNIT_PRICE: TFMTBCDField;
    qItemTOTAL_PRICE: TFMTBCDField;
    dbGridItems: TDBGrid;
    qItemNAME_PRODUCT: TStringField;
    lbTotal: TLabel;
    pnTotal: TPanel;
    dbtTotal: TDBText;
    dbtSubtotal: TDBText;
    qSalesSELLER_ID: TIntegerField;
    stBar: TStatusBar;
    procedure sbCloseClick(Sender: TObject);
    procedure goSearch(Sender: TObject; sSQL, sNameT: String; ed: TEdit; var id: Integer);
    procedure sbSearchCClick(Sender: TObject);
    procedure sbSearchSClick(Sender: TObject);
    procedure dtChange(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbRecordClick(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    function ReadOnly(bRead: Boolean): Boolean;
    procedure qItemPRODUCT_IDChange(Sender: TField);
    procedure qItemQUANTITYChange(Sender: TField);
    procedure qItemAfterPost(DataSet: TDataSet);
    procedure qItemAfterDelete(DataSet: TDataSet);
    procedure qItemNewRecord(DataSet: TDataSet);
    procedure qSalesBeforePost(DataSet: TDataSet);
    procedure dbGridItemsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Enabled(Sender: TObject);
    procedure Total(Sender: TObject);
    procedure edDiscountExit(Sender: TObject);
  private
    idCustomer, idSeller: Integer;
    vSubTotal, vTotal, vPercent, vDiscount: Double;

  public
  end;

var
  fmSale: TfmSale;

implementation

{$R *.dfm}

uses uTables, uSearch, uUseful;

procedure TfmSale.dbGridItemsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) then
  begin
    qItem.Delete;
  end;
end;

procedure TfmSale.dtChange(Sender: TObject);
begin
  if (dt.Date > Date) then
  begin
    ShowMessage('The registration date cannot be in the future!');   
    dt.Date := Date;
  end;
  inStateEdit(qSales);
end;

procedure TfmSale.FormShow(Sender: TObject);
begin
  sbRecord.Enabled := False;
  sbCancel.Enabled := False;
  ReadOnly(False);
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

procedure TfmSale.qItemAfterDelete(DataSet: TDataSet);
begin
  Total(Self);
end;

procedure TfmSale.qItemAfterPost(DataSet: TDataSet);
begin
  Total(Self);
end;

procedure TfmSale.qItemNewRecord(DataSet: TDataSet);
begin
  qItemSALE_ID.AsInteger := qSalesID.AsInteger;
end;

procedure TfmSale.qItemPRODUCT_IDChange(Sender: TField);
begin
  if not (Sender.IsNull) then
  begin
    qProduct.Locate('ID', qItemPRODUCT_ID.AsInteger, []);
    qItemUNIT_PRICE.Value      := qProductSALE_PRICE.Value;
    qItemQUANTITY.AsFloat      := 1;
  end;
end;

procedure TfmSale.qItemQUANTITYChange(Sender: TField);
begin
  if not (Sender.IsNull) then
  begin
    qItemTOTAL_PRICE.AsFloat := qItemQUANTITY.AsFloat * qItemUNIT_PRICE.AsFloat;
  end;
end;

procedure TfmSale.qSalesBeforePost(DataSet: TDataSet);
begin
  if (cbNature.ItemIndex = 0) then qSalesNATURE_OP.AsString := 'PS'
    else if (cbNature.ItemIndex = 1) then qSalesNATURE_OP.AsString := 'Q'
    else if (cbNature.ItemIndex = 2) then qSalesNATURE_OP.AsString := 'R'
    else qSalesNATURE_OP.AsString := 'C';

  if (cbCategory.ItemIndex = 0) then qSalesCATEGORY_SALE.AsString := 'S'
    else if (cbCategory.ItemIndex = 1) then qSalesCATEGORY_SALE.AsString := 'D'
    else if (cbCategory.ItemIndex = 2) then qSalesCATEGORY_SALE.AsString := 'OD'
    else qSalesCATEGORY_SALE.AsString := 'OS';

  if (cbSaleType.ItemIndex = 0) then qSalesSALE_TYPE.AsString := 'R'
    else if (cbSaleType.ItemIndex = 1) then qSalesSALE_TYPE.AsString := 'W'
    else qSalesSALE_TYPE.AsString := 'I';

  if (Trim(edCustomer.Text) <> '') then qSalesCUSTOMER_ID.AsInteger := idCustomer;
  if (Trim(edSeller.Text) <> '')   then qSalesSELLER_ID.AsInteger   := idSeller;

  if (Trim(qItemTOTAL_PRICE.AsString) <> '') then qSalesSUBTOTAL.AsFloat := vSubTotal;

  qSalesSALE_DATE.AsDateTime := dt.Date;
end;

function TfmSale.ReadOnly(bRead: Boolean): Boolean;
begin
  if (bRead)then
  begin
    edCustomer.Enabled   := True;
    edDiscount.Enabled   := True;
    edViDiscount.Enabled := True;
    edSeller.Enabled     := True;
    sbSearchC.Enabled    := True;
    sbSearchS.Enabled    := True;
    dbGridItems.ReadOnly := False;
    dt.Enabled           := True;
    cbNature.Enabled     := True;
    cbCategory.Enabled   := True;
    cbSaleType.Enabled   := True;
  end else begin
    edCustomer.Enabled   := False;
    edDiscount.Enabled   := False;
    edViDiscount.Enabled := False;
    edSeller.Enabled     := False;
    sbSearchC.Enabled    := False;
    sbSearchS.Enabled    := False;
    dbGridItems.ReadOnly := True;
    dt.Enabled           := False;
    cbNature.Enabled     := False;
    cbCategory.Enabled   := False;
    cbSaleType.Enabled   := False;
  end;
  Result := bRead;
end;

procedure TfmSale.sbCancelClick(Sender: TObject);
begin
  qSales.Cancel;
  qItem.CancelUpdates;
  Enabled(sbNew);
  edCustomer.Clear;
  edSeller.Clear;
  cbNature.ItemIndex   := 1;
  cbCategory.ItemIndex := 1;
  cbSaleType.ItemIndex := 1;
  ReadOnly(False);
end;

procedure TfmSale.sbCloseClick(Sender: TObject);
begin
 Close;
end;

procedure TfmSale.sbDeleteClick(Sender: TObject);
begin
  if qSales.IsEmpty then
  begin
    ShowMessage('There is no sale to delete');
    Exit;
  end;

  if MessageDlg('Do you really want to delete this sale?', mtConfirmation,[mbNo,mbYes], 0) = mrYes then
  begin
    qSales.Delete;
  end;

  Enabled(sbNew);
end;

procedure TfmSale.sbNewClick(Sender: TObject);
begin
  qSales.Append;
  qItem.Append;
  Enabled(sbNew);
  ReadOnly(True);
end;

procedure TfmSale.sbRecordClick(Sender: TObject);
begin
  if Trim(edCustomer.Text) = '' then
  begin
    ShowMessage('The customer is empty!');
    edCustomer.SetFocus;
    Exit;
  end;

  if Trim(edSeller.Text) = '' then
  begin
    ShowMessage('The seller is empty!');
    edSeller.SetFocus;
    Exit;
  end;

  Enabled(sbNew);
  ReadOnly(False);

  if qSales.State in [dsEdit, dsInsert] then qSales.Post;
  if qItem.State in [dsEdit, dsInsert] then qItem.Post;

  if qItem.ChangeCount > 0 then
  begin
    qItem.ApplyUpdates(0);
    qItem.CommitUpdates;
  end;

  ShowMessage('The sales have been saved!');
end;

procedure TfmSale.sbSearchCClick(Sender: TObject);
begin
  goSearch(Self,'SELECT ID, NAME FROM ENTITY WHERE ROLE_TYPE = ''C''', 'CUSTOMER' ,edCustomer, idCustomer);
end;

procedure TfmSale.sbSearchSClick(Sender: TObject);
begin
  goSearch(Self,'SELECT ID, NAME FROM ENTITY WHERE ROLE_TYPE = ''E''', 'SELLER' ,edSeller, idSeller);
end;

procedure TfmSale.Enabled(Sender: TObject);
begin
  if sbNew.Enabled = True then
  begin
    sbNew.Enabled := False;
    sbDelete.Enabled := False;
    sbCancel.Enabled := True;
    sbRecord.Enabled := True;
  end else begin
    sbNew.Enabled := True;        
    sbDelete.Enabled := True;
    sbCancel.Enabled := False;
    sbRecord.Enabled := False;
  end;
end;

procedure TfmSale.Total(Sender: TObject);
begin
  vSubTotal := 0;

  qItem.First;
  while not qItem.Eof do
  begin
    vSubTotal := vSubTotal + qItemTOTAL_PRICE.AsFloat;
    qItem.Next;
  end;

  if not (qSales.State in [dsEdit,dsInsert]) then qSales.Edit;

  vTotal := vSubTotal;

  if (Trim(edDiscount.Text) <> '') or (Trim(edViDiscount.Text) <> '') then
  begin
    vPercent  := StrToFloatDef(edDiscount.Text, 0);
    vDiscount := vSubTotal * (vPercent / 100);
    vTotal   :=  vTotal - vDiscount;
  end;
  edViDiscount.Text := FloatToStr(vDiscount);
  qSalesTOTAL.AsFloat    := vTotal;
  qSalesSUBTOTAL.AsFloat := vSubTotal;
  qSalesDISCOUNT.AsFloat := vDiscount;
end;

procedure TfmSale.edDiscountExit(Sender: TObject);
begin
  if (vSubTotal > 0) then Total(Self)
  else begin
    ShowMessage('The sale is empty');
    edDiscount.Clear;
    Exit;
  end;
end;

end.
