unit uCustomer;

interface

uses
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, System.UiTypes,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Classes, SysUtils, Vcl.Graphics;

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
    lbPostalCode: TLabel;
    sbPostalCode: TSpeedButton;
    Label1: TLabel;
    cbType: TComboBox;
    cbState: TComboBox;
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
    procedure dbeNumberKeyPress(Sender: TObject; var Key: Char);
    procedure dbePhoneKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCellKeyPress(Sender: TObject; var Key: Char);
    procedure dbeDocumentKeyPress(Sender: TObject; var Key: Char);
    procedure dbeNameKeyPress(Sender: TObject; var Key: Char);
    procedure dbeTradeKeyPress(Sender: TObject; var Key: Char);
    procedure dbeStateRKeyPress(Sender: TObject; var Key: Char);
    function  Validation: Boolean;
    procedure sbPostalCodeClick(Sender: TObject);
    procedure qEntityAfterScroll(DataSet: TDataSet);
  private
   { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCustomer: TfmCustomer;

implementation

{$R *.dfm}

uses uTables, uUseful, uPostalCode;

procedure TfmCustomer.dbeCellKeyPress(Sender: TObject; var Key: Char);
begin
  JustNumberEdit(Key);
end;

procedure TfmCustomer.dbeDocumentExit(Sender: TObject);
begin
  if dbeDocument.Text <> '' then
  begin
    if (Length(dbeDocument.Text) < 11) or not CPF(JustNumbers(dbeDocument.Text)) then
    begin
      ShowMessage('Invalid document!');
      dbeDocument.SetFocus;
    end;
  end;
end;

procedure TfmCustomer.dbeDocumentKeyPress(Sender: TObject; var Key: Char);
begin
  JustNumberEdit(Key);
end;

procedure TfmCustomer.dbeNameKeyPress(Sender: TObject; var Key: Char);
begin
  JustCharEdit(Key);
end;

procedure TfmCustomer.dbeNumberKeyPress(Sender: TObject; var Key: Char);
begin
  JustNumberEdit(Key);
end;

procedure TfmCustomer.dbePhoneKeyPress(Sender: TObject; var Key: Char);
begin
  JustNumberEdit(Key);
end;

procedure TfmCustomer.dbeStateRKeyPress(Sender: TObject; var Key: Char);
begin
  JustNumberEdit(Key)
end;

procedure TfmCustomer.dbeTradeKeyPress(Sender: TObject; var Key: Char);
begin
  JustCharEdit(Key);
end;

procedure TfmCustomer.dsEntityStateChange(Sender: TObject);
var bEdit: Boolean;
begin
  Tables.EnableButtons(qEntity,fmCustomer);
end;

procedure TfmCustomer.FormShow(Sender: TObject);
begin
  if not qEntity.Active then qEntity.Open;
  dbeName.SetFocus;
end;

procedure TfmCustomer.qEntityAfterScroll(DataSet: TDataSet);
begin
  if qEntityENTITY_TYPE.AsString = 'M' then
     cbType.ItemIndex := 0
  else if qEntityENTITY_TYPE.AsString = 'F' then
    cbType.ItemIndex := 1;

  cbState.ItemIndex := cbState.Items.IndexOf(qEntitySTATE_CODE.AsString);
end;

procedure TfmCustomer.sbCancelClick(Sender: TObject);
var
  I: Integer;
begin
  qEntity.Cancel;

  for I := 0 to pnClient.ControlCount - 1 do
  begin
    if pnClient.Controls[I] is TLabel then
    begin
      if TLabel(pnClient.Controls[I]).Tag = 1 then
      begin
        TLabel(pnClient.Controls[I]).Font.Color := clWindowText;
      end;
    end;
  end;
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
  if Validation then
  begin
    if cbType.ItemIndex = 0 then qEntityENTITY_TYPE.AsString := 'M'
      else if cbType.ItemIndex = 1 then qEntityENTITY_TYPE.AsString := 'F';
    qEntitySTATE_CODE.AsString := cbState.Text;
    qEntity.Post;
    ShowMessage('Customer saved successfully!');
    Exit;
  end;
end;

procedure TfmCustomer.sbRightClick(Sender: TObject);
begin
  qEntity.Next;
end;

procedure TfmCustomer.sbPostalCodeClick(Sender: TObject);
var pFormPostal: TfmPostalCode;
begin
  pFormPostal := TfmPostalCode.Create(Self);
  try
    if pFormPostal.ShowModal = mrOk then
    begin
      if not (qEntity.State in [dsEdit, dsInsert]) then qEntity.Edit;
      dbeCity.Text      := pFormPostal.qPostalCodeCITY.AsString;
      dbeAddress.Text   := pFormPostal.qPostalCodeADDRESS.AsString;
      dbeNeight.Text    := pFormPostal.qPostalCodeNEIGHBORHOOD.AsString;
      cbState.ItemIndex := cbState.Items.IndexOf(pFormPostal.qPostalCodeSTATE_CODE.AsString);
      dbePostal.Text    := pFormPostal.qPostalCodePOSTAL_CODE.AsString;
    end;
  finally
    FreeAndNil(pFormPostal);
  end;
end;

function TfmCustomer.Validation: Boolean;
var I: Integer;
    ed: TEdit;
    lb: TLabel;
begin
  Result := False;

  if not (qEntity.State in [dsEdit, dsInsert]) then
  begin
    MessageDlg('No edit to record!', mtInformation, [mbOK], 0);
    Exit;
  end;

  for I := 0 to pnClient.ControlCount - 1 do
  begin
    if (pnClient.Controls[I] is TLabel) then
    begin
      if TLabel(pnClient.Controls[I]).Tag = 1 then
      begin
        TLabel(pnClient.Controls[I]).Font.Color := clWindowText;
      end;
    end;
  end;

  for I := 0 to pnClient.ControlCount - 1 do
  begin
    if pnClient.Controls[I] is TLabel then
    begin
      lb := TLabel(pnClient.Controls[I]);
      if (lb.Tag = 1) and Assigned(lb.FocusControl) and (lb.FocusControl is TCustomEdit) then
      begin
        if (Trim(TCustomEdit(lb.FocusControl).Text) = '') then
        begin
          lb.Font.Color := clRed;
          TCustomEdit(lb.FocusControl).SetFocus;
          ShowMessage('The ' + StringReplace(lb.Caption, '&', '', [rfReplaceAll]) + ' is empty!');
          Exit;
        end;
      end;
    end;
  end;

  if (cbType.ItemIndex = -1) or (Trim(cbType.Text) = '') then
  begin
    ShowMessage('The type is empty!');
    cbType.SetFocus;
    Exit;
  end;

  if (cbState.ItemIndex = -1) or (Trim(cbState.Text) = '') then
  begin
    ShowMessage('The state is empty!');
    cbState.SetFocus;
    Exit;
  end;

  if (Trim(JustNumbers(dbePhone.Text)) <> '') then
  begin
    if Length(JustNumbers(Trim(dbePhone.Text))) < 10 then
    begin
      ShowMessage('Invalid number!');
      dbePhone.SetFocus;
      Exit;
    end;
  end;

  if Length(JustNumbers(Trim(dbeCell.Text))) < 11 then
  begin
    ShowMessage('Invalid number!');
    dbeCell.SetFocus;
    Exit;
  end;

if Trim(dbeEmail.Text) <> '' then
  begin
    if (Pos('@', dbeEmail.Text) = 0) then
    begin
      ShowMessage('Invalid email address!');
      dbeEmail.SetFocus;
      Exit;
    end;
  end;


  if dbeRdActive.ItemIndex = -1 then
  begin
    ShowMessage('User should be active or inactive!');
    dbeRdActive.SetFocus;
    Exit;
  end;

  Result := True;
end;

end.
