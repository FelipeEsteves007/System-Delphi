unit uProduct;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

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
    pnClient: TPanel;
    qProduct: TFDQuery;
    dsProduct: TDataSource;
    lbCode: TLabel;
    dbeCode: TDBEdit;
    lbName: TLabel;
    dbeName: TDBEdit;
    lbBarcode: TLabel;
    dbeBarcode: TDBEdit;
    lbUnit: TLabel;
    lbReference: TLabel;
    dbeReference: TDBEdit;
    lbCost: TLabel;
    dbeCost: TDBEdit;
    lbPrice: TLabel;
    dbePrice: TDBEdit;
    lbQuantity: TLabel;
    dbeQuantity: TDBEdit;
    lbMinS: TLabel;
    dbeMinS: TDBEdit;
    lbLoc: TLabel;
    dbeLoc: TDBEdit;
    lbActive: TLabel;
    dbeRdActive: TDBRadioGroup;
    lbKit: TLabel;
    cbKit: TComboBox;
    lbDate: TLabel;
    dbeDate: TDBEdit;
    cbUnit: TComboBox;
    lbCategory: TLabel;
    lbBrand: TLabel;
    lbSup: TLabel;
    sbCategory: TSpeedButton;
    sbBrand: TSpeedButton;
    sbSup: TSpeedButton;
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
    sbPostalCode: TSpeedButton;
    edCategory: TEdit;
    edBrand: TEdit;
    edSup: TEdit;
    qProductQUANTITY: TFMTBCDField;
    qProductMIN_STOCK: TFMTBCDField;
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
  private
    function Validation: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmProduct: TfmProduct;

implementation

{$R *.dfm}

uses uTables, uPostalCode, uUseful;

procedure TfmProduct.dbeBarcodeKeyPress(Sender: TObject; var Key: Char);
begin
  JustNumberEdit(Key);
end;

procedure TfmProduct.dbeCostKeyPress(Sender: TObject; var Key: Char);
begin
  JustNumberEdit(Key);
end;

procedure TfmProduct.dbeMinSKeyPress(Sender: TObject; var Key: Char);
begin
  JustNumberEdit(Key);
end;

procedure TfmProduct.dbePriceKeyPress(Sender: TObject; var Key: Char);
begin
  JustNumberEdit(Key);
end;

procedure TfmProduct.dbeQuantityKeyPress(Sender: TObject; var Key: Char);
begin
  JustNumberEdit(Key);
end;

procedure TfmProduct.dsProductDataChange(Sender: TObject; Field: TField);
begin
  Tables.EnableButtons(qProduct,fmProduct);
end;

procedure TfmProduct.FormShow(Sender: TObject);
begin
  dbeDate.Text := DateToStr(Date);
  dbeName.SetFocus;
end;

procedure TfmProduct.qProductAfterScroll(DataSet: TDataSet);
begin
  if (qProductUNIT_MEASURE.AsString = 'UN') then cbKit.ItemIndex := 0
    else if (qProductUNIT_MEASURE.AsString = 'BX') then cbKit.ItemIndex := 1
    else if (qProductUNIT_MEASURE.AsString = 'PC') then cbKit.ItemIndex := 2
    else if (qProductUNIT_MEASURE.AsString = 'KG') then cbKit.ItemIndex := 3
    else cbKit.ItemIndex := 4
end;

procedure TfmProduct.sbCancelClick(Sender: TObject);
begin
  qProduct.Cancel;
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
  qProduct.Last;
end;

procedure TfmProduct.sbLastClick(Sender: TObject);
begin
  qProduct.First;
end;

procedure TfmProduct.sbLeftClick(Sender: TObject);
begin
  qProduct.Prior;
end;

procedure TfmProduct.sbNewClick(Sender: TObject);
begin
  dbeName.SetFocus;
  qProduct.Append;
end;

procedure TfmProduct.sbPostalCodeClick(Sender: TObject);
var pFormPostal: TfmPostalCode;
begin
  pFormPostal := TfmPostalCode.Create(Self);
  try
    if pFormPostal.ShowModal = mrOk then dbeLoc.Text := fmPostalCode.qPostalCodeCITY.AsString;
  finally
    FreeAndNil(pFormPostal);
  end;
end;

procedure TfmProduct.sbRecordClick(Sender: TObject);
begin
  if Validation then
  begin
      if (cbKit.ItemIndex = 0) then qProductUNIT_MEASURE.AsString := 'UN'
    else if (cbKit.ItemIndex = 1) then qProductUNIT_MEASURE.AsString := 'BX'
    else if (cbKit.ItemIndex = 2 ) then qProductUNIT_MEASURE.AsString := 'PC'
    else if (cbKit.ItemIndex = 3) then qProductUNIT_MEASURE.AsString := 'KG'
    else qProductUNIT_MEASURE.AsString := 'LT';

    ShowMessage('Product saved successfully!');
    qProduct.Post;
  end;
end;

procedure TfmProduct.sbRightClick(Sender: TObject);
begin
  qProduct.Next;
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

end.
