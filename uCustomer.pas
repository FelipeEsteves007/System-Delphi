unit uCustomer;

interface

uses
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Classes, SysUtils;

type
  TfmCustomer = class(TForm)
    pnRodape: TPanel;
    sbClose: TSpeedButton;
    sbLeft: TSpeedButton;
    sbRight: TSpeedButton;
    pnClient: TPanel;
    qEntity: TFDQuery;
    dbeCode: TDBEdit;
    lbCode: TLabel;
    lbName: TLabel;
    dbeName: TDBEdit;
    lbTrade: TLabel;
    dbeTrade: TDBEdit;
    lbType: TLabel;
    cbeType: TDBComboBox;
    dbeDocument: TDBEdit;
    lbDocument: TLabel;
    lbStateR: TLabel;
    dbeStateR: TDBEdit;
    lbPhone: TLabel;
    dbePhone: TDBEdit;
    lbCell: TLabel;
    dbeCell: TDBEdit;
    lbEmail: TLabel;
    dbeEmail: TDBEdit;
    lbPostal: TLabel;
    dbePostal: TDBEdit;
    dbeAddress: TDBEdit;
    lbAddress: TLabel;
    lbNumber: TLabel;
    dbeNumber: TDBEdit;
    lbComplement: TLabel;
    dbeComplement: TDBEdit;
    lbNeight: TLabel;
    dbeNeight: TDBEdit;
    lbCity: TLabel;
    dbeCity: TDBEdit;
    lbState: TLabel;
    cbeState: TDBComboBox;
    dbeRdActive: TDBRadioGroup;
    qEntityID: TIntegerField;
    qEntityNAME: TStringField;
    qEntityTRADE_NAME: TStringField;
    qEntityENTITY_TYPE: TStringField;
    qEntityDOCUMENT_NUMBER: TStringField;
    qEntitySTATE_REGISTRATION: TStringField;
    qEntityPHONE: TStringField;
    qEntityCELLPHONE: TStringField;
    qEntityEMAIL: TStringField;
    qEntityPOSTAL_CODE: TStringField;
    qEntityADDRESS: TStringField;
    qEntityADDRESS_NUMBER: TStringField;
    qEntityCOMPLEMENT: TStringField;
    qEntityNEIGHBORHOOD: TStringField;
    qEntityCITY: TStringField;
    qEntitySTATE_CODE: TStringField;
    qEntityACTIVE: TStringField;
    dsEntity: TDataSource;
    sbFirst: TSpeedButton;
    sbLast: TSpeedButton;
    sbNew: TSpeedButton;
    sbDelete: TSpeedButton;
    sbRecord: TSpeedButton;
    sbCancel: TSpeedButton;
    procedure sbCloseClick(Sender: TObject);
    procedure sbLastClick(Sender: TObject);
    procedure sbRightClick(Sender: TObject);
    procedure sbLeftClick(Sender: TObject);
    procedure sbFirstClick(Sender: TObject);
    procedure dsEntityStateChange(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure sbRecordClick(Sender: TObject);
    procedure dbeDocumentExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCustomer: TfmCustomer;

implementation

{$R *.dfm}

uses uTables, uUseful;

procedure TfmCustomer.dbeDocumentExit(Sender: TObject);
begin
  if dbeDocument.Text <> '' then
  begin
    if (Length(dbeDocument.Text) < 11) or not CPF(JustNumbers(dbeDocument.Text)) then
    begin
      ShowMessage('CPF inválido!');
      dbeDocument.SetFocus;
    end;
  end;
end;

procedure TfmCustomer.dsEntityStateChange(Sender: TObject);
var bEdit: Boolean;
begin
  Tables.EnableButtons(qEntity,bEdit,fmCustomer);
end;

procedure TfmCustomer.FormShow(Sender: TObject);
begin
  if not qEntity.Active then qEntity.Open;
  dbeRdActive.ItemIndex := 0;
  dbeName.SetFocus;
end;

procedure TfmCustomer.sbCancelClick(Sender: TObject);
begin
  qEntity.Cancel;
end;

procedure TfmCustomer.sbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmCustomer.sbDeleteClick(Sender: TObject);
begin
  if MessageDlg('Do you really want to delete this user?', mtConfirmation,[mbNo,mbYes], 0) = mrYes then
  begin
    qEntity.Delete;
  end;
end;

procedure TfmCustomer.sbFirstClick(Sender: TObject);
begin
  qEntity.First;
end;

procedure TfmCustomer.sbLastClick(Sender: TObject);
begin
  qEntity.Last;
end;

procedure TfmCustomer.sbLeftClick(Sender: TObject);
begin
  qEntity.Prior;
end;

procedure TfmCustomer.sbNewClick(Sender: TObject);
begin
  qEntity.Append;
end;

procedure TfmCustomer.sbRecordClick(Sender: TObject);
begin
  if not (qEntity.State in [dsEdit, dsInsert]) then
  begin
    MessageDlg('No edit to record!', mtInformation, [mbOK], 0);
    Exit;
  end;

  if Trim(dbeName.Text) = '' then
  begin
    ShowMessage('The name is empty!');
    Exit;
  end;

  if Trim(dbeTrade.Text) = '' then
  begin
    ShowMessage('The trade name is empty!');
    Exit;
  end;

  if Trim(dbeDocument.Text) = '' then
  begin
    ShowMessage('The document name is empty!');
    Exit;
  end;

  if Trim(dbeStateR.Text) = '' then
  begin
    ShowMessage('The state registration is empty!');
    Exit;
  end;

  if Trim(dbeCell.Text) = '' then
  begin
    ShowMessage('The cellphone is empty!');
    Exit;
  end;

  if Trim(dbePostal.Text) = '' then
  begin
    ShowMessage('The postal code is empty!');
    Exit;
  end;

  if Trim(dbeAddress.Text) = '' then
  begin
    ShowMessage('The address is empty!');
    Exit;
  end;

  if Trim(dbeNumber.Text) = '' then
  begin
    ShowMessage('The number address is empty!');
    Exit;
  end;

  if Trim(dbeNeight.Text) = '' then
  begin
    ShowMessage('The neightborhood is empty!');
    Exit;
  end;

  if Trim(dbeCity.Text) = '' then
  begin
    ShowMessage('The city is empty!');
    Exit;
  end;
  //qEntity.Post;
end;

procedure TfmCustomer.sbRightClick(Sender: TObject);
begin
  qEntity.Next;
end;

end.
