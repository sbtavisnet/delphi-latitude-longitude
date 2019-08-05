unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses Services.LatitudeLongitude;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var AEndereco : String;
    FServices : TServicesLatitudeLongitude;
begin
  AEndereco := Memo1.Text;
//  A1 := 'https://maps.googleapis.com/maps/api/geocode/json?address='+TrimRight(AEndereco)+'&key=AIzaSyBOZZc1jM2eJvesWXuM-8e7jSAWXRWCLZ0';

  FServices := TServicesLatitudeLongitude.Create ;

  Memo2.Lines.Text := FServices.GetDados( AEndereco );
  Memo2.Lines.add('');
  Memo2.Lines.add('');
  Memo2.Lines.add('');
  Memo2.Lines.add('');
  Memo2.Lines.add('Latitude: '+FloatToStr( FServices.Latitude ));
  Memo2.Lines.Add('Longitude: '+FloatToStr( FServices.Longitude ));


  FreeAndNil( FServices);



//   'https://maps.googleapis.com/maps/api/geocode/json?address=Rua Marechal Floriano 654,+Centro,+Governador Valadares,+MG&key=AIzaSyBOZZc1jM2eJvesWXuM-8e7jSAWXRWCLZ0'
end;

end.
