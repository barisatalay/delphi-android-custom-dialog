unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Androidapi.CustomDialog, FMX.Edit, FMX.StdCtrls, FMX.ListBox, FMX.Layouts,
  FMX.Objects;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    CustomDialogs1: TCustomDialogs;
    CustomDialogs2: TCustomDialogs;
    CustomDialogs3: TCustomDialogs;
    Button1: TButton;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    CustomDialogs4: TCustomDialogs;
    Edit4: TEdit;
    CustomDialogs5: TCustomDialogs;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure CustomDialogs2PopUpClose(ResultText: string; ComboIndex: Integer;
      TrackValue: Single);
    procedure CustomDialogs4PopUpClose(ResultText: string; ComboIndex: Integer;
      TrackValue: Single);
    procedure CustomDialogs1PopUpClose(ResultText: string; ComboIndex: Integer;
      TrackValue: Single);
    procedure CustomDialogs5PopUpClose(ResultText: string; ComboIndex: Integer;
      TrackValue: Single);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  Key  : Integer = 0;

implementation

{$R *.fmx}

procedure TForm3.Button1Click(Sender: TObject);
begin
  Edit1.Text := CustomDialogs2.ComboBoxSettings.ItemIndex.ToString;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  with CustomDialogs5.MenuSettings.Add do
    Text := 'Menu Item '+ Key.ToString;
  Inc(Key)
end;

procedure TForm3.CustomDialogs1PopUpClose(ResultText: string;
  ComboIndex: Integer; TrackValue: Single);
begin
  Edit1.Text := ResultText;
end;

procedure TForm3.CustomDialogs2PopUpClose(ResultText: string;
  ComboIndex: Integer; TrackValue: Single);
begin
   Edit2.Text := ResultText;
end;

procedure TForm3.CustomDialogs4PopUpClose(ResultText: string;
  ComboIndex: Integer; TrackValue: Single);
begin
  ShowMessage(ResultText);
end;

procedure TForm3.CustomDialogs5PopUpClose(ResultText: string;
  ComboIndex: Integer; TrackValue: Single);
begin
  ShowMessage('Selected Index: '+ ComboIndex.ToString + #13 + #10 +
              'Selected Item Text: ' + ResultText);

end;

end.
