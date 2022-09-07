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

'Privilèges administrateurs accordés.'

##################################################

# Télécharger et exécuter le script de corrections
'Téléchargement et exécution du script de corrections.'
Invoke-WebRequest -Uri https://raw.githubusercontent.com/at2f/config/main/e-formation/divers/corrections.ps1 -OutFile "$env:TEMP\corrections.ps1"
cd "$env:TEMP"
.\corrections.ps1
'Script de corrections terminé.'

winget upgrade --all

# Télécharger les paramètres d’entreprise de Mozilla Firefox
Invoke-WebRequest -Uri https://raw.githubusercontent.com/at2f/config/main/e-formation/firefox/policies.json -OutFile 'C:\Program Files\Mozilla Firefox\distribution\policies.json'

# Télécharger les paramètres d’entreprise de Google Chrome & appliquer les changements au registre
Invoke-WebRequest -Uri https://raw.githubusercontent.com/at2f/config/main/e-formation/chrome/policies_chrome.reg -OutFile "$env:TEMP\policies_chrome.reg"
reg import "$env:TEMP\policies_chrome.reg"

# Télécharger les paramètres d’entreprise de Microsoft Edge & appliquer les changements au registre
Invoke-WebRequest -Uri https://raw.githubusercontent.com/at2f/config/main/e-formation/edge/policies_edge.reg -OutFile "$env:TEMP\policies_edge.reg"
reg import "$env:TEMP\policies_edge.reg"
