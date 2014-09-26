unit Androidapi.CustomDialog;
{- Unit Info----------------------------------------------------------------------------
Unit Name  : Androidapi.CustomDialog
Created By : Barýþ Atalay 16/09/2014
Last Change By :

Web Site: http://brsatalay.blogspot.com.tr/

Notes:
----------------------------------------------------------------------------------------}

interface
Uses System.Classes, System.UITypes, System.Actions, System.SysUtils, System.Types,
     FMX.Edit, FMX.Objects, FMX.Layouts, FMX.Controls, FMX.Forms, FMX.Types, FMX.StdCtrls, FMX.ListBox,
     FMX.Graphics, Generics.Collections
     ;

Type

  TCustomType                 = (Edit,ComboBox,TrackBar,Menu);
  TOnPopUpClose               = procedure(ResultText: String; ComboIndex: Integer; TrackValue: Single) of object;

  TComboSettings              = class(TPersistent)
    private
      FItems                  : TStringList;
      FIndex                  : Integer;
      FReturn                 : Boolean;
      procedure               SetWrite(const Value: TStringList);
      function                GetIndex:Integer;
    public
      FCombo                  : TComboBox;
      constructor             Create();
      destructor              Destroy;         override;
      procedure               Assign(Source     : TPersistent); override;
      property                ItemIndex   : Integer      read GetIndex write FIndex;
    published
      property                Items        : TStringList read FItems  write SetWrite;
      property                ReturnText   : Boolean     read FReturn write FReturn;//  default True;
  end;

  TTrackSettings              = class(TPersistent)
    private
      FMin,
      FMax,
      FValue                  : Single;
      FReturn                 : Boolean;
    procedure                 SetWrite(const Value: Single);
    public
      constructor             Create;
      destructor              Destroy;         override;
      procedure               Assign(Source     : TPersistent); override;
    published
      property                Minimum     : Single     read FMin     write FMin;
      property                Maximum     : Single     read FMax     write FMax;
      property                Value       : Single     read FValue   write SetWrite;
      property                ReturnText  : Boolean    read FReturn  write FReturn;//  default True;
  end;

  TEditSettings               = class(TPersistent)
    private
      FText                   : String;
    public
      constructor             Create;
      destructor              Destroy;         override;
      procedure               Assign(Source     : TPersistent); override;
    published
      property                Text              : String     read FText   write FText;
  end;

  TCustomDialogs              = class(TComponent)
    private Type
      TMenuSettings               = class(TPersistent)
      private
        FItems                  : TObjectList<TListBoxItem>;
        FIndex                  : Integer;
        FReturn                 : Boolean;
        FOwner                  : TCustomDialogs;
        function                GetItem(const Index: Integer): TListBoxItem;
      public
        constructor             Create(AOwner: TCustomDialogs);
        destructor              Destroy;         override;
        procedure               Assign(Source    : TPersistent); override;
        function                Add: TListBoxItem;
        property                Item[const Index: Integer]     : TListBoxItem read GetItem; default;
      published
        property                ReturnText   : Boolean      read FReturn        write FReturn;
    end;
  private
    FOnPopUpClose             : TOnPopUpClose;
    FMenuSettings             : TMenuSettings;
    FComboSetting             : TComboSettings;
    FTrackSetting             : TTrackSettings;
    FEditSettings             : TEditSettings;
    FForm                     : TForm;
    FEdit                     : TControl;
    BG,
    Bot,
    Ic,
    xCenter                    : TRectangle;
    TamamBut,
    IptalBut                  : TButton;
    Baslik                    : TText;
    FRes                      : TCustomEdit;
    FCom                      : TComboBox;
    FTrack                    : TTrackBar;
    FMenu                     : TListBox;
    Lay                       : TLayout;
    FTitle                    : String;
    FKind                     : TCustomType;
    FValue                    : Single;
    FColor                    : TAlphaColor;
    function                  GetComboSetting: TComboSettings;
    procedure                 SetComboSetting(const Value: TComboSettings);
    procedure                 FreeNil;
    procedure                 SetComponent(const Value: TControl);
    procedure                 FClick(Sender: TObject);
    procedure                 TamamClick(Sender: TObject);
    procedure                 IptalClick(Sender: TObject);
    procedure                 xItemClick(const Sender: TCustomListBox; const Item: TListBoxItem) ;
    procedure                 ClosePopup(Sender: TObject);
    procedure                 SetComboSet(const Value: TComboSettings);
    function                  GetComboSet:TComboSettings;
    function                  GetTrackSet: TTrackSettings;
    procedure                 SetTrackSet(const Value: TTrackSettings);
    function                  GetEditSet: TEditSettings;
    procedure                 SetEditSet(const Value: TEditSettings);
    function                  GetColor: TAlphaColor;
    procedure                 SetColor(const Value: TAlphaColor);
    function GetMenuSet: TMenuSettings;
    procedure SetMenuSet(const Value: TMenuSettings);
  public
    ResultText                : String;
    constructor               Create(AOwner: TComponent); override;
    destructor                Destroy; override;
    procedure                 Execute;
  published
    property Parentx          : TControl       read FEdit         write SetComponent;
    property Title            : String         read FTitle        write FTitle;
    property Types            : TCustomType    read FKind         write FKind;
    property TrackValue       : Single         read FValue        write FValue;
    property ComboBoxSettings : TComboSettings read GetComboSet   write SetComboSet;
    property TrackBarSettings : TTrackSettings read GetTrackSet   write SetTrackSet;
    property EditSettings     : TEditSettings  read GetEditSet    write SetEditSet;
    property BackgroundColor  : TAlphaColor    read GetColor      write SetColor default TAlphaColorRec.Black;
    property OnPopUpClose     : TOnPopUpClose  read FOnPopUpClose write FOnPopUpClose;
    property MenuSettings     : TMenuSettings  read GetMenuSet    write SetMenuSet;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Android', [TCustomDialogs]);
