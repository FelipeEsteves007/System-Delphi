unit uCustomer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

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
    dbCbState: TDBComboBox;
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
    sbNovoReg: TSpeedButton;
    sbCReg: TSpeedButton;
    sbGReg: TSpeedButton;
    sbEReg: TSpeedButton;
    procedure sbCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCustomer: TfmCustomer;

implementation

{$R *.dfm}

uses uTables;

procedure TfmCustomer.sbCloseClick(Sender: TObject);
begin
  Close;
end;

end.
