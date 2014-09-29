unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Androidapi.CustomDialog, FMX.Edit, FMX.StdCtrls, FMX.ListBox, FMX.Layouts,
  FMX.Objects, FMX.ListView.Types, FMX.ListView,
  Androidapi.CustomDialogForListview;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    CustomDialogs1: TCustomDialogs;
    CustomDialogs2: TCustomDialogs;
    CustomDialogs3: TCustomDialogs;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    CustomDialogs4: TCustomDialogs;
    Edit4: TEdit;
    CustomDialogs5: TCustomDialogs;
    ListView1: TListView;
    CustomDialogs6: TCustomDialogs;
    procedure CustomDialogs6PopUpClose(ResultText: string; ComboIndex: Integer;
      TrackValue: Single; ListViewItem: TListViewItem);
    procedure CustomDialogs5PopUpClose(ResultText: string; ComboIndex: Integer;
      TrackValue: Single; ListViewItem: TListViewItem);
    procedure FormCreate(Sender: TObject);
    procedure CustomDialogs4PopUpClose(ResultText: string; ComboIndex: Integer;
      TrackValue: Single; ListViewItem: TListViewItem);
    procedure CustomDialogs2PopUpClose(ResultText: string; ComboIndex: Integer;
      TrackValue: Single; ListViewItem: TListViewItem);
    procedure CustomDialogs1PopUpClose(ResultText: string; ComboIndex: Integer;
      TrackValue: Single; ListViewItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

procedure TForm3.CustomDialogs1PopUpClose(ResultText: string;
  ComboIndex: Integer; TrackValue: Single; ListViewItem: TListViewItem);
begin
Edit1.Text := ResultText;
end;

procedure TForm3.CustomDialogs2PopUpClose(ResultText: string;
  ComboIndex: Integer; TrackValue: Single; ListViewItem: TListViewItem);
begin
   Edit2.Text := ResultText;
end;

procedure TForm3.CustomDialogs4PopUpClose(ResultText: string;
  ComboIndex: Integer; TrackValue: Single; ListViewItem: TListViewItem);
begin
  ShowMessage(ResultText);
end;

procedure TForm3.CustomDialogs5PopUpClose(ResultText: string;
  ComboIndex: Integer; TrackValue: Single; ListViewItem: TListViewItem);
begin
  ShowMessage('Selected Index: '+ ComboIndex.ToString + #13 + #10 +
              'Selected Item Text: ' + ResultText);
end;

procedure TForm3.CustomDialogs6PopUpClose(ResultText: string;
  ComboIndex: Integer; TrackValue: Single; ListViewItem: TListViewItem);
begin
  ShowMessage(ListViewItem.Text);
end;

procedure TForm3.FormCreate(Sender: TObject);
var Key: Integer;
begin
  for Key := 0 to 5 do
  begin
    with CustomDialogs5.MenuSettings.Add do
      Text := 'Menu Item '+ Key.ToString;

    with CustomDialogs6.MenuSettings.Add do
      Text := 'Menu Item '+ Key.ToString;

    with ListView1.Items.Add do
      Text := 'Listview Item ' + Key.ToString;
  end;
end;

end.