end;

{ TCustomDialogs }

procedure TCustomDialogs.ClosePopup(Sender: TObject);
begin
  if Assigned(FCom) then
    if FCom.ItemIndex <> -1 then
      FComboSetting.ItemIndex := FCom.ItemIndex;
end;

constructor TCustomDialogs.Create(AOwner: TComponent);
begin
  inherited;
  FForm         := AOwner AS TForm;
  FComboSetting := TComboSettings.Create;
  FTrackSetting := TTrackSettings.Create;
  FEditSettings := TEditSettings.Create;
  FMenuSettings := TMenuSettings.Create(Self);
end;

destructor TCustomDialogs.Destroy;
begin
  FComboSetting.Free;
  FTrackSetting.Free;
  FEditSettings.Free;
  FMenuSettings.Free;
  FreeNil;
  inherited;
end;

procedure TCustomDialogs.Execute;
var I,Key: Integer;
begin
  BG := TRectangle.Create(FForm);
  with Bg do
  begin
    Parent     := FForm AS TForm;
    Align      := TAlignLayout.Contents;
    Fill.Color := TAlphaColorRec.Black;
    Opacity    := 0.5;
    Sides      := [];

    xCenter := TRectangle.Create(FForm);
    with xCenter do
    begin
      Parent       := FForm AS TForm;
      Height       := 164;
      Width        := 270;
      Stroke.Color := $FFB1B1B1;
      Fill.Color   := TAlphaColorRec.Black;//FColor
      Align        := TAlignLayout.None;

      if BG.Height < 600 then
        Position.Y   := 50
      else
        Position.Y   := ((FForm.Height / 2){/ 2}) - 164;
      Position.X   := (FForm.Width / 2) - 135;

      Baslik := TText.Create(xCenter);
      with Baslik do
      begin
        Parent       := xCenter;
        Text         := Title;
        Align        := TAlignLayout.Top;
        Height       := 50;
        Margins.Left := 10;
        HorzTextAlign := TTextAlign.Leading;
        with TextSettings do
        begin
          FontColor := TAlphaColorRec.White;
          Font.Size := 20;
        end;
      end;

      {$REGION 'Butonlar'}
      if FKind <> TCustomType.Menu then
      begin
        Bot := TRectangle.Create(xCenter);
        with Bot do
        begin
          Parent       := xCenter;
          Align        := TAlignLayout.Bottom;
          Fill.Color   := $FFC3C3C3;
          Sides        := [];
          Height       := 50;


          IptalBut := TButton.Create(Bot);
          with IptalBut do
          begin
            Parent  := Bot;
            Align   := TAlignLayout.Left;
            Text    := 'Ýptal';
            Height  := 45;
            Width   := 129;
            OnClick := IptalClick;
            with Margins do
            begin
              Left   := 3;
              Top    := 3;
              Bottom := 3;
            end;
          end;

          TamamBut := TButton.Create(Bot);
          with TamamBut do
          begin
            Parent  := Bot;
            Align   := TAlignLayout.Left;
            Text    := 'Tamam';
            Height  := 45;
            Width   := 129;
            OnClick := TamamClick;
            with Margins do
            begin
              Left   := 3;
              Top    := 3;
              Bottom := 3;
            end;
          end;
        end;
      end;
      {$ENDREGION}

      {$REGION 'Orta Bölüm'}
      Lay := TLayout.Create(xCenter);
      with Lay do
      begin
        Parent := xCenter;
        Align := TAlignLayout.Client;

        if FKind <> TCustomType.Menu then
        begin
          IC := TRectangle.Create(Lay);
          with IC do
          begin
            Parent     := Lay;
            Align      := TAlignLayout.Center;
            Height     := 40;
            Width      := 233;
            Fill.Color := $FFE0E0E0;
            XRadius    := 6;
            YRadius    := 6;

            if FKind = TCustomType.Edit then
            begin
              FRes := TEdit.Create(IC);
              with FRes do
              begin
                Parent   := IC;
                Align    := TAlignLayout.Client;
                with Margins Do
                begin
                  Left  := 5;
                  Right := 5;
                end;
              end;
            end else
            if FKind = TCustomType.ComboBox then
            begin
              FCom := TComboBox.Create(IC);
              with FCom do
              begin
                Parent        := IC;
                Align         := TAlignLayout.Client;
                if Items.Count > 0 then
                  Items.Clear;
                Items.Assign(FComboSetting.FItems);
                FComboSetting.FCombo := FCom;
                OnClosePopup  := ClosePopup;
                with Margins Do
                begin
                  Left  := 5;
                  Right := 5;
                end;
              end;
            end else
            begin
              FTrack := TTrackBar.Create(IC);
              with FTrack do
              begin
                Parent  := IC;
                Align   := TAlignLayout.Top;
                with Margins Do
                begin
                  Left  := 5;
                  Right := 5;
                end;
              end;
            end;
          end;
        end else
        if FKind = TCustomType.Menu then
        begin
          FMenu := TListBox.Create(Lay);
          with FMenu do
          begin
            Parent := Lay;
            Align  := TAlignLayout.Client;
            ShowScrollBars := False;
            if Items.Count > 0 then
              Items.Clear;

            for I := 0 to FMenuSettings.FItems.Count -1 do
            begin
              Key := Items.Add(FMenuSettings.FItems[i].Text);
              {$REGION 'Ýleri versiyonlarda Aktif yap þuan erken'}
