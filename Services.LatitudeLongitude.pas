unit Services.LatitudeLongitude;

interface

uses
  System.SysUtils,
  System.Classes,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL,
  Data.DBXJSON

   ;

Const
  Key = '&key=AIzaSyBOZZc1jM2eJvesWXuM-8e7jSAWXRWCLZ0';

type
   TServicesLatitudeLongitude = class
   private

      FLatitude : double;
      FLongitude : Double;

      procedure LeDados(AJSON: String);

   public

      Constructor Create;
      Destructor Destroy; override;

      property Latitude : Double read FLatitude write FLatitude;
      property Longitude : Double read FLongitude write FLongitude;

      function GetDados( AEndereco : String) : String;



 end;


implementation




function TServicesLatitudeLongitude.GetDados( AEndereco : String) : String;
var URL : String;
   JsonStreamEnvio : TStringStream;
   oHTTP: TIdHTTP;
   oIdSSLIOHandlerSocketOpenSSL : TIdSSLIOHandlerSocketOpenSSL;


begin

   FLatitude := 0;
   FLongitude := 0;

   Result := '';
   URL := 'https://maps.googleapis.com/maps/api/geocode/json?address='+TrimRight(AEndereco)+Key;

   oHTTP := TIdHTTP.Create(nil);
   oIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

   JsonStreamEnvio:= TStringStream.Create('');

   try
       oHTTP.Request.Clear;
       oHTTP.Request.ContentType := 'application/json';
       oHTTP.Request.Charset := 'UTF-8';
       oHTTP.IOHandler := oIdSSLIOHandlerSocketOpenSSL;

        // Set username and password:
       oHTTP.Request.Clear;
       oHTTP.Request.BasicAuthentication := False;
       oHTTP.Request.Username := 'usuario';
       oHTTP.Request.password := 'senha';

       url := StringReplace(url,' ','%20',[rfReplaceAll]);
       oHTTP.Get(URL, JsonStreamEnvio);
       JsonStreamEnvio.Position := 0;

       //result :=  UTF8Decode( JsonStreamEnvio.DataString );
       result :=   JsonStreamEnvio.DataString ;


       LeDados( Result );

    finally

       JsonStreamEnvio.Free();

       oIdSSLIOHandlerSocketOpenSSL.Free;
       oHTTP.Free;


    end;

end;





constructor TServicesLatitudeLongitude.Create;
begin
  FormatSettings.DecimalSeparator := '.';
end;

destructor TServicesLatitudeLongitude.Destroy;
begin

end;

procedure TServicesLatitudeLongitude.LeDados( AJSON : String);
var
  LJSONObject, JSubObj, JSubObj1, JSubObj2 : TJSONObject;
  i, j, j1, j2 : integer;
  jSubPar  : TJSONPair;
  JSONArray : TJSONArray;


begin

   //  obtendo valores
   LJSONObject := nil;

   try

      LJSONObject := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes( AJSON ), 0) as TJSONObject;


      jSubPar  := LJSONObject.Get(0); //pega o par zero

      JSONArray := (jSubPar.JsonValue as TJSONArray); // do par zero pega o valor, que é array

      for i := 0 to JSONArray.Size - 1 do
      begin

        jSubObj := (JSONArray.Get(i) as TJSONObject); //pega cada elemento do array, onde cada
        for j := 0 to JSubObj.Size-1 do
        begin
           if JSubObj.Get(j).JsonString.Value = 'geometry' then
           begin

             JSubObj1 := TJSONObject(  JSubObj.Get(j).JsonValue );
             for j1 := 0 to JSubObj1.Size-1 do
             begin
                if JSubObj1.Get(j1).JsonString.Value = 'location' then
                begin
                  JSubObj2 := TJSONObject(  JSubObj1.Get(j1).JsonValue );
                  for j2 := 0 to JSubObj2.Size-1 do
                  begin
                     if JSubObj2.Get(j2).JsonString.Value = 'lat' then
                        FLatitude  := StrToFloat( JSubObj2.Get(j2).JsonValue.ToString );
                     if JSubObj2.Get(j2).JsonString.Value = 'lng' then
                        FLongitude  := StrToFloat( JSubObj2.Get(j2).JsonValue.ToString );
                  end;

                end;
             end;

           end;
        end;

      end;

   finally
      LJSONObject.Free;

   end;
end;



end.
