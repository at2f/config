winget upgrade --all

# Télécharger les paramètres d’entreprise de Mozilla Firefox
Invoke-WebRequest -Uri https://raw.githubusercontent.com/at2f/config/main/e-formation/firefox/policies.json -OutFile 'C:\Program Files\Mozilla Firefox\distribution\policies.json'

# Télécharger les paramètres d’entreprise de Google Chrome & appliquer les changements au registre
Invoke-WebRequest -Uri https://raw.githubusercontent.com/at2f/config/main/e-formation/chrome/policies_chrome.reg -OutFile "$env:TEMP\policies_chrome.reg"
reg import "$env:TEMP\policies_chrome.reg"

# Télécharger les paramètres d’entreprise de Microsoft Edge & appliquer les changements au registre
Invoke-WebRequest -Uri https://raw.githubusercontent.com/at2f/config/main/e-formation/edge/policies_edge.reg -OutFile "$env:TEMP\policies_edge.reg"
reg import "$env:TEMP\policies_edge.reg"
