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
