unit uSale;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

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
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label6: TLabel;
    DBEdit3: TDBEdit;
    pnRodape: TPanel;
    DBGrid1: TDBGrid;
    sbNew: TSpeedButton;
    sbRecord: TSpeedButton;
    sbCancel: TSpeedButton;
    sbDelete: TSpeedButton;
    sbClose: TSpeedButton;
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    procedure sbCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSale: TfmSale;

implementation

{$R *.dfm}

uses uTables;

procedure TfmSale.sbCloseClick(Sender: TObject);
begin
 Close;
end;

end.
