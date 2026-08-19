unit uProduct;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls;

type
  TfmProduct = class(TForm)
    pnRodape: TPanel;
    sbClose: TSpeedButton;
    sbLeft: TSpeedButton;
    sbRight: TSpeedButton;
    sbFirst: TSpeedButton;
    sbLast: TSpeedButton;
    sbNew: TSpeedButton;
    sbDelete: TSpeedButton;
    sbRecord: TSpeedButton;
    sbCancel: TSpeedButton;
    qProduct: TFDQuery;
    dsProduct: TDataSource;
    dbeName: TDBEdit;
    dbeBarcode: TDBEdit;
    dbeReference: TDBEdit;
    dbeCost: TDBEdit;
    dbePrice: TDBEdit;
    dbeQuantity: TDBEdit;
    dbeMinS: TDBEdit;
    dbeLoc: TDBEdit;
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
    pnClient: TPanel;
    lbCode: TLabel;
    lbName: TLabel;
    lbBarcode: TLabel;
    lbUnit: TLabel;
    lbReference: TLabel;
    lbCost: TLabel;
    lbPrice: TLabel;
    lbQuantity: TLabel;
    lbMinS: TLabel;
    lbLoc: TLabel;
    lbActive: TLabel;
    lbKit: TLabel;
    lbDate: TLabel;
    lbCategory: TLabel;
    lbBrand: TLabel;
    lbSup: TLabel;
    sbPostalCode: TSpeedButton;
    sbCategory: TSpeedButton;
    sbBrand: TSpeedButton;
    sbSup: TSpeedButton;
    dbeCode: TDBEdit;
    dbeRdActive: TDBRadioGroup;
    cbKit: TComboBox;
    cbUnit: TComboBox;
    edCategory: TEdit;
    edBrand: TEdit;
    edSup: TEdit;
    dt: TDateTimePicker;
    qProductSUPPLIER_ID: TIntegerField;
    qProductSUPPLIER: TStringField;
    qProductBRAND: TStringField;
    qProductCATEGORY: TStringField;
    procedure sbCloseClick(Sender: TObject);
    procedure sbPostalCodeClick(Sender: TObject);
    procedure sbRightClick(Sender: TObject);
    procedure sbLeftClick(Sender: TObject);
    procedure sbLastClick(Sender: TObject);
    procedure sbFirstClick(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure dbeBarcodeKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCostKeyPress(Sender: TObject; var Key: Char);
    procedure dbePriceKeyPress(Sender: TObject; var Key: Char);
    procedure dbeQuantityKeyPress(Sender: TObject; var Key: Char);
    procedure dbeMinSKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure sbRecordClick(Sender: TObject);
    procedure dsProductDataChange(Sender: TObject; Field: TField);
    procedure qProductAfterScroll(DataSet: TDataSet);
    procedure dtChange(Sender: TObject);
    procedure cbUnitChange(Sender: TObject);
    procedure cbKitChange(Sender: TObject);
    procedure edCategoryChange(Sender: TObject);
    procedure edBrandChange(Sender: TObject);
    procedure edSupChange(Sender: TObject);
    procedure goSearch(Sender: TObject; sSQL, sNameT: String; ed: TEdit; var id: Integer);
    procedure sbCategoryClick(Sender: TObject);
    procedure sbBrandClick(Sender: TObject);
    procedure sbSupClick(Sender: TObject);
  private
    iCategoryID, iBrandID, iSupID: Integer;
    function Validation: Boolean;
  public
    { Public declarations }
  end;

var
  fmProduct: TfmProduct;

implementation

{$R *.dfm}

uses uTables, uPostalCode, uUseful, uSearch;

procedure TfmProduct.cbKitChange(Sender: TObject);
begin
  inStateEdit(qProduct);
end;

procedure TfmProduct.cbUnitChange(Sender: TObject);
begin
  inStateEdit(qProduct);
end;

procedure TfmProduct.dbeBarcodeKeyPress(Sender: TObject; var Key: Char);
begin
  JustNumberEdit(Key);
end;

procedure TfmProduct.dbeCostKeyPress(Sender: TObject; var Key: Char);
begin
  JustDecimal(Key, Trim(dbeCost.Text));
end;

procedure TfmProduct.dbeMinSKeyPress(Sender: TObject; var Key: Char);
begin
  JustDecimal(Key, Trim(dbeMinS.Text));
end;

procedure TfmProduct.dbePriceKeyPress(Sender: TObject; var Key: Char);
begin
  JustDecimal(Key, Trim(dbePrice.Text));
end;

procedure TfmProduct.dbeQuantityKeyPress(Sender: TObject; var Key: Char);
begin
  JustDecimal(Key, Trim(dbeQuantity.Text));
end;

procedure TfmProduct.dsProductDataChange(Sender: TObject; Field: TField);
begin
  Tables.EnableButtons(qProduct,fmProduct);
end;

procedure TfmProduct.dtChange(Sender: TObject);
begin
  if (dt.Date > Date) then
  begin
    ShowMessage('The registration date cannot be in the future!');
    dt.Date := Date;
  end;
  inStateEdit(qProduct);
end;

procedure TfmProduct.edBrandChange(Sender: TObject);
begin
  inStateEdit(qProduct);
end;

procedure TfmProduct.edCategoryChange(Sender: TObject);
begin
  inStateEdit(qProduct);
end;

procedure TfmProduct.edSupChange(Sender: TObject);
begin
  inStateEdit(qProduct);
end;

procedure TfmProduct.FormShow(Sender: TObject);
begin
  dbeName.SetFocus;
end;

procedure TfmProduct.qProductAfterScroll(DataSet: TDataSet);
begin
  cbUnit.OnChange     := nil;
  cbKit.OnChange      := nil;
  dt.OnChange         := nil;
  edCategory.OnChange := nil;
  edBrand.OnChange    := nil;
  edSup.OnChange      := nil;

  try
    if (qProductUNIT_MEASURE.AsString = 'UN')        then cbUnit.ItemIndex := 0
      else if (qProductUNIT_MEASURE.AsString = 'BX') then cbUnit.ItemIndex := 1
      else if (qProductUNIT_MEASURE.AsString = 'PC') then cbUnit.ItemIndex := 2
      else if (qProductUNIT_MEASURE.AsString = 'KG') then cbUnit.ItemIndex := 3
      else cbUnit.ItemIndex := 4;

    if qProductKIT.AsString = 'Y' then cbKit.ItemIndex := 0
      else cbKit.ItemIndex := 1;

    if not (qProductREGISTRATION_DATE.IsNull) then
      dt.Date := qProductREGISTRATION_DATE.AsDateTime
      else dt.Date := Date;

    iCategoryID     := qProductCATEGORY_ID.AsInteger;
    iBrandID        := qProductBRAND_ID.AsInteger;
    iSupID          := qProductSUPPLIER_ID.AsInteger;
    edCategory.Text := qProductCATEGORY.AsString;
    edBrand.Text    := qProductBRAND.AsString;
    edSup.Text      := qProductSUPPLIER.AsString;
  finally
    cbUnit.OnChange     := cbUnitChange;
    cbKit.OnChange      := cbKitChange;
    dt.OnChange         := dtChange;
    edCategory.OnChange := edCategoryChange;
    edBrand.OnChange    := edBrandChange;
    edSup.OnChange      := edSupChange;
  end;
end;

procedure TfmProduct.sbBrandClick(Sender: TObject);
begin
  goSearch(Self,'SELECT ID, NAME FROM BRAND ORDER BY NAME DESC', 'BRAND', edBrand, iBrandID);
end;

procedure TfmProduct.sbCancelClick(Sender: TObject);
begin
  ClearLabl(pnClient);
  qProduct.Cancel;
end;

procedure TfmProduct.sbCategoryClick(Sender: TObject);
begin
  goSearch(Self,'SELECT ID, NAME FROM CATEGORY ORDER BY NAME DESC', 'CATEGORY', edCategory, iCategoryID);
end;

procedure TfmProduct.sbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmProduct.sbDeleteClick(Sender: TObject);
begin
  if qProduct.IsEmpty then
  begin
    ShowMessage('There is no product to delete');
    Exit;
  end;

  if MessageDlg('Do you really want to delete this product?', mtConfirmation,[mbNo,mbYes], 0) = mrYes then
  begin
    qProduct.Delete;
  end;
end;

procedure TfmProduct.sbFirstClick(Sender: TObject);
begin
  qProduct.First;
end;

procedure TfmProduct.sbLastClick(Sender: TObject);
begin
  qProduct.Last;
end;

procedure TfmProduct.sbLeftClick(Sender: TObject);
begin
  qProduct.Prior;
end;

procedure TfmProduct.sbNewClick(Sender: TObject);
begin
  dbeName.SetFocus;
  dt.DateTime := Date;
  qProduct.Append;
end;

procedure TfmProduct.sbPostalCodeClick(Sender: TObject);
var pFormPostal: TfmPostalCode;
begin
  pFormPostal := TfmPostalCode.Create(Nil);
  try
    if pFormPostal.ShowModal = mrOk then dbeLoc.Text := pFormPostal.qPostalCodeCITY.AsString;
  finally
    FreeAndNil(pFormPostal);
  end;
end;

procedure TfmProduct.sbRecordClick(Sender: TObject);
begin
  if Validation then
  begin
    ClearLabl(pnClient);
    qProductREGISTRATION_DATE.AsDateTime := dt.Date;

    if (cbUnit.ItemIndex = 0)     then qProductUNIT_MEASURE.AsString := 'UN'
      else if (cbUnit.ItemIndex = 1)  then qProductUNIT_MEASURE.AsString := 'BX'
      else if (cbUnit.ItemIndex = 2 ) then qProductUNIT_MEASURE.AsString := 'PC'
      else if (cbUnit.ItemIndex = 3)  then qProductUNIT_MEASURE.AsString := 'KG'
      else qProductUNIT_MEASURE.AsString := 'LT';

    if cbKit.ItemIndex = 0 then qProductKIT.AsString := 'Y'
      else qProductKIT.AsString := 'N';

    if iCategoryID > 0 then qProductCATEGORY_ID.AsInteger := iCategoryID;
    if iBrandID    > 0 then qProductBRAND_ID.AsInteger    := iBrandID;
    if iSupID      > 0 then qProductSUPPLIER_ID.AsInteger := iSupID;
    qProduct.Post;
    ShowMessage('Product saved successfully!');
  end;
end;

procedure TfmProduct.sbRightClick(Sender: TObject);
begin
  qProduct.Next;
end;

procedure TfmProduct.sbSupClick(Sender: TObject);
begin
  goSearch(Self,'SELECT ID, NAME FROM ENTITY WHERE ROLE_TYPE = ''S'' ORDER BY NAME DESC', 'SUPPLIER', edSup, iSupID);
end;

function TfmProduct.Validation: Boolean;
begin
  Result := False;

  if not (qProduct.State in [dsEdit, dsInsert]) then
  begin
    MessageDlg('No edit to record!', mtInformation, [mbOK], 0);
    Exit;
  end;

  if (Trim(dbeName.Text) = '') then
  begin
    ShowMessage('The name is empty!');
    Required(lbName);
    dbeName.SetFocus;
    Exit;
  end;

  if (Trim(dbeBarcode.Text) = '') then
  begin
    ShowMessage('The barcode is empty!');
    Required(lbBarcode);
    dbeBarcode.SetFocus;
    Exit;
  end;

  if (cbUnit.ItemIndex = -1) or (Trim(cbUnit.Text) = '') then
  begin
    ShowMessage('The unit mensure is empty!');
    Required(lbUnit);
    cbUnit.SetFocus;
    Exit;
  end;

  if (Trim(JustNumbers(dbeCost.Text)) = '') then
  begin
    ShowMessage('The cost is empty!');
    Required(lbCost);
    dbeCost.SetFocus;
    Exit;
  end;

  if (Trim(JustNumbers(dbePrice.Text)) = '') then
  begin
    ShowMessage('The price is empty!');
    Required(lbPrice);
    dbePrice.SetFocus;
    Exit;
  end;

  if (Trim(JustNumbers(dbeQuantity.Text)) = '') then
  begin
    ShowMessage('The quantity is empty!');
    Required(lbQuantity);
    dbeQuantity.SetFocus;
    Exit;
  end;

  if (Trim(JustNumbers(dbeMinS.Text)) = '') then
  begin
    ShowMessage('The min. stock is empty!');
    Required(lbMinS);
    dbeMinS.SetFocus;
    Exit;
  end;

  if (Trim(dbeLoc.Text) = '') then
  begin
    ShowMessage('The localization is empty!');
    Required(lbLoc);
    dbeLoc.SetFocus;
    Exit;
  end;

  if (cbKit.ItemIndex = -1) or (Trim(cbKit.Text) = '') then
  begin
    ShowMessage('The kit is empty!');
    Required(lbKit);
    cbKit.SetFocus;
    Exit;
  end;

  if dbeRdActive.ItemIndex = -1 then
  begin
    ShowMessage('User should be active or inactive!');
    Required(lbActive);
    dbeRdActive.SetFocus;
    Exit;
  end;

  if (Trim(edCategory.Text) = '') then
  begin
    ShowMessage('The category is empty!');
    Required(lbCategory);
    edCategory.SetFocus;
    Exit;
  end;

  if (Trim(edBrand.Text) = '') then
  begin
    ShowMessage('The brand is empty!');
    Required(lbBrand);
    edBrand.SetFocus;
    Exit;
  end;

  if (Trim(edSup.Text) = '') then
  begin
    ShowMessage('The supplier is empty!');
    Required(lbSup);
    edSup.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TfmProduct.goSearch(Sender: TObject; sSQL, sNameT: String; ed: TEdit; var id: Integer);
var fSearch: TfmSearch;
begin
  fSearch := TfmSearch.Create(Self);
  try
    sSearch := sSQL;
    sTitle  := sNameT;
    if fSearch.ShowModal = mrOk then
    begin
      inStateEdit(qProduct);
      id := fSearch.qSearch.Fields[0].AsInteger;
      ed.Text := fSearch.qSearch.Fields[1].AsString;
    end;
  finally
    FreeAndNil(fSearch);
  end;
end;

end.