//              FMenu.ListItems[Key].ItemData.Bitmap.Assign(FMenuSettings.Item[i].ItemData.Bitmap);
              {$ENDREGION}
            end;

            OnItemClick := xItemClick;

            if Items.Count > 0 then
            begin
              for I := 0 to Items.Count -1 do
                ListItems[i].Height := 45;
                
              xCenter.height := 50 + (Items.Count * 45);

              if (BG.Height - (xCenter.Position.X + xCenter.Height))  < (xCenter.Position.X) then
              begin
                ShowScrollBars := True;
                xCenter.Height := BG.Height - xCenter.Position.X;
              end;
            end;
          end;
        end;
      end;
      {$ENDREGION}
    end;
  end;
end;

procedure TCustomDialogs.FClick(Sender: TObject);
begin
  Inherited;
  if FKind = TCustomType.Menu then
    if FMenuSettings.FItems.Count = 0 then
      Exit;
  if Parentx is TCustomEdit then
    (Parentx as TCustomEdit).ClearSelection;

  Execute;

  if FKind = TCustomType.Edit then
  begin
    if (FEdit is TTextControl) then
      FRes.Text := (FEdit as TTextControl).Text;
    FRes.SetFocus;
  end else
  if FKind = TCustomType.ComboBox then
  begin
    if FComboSetting.FItems.Count = 0 then
      raise EActionError.CreateFMT('Combobox items not found!', ['']);

    if FCom.Items.IndexOf((Parentx as TCustomEdit).Text) > 0 then
      FCom.ItemIndex := FCom.Items.IndexOf((Parentx as TCustomEdit).Text)
    else
      FCom.ItemIndex := -1;

    FCom.SetFocus;
  end else
  if FKind = TCustomType.TrackBar then
  begin
    FTrack.Value := FValue;
    FTrack.SetFocus;
  end;
  if FKind = TCustomType.Menu then
    FMenu.SetFocus ;
end;

