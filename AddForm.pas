unit AddForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    NameEdit: TEdit;
    SerEdit: TEdit;
    FIOEdit: TEdit;
    StreetEdit: TEdit;
    HouseEdit: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
   uses MainForm,Uinfo;
{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var info: TInfo;
begin
  info.key.number:=StrToInt(NameEdit.Text);
  info.key.series:=StrToInt(SerEdit.Text);
  info.FIO:= FIOEdit.Text;
  info.adress.street:= StreetEdit.Text;
  info.adress.house:= StrToInt(HouseEdit.Text);
  HashTable.Add(info);
  NameEdit.Text:='';
  SerEdit.Text:='';
  FIOEdit.Text:='';
  StreetEdit.Text:='';
  HouseEdit.Text:='';
  Form1.HashMemo.Lines.Clear;
  HashTable.View(Form1.HashMemo.Lines);
  Form2.Close;
end;

end.
