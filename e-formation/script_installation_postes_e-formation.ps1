# Lancer le script avec les droits administrateurs
##################################################
param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

'running with full privileges'

##################################################

# Installer les logiciels nécessaires
winget install Microsoft.WindowsTerminal
winget install Microsoft.PowerShell
winget install Mozilla.Firefox.ESR
winget install Google.Chrome
winget install TheDocumentFoundation.LibreOffice
winget install VideoLAN.VLC
winget install 7zip.7zip
winget install Adobe.Acrobat.Reader.64-bit

# Désinstaller les logiciels non nécessaires
winget uninstall Disney.37853FC22B2CE_6rarf9sa4v8jt
winget uninstall Microsoft.BingNews_8wekyb3d8bbwe
winget uninstall Microsoft.BingWeather_8wekyb3d8bbwe
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
# http://superuser.com/questions/666891/script-to-set-hide-file-extensions
Push-Location
Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
Set-ItemProperty . HideFileExt "0"
Pop-Location
Stop-Process -processName: Explorer -force # This will restart the Explorer service to make this work.

# Créer le dossier de configuration des paramètres d’entreprise de Firefox
mkdir 'C:\Program Files\Mozilla Firefox\distribution'

# Chiffre le disque C: avec BitLocker (se lancera au redémarrage, et nécessite que le TPM soit activé dans le BIOS avant de lancer la commande)
manage-bde -on C:

# Télécharger le script de maintenance hebdomadaire et le placer sur le bureau
Invoke-WebRequest -Uri https://raw.githubusercontent.com/at2f/config/main/e-formation/maintenance_manuelle_hebdomadaire.ps1 -OutFile "$env:USERPROFILE\Desktop\maintenance_manuelle_hebdomadaire.ps1"