procedure TCustomDialogs.FreeNil;
begin
  if Assigned(BG) then
    if BG.Visible then
      BG.Visible := False;

  if Assigned(xCenter) then
    if xCenter.Visible then
      xCenter.Visible := False;

  if FKind = TCustomType.ComboBox then
    if Assigned(FCom) then FCom.Free;

  if FKind = TCustomType.Edit then
    if Assigned(FRes) then FRes.Free;

  if FKind = TCustomType.TrackBar then
    if Assigned(FTrack) then FTrack.Free;

  TamamBut.Free;
  IptalBut.Free;

  IC.Free;
  Lay.Free;
  Bot.Free;
  xCenter.Free;
  BG.Free;
end;

function TCustomDialogs.GetColor: TAlphaColor;
begin
  Result := FColor;
end;

function TCustomDialogs.GetComboSet: TComboSettings;
begin
  Result := FComboSetting;
end;

function TCustomDialogs.GetComboSetting: TComboSettings;
begin
  Result := FComboSetting;
end;

function TCustomDialogs.GetEditSet: TEditSettings;
begin
  Result := FEditSettings;
end;

function TCustomDialogs.GetMenuSet: TMenuSettings;
begin
  Result := FMenuSettings;
end;

function TCustomDialogs.GetTrackSet: TTrackSettings;
begin
  Result := FTrackSetting;
end;

procedure TCustomDialogs.IptalClick(Sender: TObject);
begin
  ResultText := '';
  FreeNil;
end;

procedure TCustomDialogs.SetColor(const Value: TAlphaColor);
begin
  if FColor <> Value then
    FColor := Value;
end;

procedure TCustomDialogs.SetComboSet(const Value: TComboSettings);
begin
  if FComboSetting <> Value then
    FComboSetting := Value;
end;

procedure TCustomDialogs.SetComboSetting(const Value: TComboSettings);
begin
  if FComboSetting <> Value then
    FComboSetting := Value;
end;

procedure TCustomDialogs.SetComponent(const Value: TControl);
begin
  if Value <> nil then
    if Value <> FEdit then
    begin
      FEdit := Value;
      if (Parentx is TControl) then

      (Parentx as TControl).OnClick := FClick;
    end
  else
    FEdit := nil;
end;

procedure TCustomDialogs.SetEditSet(const Value: TEditSettings);
begin
  if FEditSettings <> Value then
    FEditSettings := Value;
end;

procedure TCustomDialogs.SetMenuSet(const Value: TMenuSettings);
begin
  if FMenuSettings <> Value then
    FMenuSettings := Value;
end;

procedure TCustomDialogs.SetTrackSet(const Value: TTrackSettings);
begin
  if FTrackSetting <> Value then
    FTrackSetting := Value;
end;

procedure TCustomDialogs.TamamClick(Sender: TObject);
begin
  BG.Visible     := False;
  xCenter.Visible := False;

  if FKind = TCustomType.Edit then
  begin
    if ResultText <> FRes.Text then
    begin
      ResultText := FRes.Text;
      if (FEdit is TTextControl) then
        (FEdit as TTextControl).Text := ResultText;
    end;
    if Assigned(OnPopUpClose) then
      FOnPopUpClose(FRes.Text, 1, 0);
  end;
  if FKind = TCustomType.ComboBox then
  begin
    if FCom.Selected <> nil then
    begin
      if ResultText <> FCom.Selected.Text then
      begin
        if FCom.ItemIndex <> -1 then
        begin
          ResultText := FCom.Selected.Text;
          if FComboSetting.ReturnText then
            if (FEdit is TTextControl) then
              (FEdit as TTextControl).Text := ResultText;
        end
      end;
      if Assigned(OnPopUpClose) then
        FOnPopUpClose(FCom.Selected.Text, FCom.ItemIndex, -1);
    end;
  end;

  if FKind = TCustomType.TrackBar then
  begin
    if FValue <> FTrack.Value then
      FValue := FTrack.Value;

    if FTrackSetting.ReturnText then
      if (FEdit is TTextControl) then
        (FEdit as TTextControl).Text := ResultText;
    if Assigned(OnPopUpClose) then
      FOnPopUpClose(FTrack.Value.ToString, -1, FTrack.Value);
  end;

  FreeNil;
end;

procedure TCustomDialogs.xItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  BG.Visible     := False;
  xCenter.Visible := False;

  if FKind = TCustomType.Menu then
  begin
    if FMenu.Selected <> nil then
      if FMenu.ItemIndex <> -1 then
      begin
        if FMenuSettings.ReturnText then
          if (FEdit is TTextControl) then
             (FEdit as TTextControl).Text := ResultText;
        ResultText := FMenu.Selected.Text;
      end;
    if Assigned(OnPopUpClose) then
        FOnPopUpClose(FMenu.Selected.Text, FMenu.ItemIndex, -1);
  end;
  
  FreeNil;
