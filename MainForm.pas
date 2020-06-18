unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, UInfo, UHashTableGUI, Menus,
  Actions, ActnList, StdCtrls, ToolWin, ComCtrls, ImageList, ImgList, AddForm, FindForm, DelForm, ExtCtrls;

type
  TForm1 = class(TForm)

    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    Af1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    HashMemo: TMemo;
    FindMemo: TMemo;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    OpenDialog: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ImageList1: TImageList;
    NewFileAction: TAction;
    SaveFileAction: TAction;
    OpenFileAction: TAction;
    AddAction: TAction;
    DeleteAction: TAction;
    ClearAction: TAction;
    FindAction: TAction;
    ExitAction: TAction;
    Splitter1: TSplitter;
    procedure NewFileActionExecute(Sender: TObject);
    procedure OpenFileActionExecute(Sender: TObject);
    procedure SaveFileActionExecute(Sender: TObject);
    procedure ClearActionExecute(Sender: TObject);
    procedure ExitActionExecute(Sender: TObject);
    procedure AddActionExecute(Sender: TObject);
    procedure FindActionExecute(Sender: TObject);
    procedure DeleteActionExecute(Sender: TObject);
    procedure IdleEventHandler(Sender: TObject; var Done: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  Form1: TForm1;
  HashTable : THashTableGUI;

implementation

{$R *.dfm}

procedure TForm1.NewFileActionExecute(Sender: TObject);
var i : integer;
begin
  if HashTable.CanClose(i) then
    if i<>IDCANCEL then
      if i=IDYES then
        SaveFileAction.Execute;
  ClearAction.Execute;
  saveDialog1.FileName:='';
end;

procedure TForm1.OpenFileActionExecute(Sender: TObject);
var i : integer;
begin
  if HashTable.CanClose(i) then
    begin
      if i<>IDCANCEL then
        begin
          if i=IDYES then
            SaveFileAction.Execute;
          ClearAction.Execute;
          OpenDialog.Execute;
          HashTable.LoadFromFile(OpenDialog.FileName);
          HashTable.View(HashMemo.Lines);
          saveDialog1.FileName:= OpenDialog.FileName;
        end;
    end
  else
    begin
      ClearAction.Execute;
      OpenDialog.Execute;
      saveDialog1.FileName:= OpenDialog.FileName;
      HashTable.LoadFromFile(OpenDialog.FileName);
      HashTable.View(HashMemo.Lines);
    end;
end;

procedure TForm1.SaveFileActionExecute(Sender: TObject);
begin
  if saveDialog1.FileName='' then
    saveDialog1.Execute;
  HashTable.SaveToFile(saveDialog1.FileName);
end;

procedure TForm1.AddActionExecute(Sender: TObject);
begin
   Form2.Show;
end;

procedure TForm1.DeleteActionExecute(Sender: TObject);
begin
  Form4.Show;
end;

procedure TForm1.ClearActionExecute(Sender: TObject);
begin
  HashTable.Clear;
  HashMemo.Clear;
  FindMemo.Clear;
end;

procedure TForm1.FindActionExecute(Sender: TObject);
begin
  Form3.Show;
end;

procedure TForm1.ExitActionExecute(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var i : integer;
begin
  if HashTable.CanClose(i) then
    if i=IDCANCEL then
      CanClose:=false
    else
      if i=IDYES then
        begin
          SaveFileAction.Execute;
          ClearAction.Execute;
        end
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.HintPause := 2000;
  Application.OnIdle := IdleEventHandler;
end;

procedure TForm1.IdleEventHandler(Sender: TObject;var Done: Boolean);
begin
  if HashTable.Modified then
    SaveFileAction.Enabled:=true
  else
    SaveFileAction.Enabled:=false;
  if HashTable.IsEmpty then
    begin
      ClearAction.Enabled:=false;
      DeleteAction.Enabled:=false;
    end
  else
    begin
      ClearAction.Enabled:=true;
      DeleteAction.Enabled:=true;
    end;
end;

initialization
  HashTable:= THashTableGUI.Create;
finalization
  HashTable.Free;
end.
