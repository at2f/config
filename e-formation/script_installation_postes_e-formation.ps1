# Installer les logiciels nécessaires
winget install Microsoft.WindowsTerminal
winget install Microsoft.PowerShell
winget install Mozilla.Firefox.ESR
winget install TheDocumentFoundation.LibreOffice
winget install VideoLAN.VLC
winget install 7zip.7zip
winget install Adobe.Acrobat.Reader.64-bit

# Désinstaller les logiciels non nécessaires
winget uninstall Disney.37853FC22B2CE_6rarf9sa4v8jt
winget uninstall Microsoft.BingNews_8wekyb3d8bbwe
winget uninstall Microsoft.BingWeather_8wekyb3d8bbwe
winget uninstall Microsoft.Edge
winget uninstall Microsoft.549981C3F5F10_8wekyb3d8bbwe
winget uninstall Microsoft.GamingApp_8wekyb3d8bbwe
winget uninstall Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe
winget uninstall Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe
winget uninstall Microsoft.OneDriveSync_8wekyb3d8bbwe
winget uninstall Microsoft.People_8wekyb3d8bbwe
winget uninstall Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe
winget uninstall Microsoft.Xbox.TCUI_8wekyb3d8bbwe
winget uninstall Microsoft.XboxGameOverlay_8wekyb3d8bbwe
winget uninstall Microsoft.XboxGamingOverlay_8wekyb3d8bbwe
winget uninstall Microsoft.XboxIdentityProvider_8wekyb3d8bbwe
winget uninstall Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe
winget uninstall Microsoft.ZuneMusic_8wekyb3d8bbwe
winget uninstall Microsoft.ZuneVideo_8wekyb3d8bbwe
winget uninstall Microsoft.OneDrive
winget uninstall SpotifyAB.SpotifyMusic_zpdnekdrzrea0

# Afficher les extensions de fichiers
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFilesExt /t REG_DWORD /d 0 /f

# Créer le dossier de configuration des paramètres d’entreprise de Firefox
mkdir 'C:\Program Files\Mozilla Firefox\distribution'
