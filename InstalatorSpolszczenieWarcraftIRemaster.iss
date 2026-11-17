[Setup]
AppName=Warcraft I: Remastered - Spolszczenie
AppVersion=1.0
AppPublisher=Piopal
DefaultDirName={code:FindGameDir}
DisableDirPage=no
DisableProgramGroupPage=yes
OutputDir=userdocs:Inno Setup Examples Output
OutputBaseFilename=Warcraft_I_Remastered_Spolszczenie_v1.0
Compression=lzma2
SolidCompression=yes
DirExistsWarning=no
UninstallFilesDir={app}\_spolszczenie_deinstalator

[Languages]
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"

[Messages]
ConfirmUninstall=Czy na pewno chcesz usunąć program %1?%n%nPo deinstalacji powróci zastąpiona oryginalna angielska wersja językowa gry.

[Files]
Source: "C:\Users\elkro\Desktop\Spolszczenie Warcraft I Remastered\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{app}\Usunięcie spolszczenia"; Filename: "{uninstallexe}"

[Code]
var
  ScanButton: TNewButton;

function CheckGameExe(Dir: String): Boolean;
begin
  Result := FileExists(AddBackslash(Dir) + 'Warcraft.exe');
end;

function ScanDrivesForGame(): String;
var
  DriveCode: Integer;
  RootPath, Candidate: String;
  SubFolders: TArrayOfString;
  I: Integer;
begin
  Result := '';
  SetArrayLength(SubFolders, 6);
  SubFolders[0] := 'Warcraft I Remastered';
  SubFolders[1] := 'Program Files (x86)\Warcraft I Remastered';
  SubFolders[2] := 'Program Files\Warcraft I Remastered';
  SubFolders[3] := 'Games\Warcraft I Remastered';
  SubFolders[4] := 'Gry\Warcraft I Remastered';
  SubFolders[5] := 'Battle.net\Warcraft I Remastered';

  for DriveCode := Ord('C') to Ord('Z') do
  begin
    RootPath := Chr(DriveCode) + ':\';
    if DirExists(RootPath) then
    begin
      for I := 0 to GetArrayLength(SubFolders) - 1 do
      begin
        Candidate := RootPath + SubFolders[I];
        if CheckGameExe(Candidate) then
        begin
          Result := Candidate;
          Exit;
        end;
      end;
    end;
  end;
end;

function FindGameDir(Param: String): String;
var
  InstallPath: String;
begin
  if RegQueryStringValue(HKLM64, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Warcraft I Remastered', 'InstallLocation', InstallPath) and CheckGameExe(InstallPath) then
    Result := InstallPath
  else if RegQueryStringValue(HKLM32, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Warcraft I Remastered', 'InstallLocation', InstallPath) and CheckGameExe(InstallPath) then
    Result := InstallPath
  else
  begin
    Result := ScanDrivesForGame();
    if Result = '' then
      Result := ExpandConstant('{commonpf32}\Warcraft I Remastered');
  end;
end;

procedure ScanButtonClick(Sender: TObject);
var
  FoundPath: String;
begin
  ScanButton.Enabled := False;
  ScanButton.Caption := 'Szukam...';
  try
    FoundPath := ScanDrivesForGame();
    if FoundPath <> '' then
    begin
      WizardForm.DirEdit.Text := FoundPath;
      MsgBox('Znaleziono folder z grą:' + #13#10 + FoundPath, mbInformation, MB_OK);
    end
    else
      MsgBox('Nie znaleziono pliku Warcraft.exe w standardowych folderach. Wskaż katalog ręcznie przyciskiem Przeglądaj.', mbError, MB_OK);
  finally
    ScanButton.Caption := 'Skanuj dyski';
    ScanButton.Enabled := True;
  end;
end;

procedure InitializeWizard();
begin
  ScanButton := TNewButton.Create(WizardForm);
  ScanButton.Parent := WizardForm.SelectDirPage;
  ScanButton.Width := WizardForm.DirBrowseButton.Width + ScaleX(25);
  ScanButton.Left := WizardForm.DirBrowseButton.Left - ScaleX(25);
  ScanButton.Top := WizardForm.DirBrowseButton.Top + WizardForm.DirBrowseButton.Height + ScaleY(8);
  ScanButton.Height := WizardForm.DirBrowseButton.Height;
  ScanButton.Caption := 'Skanuj dyski';
  ScanButton.OnClick := @ScanButtonClick;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
var
  SelectedDir: String;
begin
  Result := True;
  if CurPageID = wpSelectDir then
  begin
    SelectedDir := WizardForm.DirEdit.Text;
    if not CheckGameExe(SelectedDir) then
    begin
      MsgBox('W wybranym folderze nie znaleziono pliku Warcraft.exe.' + #13#10 + 'Wskaż główny katalog gry Warcraft I: Remastered.', mbError, MB_OK);
      Result := False;
      Exit;
    end;

    if FileExists(AddBackslash(SelectedDir) + 'data\strings\enUS.json.bak') then
    begin
      if MsgBox('Spolszczenie zostało już zainstalowane w tej lokalizacji.' + #13#10 + 'Czy chcesz zainstalować je ponownie?', mbConfirmation, MB_YESNO) = IDNO then
        Result := False;
    end;
  end;
end;

procedure BackupOriginalFile(FilePath: String);
begin
  if FileExists(FilePath) and not FileExists(FilePath + '.bak') then
    CopyFile(FilePath, FilePath + '.bak', False);
end;

procedure RestoreOriginalFile(FilePath: String);
begin
  if FileExists(FilePath + '.bak') then
  begin
    DeleteFile(FilePath);
    RenameFile(FilePath + '.bak', FilePath);
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  AppDir: String;
begin
  if CurStep = ssInstall then
  begin
    AppDir := ExpandConstant('{app}');
    BackupOriginalFile(AppDir + '\data\fonts\BLQ55.ttf');
    BackupOriginalFile(AppDir + '\data\fonts\NotoSans-Regular.ttf');
    BackupOriginalFile(AppDir + '\data\strings\enUS.json');
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  AppDir: String;
begin
  if CurUninstallStep = usPostUninstall then
  begin
    AppDir := ExpandConstant('{app}');
    RestoreOriginalFile(AppDir + '\data\fonts\BLQ55.ttf');
    RestoreOriginalFile(AppDir + '\data\fonts\NotoSans-Regular.ttf');
    RestoreOriginalFile(AppDir + '\data\strings\enUS.json');
  end;
end;