end;

{ TComboSettings }

procedure TComboSettings.Assign(Source: TPersistent);
var
  xItems: TStringList;
  xIndex: Integer;
begin
  if (Source is TComboSettings) and (not Assigned(Source)) then
  begin
    if Assigned(Source) then
    begin
      xItems.Assign(TComboSettings(Source).FItems);
      xIndex := TComboSettings(Source).FIndex;
    end else
    begin
      FItems.Assign(TComboSettings(Source).FItems);
      FIndex := TComboSettings(Source).FIndex;
    end;

    if (FItems <> xItems) or
       (FIndex <> xIndex) then
    begin
      FItems.Assign(xItems);
      FIndex := xIndex;
    end;
  end else
    inherited;
end;

constructor TComboSettings.Create;
begin
  FItems := TStringList.Create;
  FReturn := True;
end;

destructor TComboSettings.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TComboSettings.GetIndex: Integer;
begin
  if FCombo <> nil then
    Result := FCombo.ItemIndex
  else
    Result := -1;
end;

procedure TComboSettings.SetWrite(const Value: TStringList);
begin
  FItems.Assign(Value);
end;

{ TTrackSettings }

procedure TTrackSettings.Assign(Source: TPersistent);
var
  xValue,
  xMax,
  xMin: Single;
begin
  if (Source is TTrackSettings) and (not Assigned(Source)) then
  begin
    if Assigned(Source) then
    begin
      xValue :=(TTrackSettings(Source).FValue);
      xMax   :=(TTrackSettings(Source).FMax);
      xMin   :=(TTrackSettings(Source).FMin);
    end else
    begin
      FMin   := TTrackSettings(Source).FMin;
      FMax   := TTrackSettings(Source).FMax;
      FValue := TTrackSettings(Source).FValue;
    end;

    if (FMin <> FMin) or
       (FMax <> FMax) or
       (FValue <> FValue)  then
    begin
      FMin   := xMin;
      FMax   := xMax;
      FValue := xValue;
    end;
  end else
    inherited;
end;

constructor TTrackSettings.Create;
begin
  FReturn := True;
end;

destructor TTrackSettings.Destroy;
begin

  inherited;
end;

procedure TTrackSettings.SetWrite(const Value: Single);
begin
  if FValue <> Value then
    if Value > FMax then
      raise EActionError.CreateFMT('This value bigger from Maximum value', [''])
    else
      FValue := Value;
end;

{ TEditSettings }

procedure TEditSettings.Assign(Source: TPersistent);
var
  xText: String;
begin
  if (Source is TEditSettings) and (not Assigned(Source)) then
  begin
    if Assigned(Source) then
    begin
      xText :=(TEditSettings(Source).FText);
    end else
    begin
      FText   := TEditSettings(Source).FText;
    end;

    if (FText <> FText)  then
    begin
      FText := xText;
    end;
  end else
    inherited;
end;

constructor TEditSettings.Create;
begin
end;

destructor TEditSettings.Destroy;
begin
  inherited;
end;

{ TMenuSettings }

function TCustomDialogs.TMenuSettings.Add: TListBoxItem;
begin
  Result := TListBoxItem.Create(FOwner.FMenu);
  FItems.Add(Result);
end;

procedure TCustomDialogs.TMenuSettings.Assign(Source: TPersistent);
var  xIndex: Integer;
begin
  if (Source is TMenuSettings) and (not Assigned(Source)) then
  begin
    if Assigned(Source) then
    begin
//      xItems.Add(TMenuSettings(Source).FItems);
      xIndex := TComboSettings(Source).FIndex;
    end else
    begin
//      FItems.Add(TMenuSettings(Source).FItems);
      FIndex := TMenuSettings(Source).FIndex;
    end;

    if //(FItems <> xItems) or
       (FIndex <> xIndex) then
    begin
//      FItems.Add(xItems);
      FIndex := xIndex;
    end;
  end else
    inherited;
end;

constructor TCustomDialogs.TMenuSettings.Create(AOwner: TCustomDialogs);
begin
  FItems   := TObjectList<TListBoxItem>.Create;
  FReturn  := True;
  FOwner   := AOwner;
end;

destructor TCustomDialogs.TMenuSettings.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TCustomDialogs.TMenuSettings.GetItem(const Index: Integer): TListBoxItem;
begin
  Result := FItems.Items[Index];
end;

end.
