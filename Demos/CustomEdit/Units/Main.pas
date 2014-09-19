unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Androidapi.CustomDialog, FMX.Edit, FMX.StdCtrls, FMX.ListBox;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    CustomDialogs1: TCustomDialogs;
    CustomDialogs2: TCustomDialogs;
    CustomDialogs3: TCustomDialogs;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

end.
