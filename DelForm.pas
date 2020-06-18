unit DelForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FindForm;

type
  TForm4 = class(TForm3)
  procedure PeformBtnClick(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation
   uses MainForm, UInfo;
{$R *.dfm}

  procedure TForm4.PeformBtnClick(Sender: TObject);
  var key:Tkey;
  begin
    key.number:= StrToInt(NumEdit.Text);
    key.series:= StrToInt(SerEdit.Text);
    if HashTable.Delete(key) then
    begin
      ShowMessage('Запись удалена');
      Form1.HashMemo.Lines.Clear;
      HashTable.View(Form1.HashMemo.Lines);
    end
    else
      ShowMessage('Такой записи не существует');
    Form4.Close;
  end;
procedure TForm4.FormCreate(Sender: TObject);
begin
  inherited;
  PeformBtn.Caption:='Удалить';
  Caption:='Удалить запись';
end;

end.
