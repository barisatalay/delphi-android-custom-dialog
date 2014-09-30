unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, Androidapi.CustomDialog, FMX.Objects, FMX.ListBox, FMX.ListView, FMX.Layouts, FMX.Edit;

type
  TForm26 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Text1: TText;
    CustomDialogs1: TCustomDialogs;
    CustomDialogs2: TCustomDialogs;
    CustomDialogs3: TCustomDialogs;
    procedure CustomDialogs1PopUpClose(ResultText: string; ComboIndex: Integer; TrackValue: Single; ListViewItem: TListViewItem);
    procedure CustomDialogs2PopUpClose(ResultText: string; ComboIndex: Integer; TrackValue: Single; ListViewItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form26: TForm26;

implementation

{$R *.fmx}

procedure TForm26.CustomDialogs1PopUpClose(ResultText: string; ComboIndex: Integer; TrackValue: Single; ListViewItem: TListViewItem);
begin
  Edit1.Text := ResultText;
end;

procedure TForm26.CustomDialogs2PopUpClose(ResultText: string; ComboIndex: Integer; TrackValue: Single; ListViewItem: TListViewItem);
begin
  Edit2.Text := ResultText;
end;


end.
