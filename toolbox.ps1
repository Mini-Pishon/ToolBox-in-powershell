# Créer le formulaire principal
$formMain = New-Object System.Windows.Forms.Form
$formMain.Text = "Boîte à Outils"  # Définir le titre de la fenêtre
$formMain.Size = New-Object System.Drawing.Size(450, 700)  # Définir la taille de la fenêtre

# Créer une étiquette pour le titre "Boîte à Outils" et la centrer
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Text = "Boîte à Outils"  # Texte de l'étiquette
$labelTitle.Font = New-Object System.Drawing.Font("Arial", 21, [System.Drawing.FontStyle]::Bold)  # Police et style du texte
$labelTitle.Size = New-Object System.Drawing.Size(200, 30)  # Taille de l'étiquette
$labelTitle.Location = New-Object System.Drawing.Point([int](($formMain.ClientSize.Width - $labelTitle.Width) / 2), 20)  # Position centrée

$formMain.Controls.Add($labelTitle)  # Ajouter l'étiquette au formulaire

# ---- Catégorie : Outils ----
# Créer le GroupBox sans titre
$groupOutils = New-Object System.Windows.Forms.GroupBox
$groupOutils.Text = ""  # Pas de texte pour le titre du GroupBox
$groupOutils.Size = New-Object System.Drawing.Size(350, 150)  # Taille du GroupBox
$groupOutils.Location = New-Object System.Drawing.Point(50, 80)  # Position du GroupBox

# Ajouter le GroupBox au formulaire
$formMain.Controls.Add($groupOutils)

# Dessiner manuellement le titre en dehors du GroupBox
$titleLabelOutils = New-Object System.Windows.Forms.Label
$titleLabelOutils.Text = "Outils"  # Texte du titre
$titleLabelOutils.Font = New-Object System.Drawing.Font("Arial", 13, [System.Drawing.FontStyle]::Bold)  # Police plus grande pour le titre
$titleLabelOutils.Location = New-Object System.Drawing.Point(50, 50)  # Positionner au-dessus du GroupBox
$titleLabelOutils.Size = New-Object System.Drawing.Size(350, 30)  # Taille adaptée au titre
$titleLabelOutils.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter  # Centrer le texte
$formMain.Controls.Add($titleLabelOutils)  # Ajouter le titre au formulaire

# Ouvrir le Centre d'administration Exchange en mode incognito
$linkExchange = New-Object System.Windows.Forms.Label
$linkExchange.Text = "Admin Exchange"  # Texte du lien
$linkExchange.ForeColor = [System.Drawing.Color]::Blue  # Couleur du texte
$linkExchange.Location = New-Object System.Drawing.Point(20, 30)  # Position du lien
$linkExchange.Size = New-Object System.Drawing.Size(100, 15)  # Taille du lien
$linkExchange.Cursor = [System.Windows.Forms.Cursors]::Hand  # Curseur en forme de main
# Définir l'événement de clic pour $linkExchange
$linkExchange.Add_Click({
    # Ouvrir le Centre d'administration Exchange en mode incognito
    $chromePath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"  # Chemin vers Chrome
    if (Test-Path $chromePath) {
        Start-Process $chromePath -ArgumentList "--incognito https://admin.exchange.microsoft.com/#/"  # Ouvrir en mode incognito
    } else {
        Write-Output "Google Chrome n'est pas installé au chemin spécifié."  # Message d'erreur
    }
})

# Ajouter le contrôle au GroupBox
$groupOutils.Controls.Add($linkExchange)

# Ouvrir l'interface utilisateur LAPS
$linkLAPS = New-Object System.Windows.Forms.Label
$linkLAPS.Text = "LAPS UI"  # Texte du lien
$linkLAPS.ForeColor = [System.Drawing.Color]::Blue  # Couleur du texte
$linkLAPS.Location = New-Object System.Drawing.Point(20, 60)  # Position du lien
$linkLAPS.Size = New-Object System.Drawing.Size(100, 15)  # Taille du lien
$linkLAPS.Cursor = [System.Windows.Forms.Cursors]::Hand  # Curseur en forme de main
# Définir l'événement de clic pour $linkLAPS
$linkLAPS.Add_Click({
    $LAPSpath = "C:\Program Files\LAPS\AdmPwd.UI.exe"  # Chemin vers LAPS UI
    if (Test-Path $LAPSpath) {
        Start-Process $LAPSpath -Verb RunAs  # Exécuter en tant qu'administrateur
    } else {
        Write-Output "LAPS UI n'est pas installé au chemin spécifié"  # Message d'erreur
    }
})
$groupOutils.Controls.Add($linkLAPS)

# Ouvrir une connexion RDP vers Bastion
$linkBastion = New-Object System.Windows.Forms.Label
$linkBastion.Text = "Bastion"  # Texte du lien
$linkBastion.ForeColor = [System.Drawing.Color]::Blue  # Couleur du texte
$linkBastion.Location = New-Object System.Drawing.Point(230, 60)  # Position du lien
$linkBastion.Size = New-Object System.Drawing.Size(100, 15)  # Taille du lien
$linkBastion.Cursor = [System.Windows.Forms.Cursors]::Hand  # Curseur en forme de main
# Définir l'événement de clic pour $linkBastion
$linkBastion.Add_Click({
    Start-Process "C:\Windows\system32\mstsc.exe" -ArgumentList "/v:"  # Lancer la connexion RDP
})

$groupOutils.Controls.Add($linkBastion)

$linkAD = New-Object System.Windows.Forms.Label
$linkAD.Text = "Active Directory"  # Texte du lien
$linkAD.ForeColor = [System.Drawing.Color]::Blue  # Couleur du texte
$linkAD.Location = New-Object System.Drawing.Point(230, 30)  # Position du lien
$linkAD.Size = New-Object System.Drawing.Size(100, 15)  # Taille du lien
$linkAD.Cursor = [System.Windows.Forms.Cursors]::Hand  # Curseur en forme de main
# Définir l'événement de clic pour $linkAD
$linkAD.Add_Click({
    $ADPath = "C:\Windows\system32\dsa.msc"  # Chemin vers l'outil Active Directory
    if (Test-Path $ADPath) {
        Start-Process $ADPath -Verb Runas  # Exécuter en tant qu'administrateur
    } else {
        Write-Output "L'outil Active Directory n'est pas installé au chemin spécifié"  # Message d'erreur
    }
})
$groupOutils.Controls.Add($linkAD)

# Créer une nouvelle étiquette pour Gestion de Parc
$linkGDP = New-Object System.Windows.Forms.Label
$linkGDP.Text = "Gestion de Parc"  # Texte du lien
$linkGDP.ForeColor = [System.Drawing.Color]::Blue  # Couleur du texte
$linkGDP.Location = New-Object System.Drawing.Point(20, 90)  # Position du lien
$linkGDP.Size = New-Object System.Drawing.Size(100, 15)  # Taille du lien
$linkGDP.Cursor = [System.Windows.Forms.Cursors]::Hand  # Curseur en forme de main

# Définir l'événement de clic pour $linkGDP
$linkGDP.Add_Click({
    $GDPPath = ".xlsx"  # Lien vers le fichier Excel
    Start-Process "ms-excel:ofe|u|$GDPPath"  # Ouvrir le fichier Excel
})
$groupOutils.Controls.Add($linkGDP)

# Créer une nouvelle étiquette pour RunDeck
$linkRD = New-Object System.Windows.Forms.Label
$linkRD.Text = "RunDeck"  # Texte du lien
$linkRD.ForeColor = [System.Drawing.Color]::Blue  # Couleur du texte
$linkRD.Location = New-Object System.Drawing.Point(230, 90)  # Position du lien
$linkRD.Size = New-Object System.Drawing.Size(100, 15)  # Taille du lien
$linkRD.Cursor = [System.Windows.Forms.Cursors]::Hand  # Curseur en forme de main

# Définir l'événement de clic pour $linkRD
$linkRD.Add_Click({
    $chromePath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"  # Chemin vers Chrome
    if (Test-Path $chromePath) {
        Start-Process $chromePath ""  # Ouvrir RunDeck
    } else {
        Write-Output "Google Chrome n'est pas installé au chemin spécifié."  # Message d'erreur
    }
})

$groupOutils.Controls.Add($linkRD)

# ---- Catégorie : Docs ----
# Créer le GroupBox pour la catégorie Docs
$groupDocs = New-Object System.Windows.Forms.GroupBox
$groupDocs.Text = ""  # Pas de texte pour le titre du GroupBox
$groupDocs.Size = New-Object System.Drawing.Size(350, 150)  # Taille du GroupBox
$groupDocs.Location = New-Object System.Drawing.Point(50, 270)  # Position du GroupBox
$formMain.Controls.Add($groupDocs)

# Dessiner manuellement le titre pour Docs en dehors du GroupBox
$titleLabelDocs = New-Object System.Windows.Forms.Label
$titleLabelDocs.Text = "Docs"  # Texte du titre
$titleLabelDocs.Font = New-Object System.Drawing.Font("Arial", 13, [System.Drawing.FontStyle]::Bold)  # Police et style du texte
$titleLabelDocs.Location = New-Object System.Drawing.Point(50, 240)  # Positionner au-dessus du GroupBox
$titleLabelDocs.Size = New-Object System.Drawing.Size(350, 15)  # Taille adaptée au titre
$titleLabelDocs.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter  # Centrer le texte
$formMain.Controls.Add($titleLabelDocs)  # Ajouter le titre au formulaire

# Liens de documentation à l'intérieur du GroupBox
$linkDoc1 = New-Object System.Windows.Forms.Label
$linkDoc1.Text = "Documentation Confluence"  # Texte du lien
$linkDoc1.ForeColor = [System.Drawing.Color]::Blue  # Couleur du texte
$linkDoc1.Location = New-Object System.Drawing.Point(20, 30)  # Position du lien
$linkDoc1.Size = New-Object System.Drawing.Size(150, 15)  # Taille du lien
$linkDoc1.Cursor = [System.Windows.Forms.Cursors]::Hand  # Curseur en forme de main
$linkDoc1.Add_Click({
    # Ouvrir un lien de documentation (exemple)
    Start-Process "chrome.exe" "https://confluence.is.relyens.net/"  # Ouvrir le lien dans Chrome
})
$groupDocs.Controls.Add($linkDoc1)

$linkDoc2 = New-Object System.Windows.Forms.Label
$linkDoc2.Text = "Documentation Fresh Service"  # Texte du lien
$linkDoc2.ForeColor = [System.Drawing.Color]::Blue  # Couleur du texte
$linkDoc2.Location = New-Object System.Drawing.Point(20, 60)  # Position du lien
$linkDoc2.Size = New-Object System.Drawing.Size(180, 15)  # Taille du lien
$linkDoc2.Cursor = [System.Windows.Forms.Cursors]::Hand  # Curseur en forme de main
$linkDoc2.Add_Click({
    # Ouvrir un autre lien de documentation (exemple)
    Start-Process "chrome.exe" ""  # Ouvrir le lien dans Chrome
})
$groupDocs.Controls.Add($linkDoc2)

$linkDoc3 = New-Object System.Windows.Forms.Label
$linkDoc3.Text = "Documentation DEX"  # Texte du lien
$linkDoc3.ForeColor = [System.Drawing.Color]::Blue  # Couleur du texte
$linkDoc3.Location = New-Object System.Drawing.Point(20, 90)  # Position du lien
$linkDoc3.Size = New-Object System.Drawing.Size(150, 15)  # Taille du lien
$linkDoc3.Cursor = [System.Windows.Forms.Cursors]::Hand  # Curseur en forme de main
$linkDoc3.Add_Click({
    # Ouvrir l'Explorateur avec DEX
    Start-Process "explorer.exe" "\\"  # Ouvrir le chemin réseau
})
$groupDocs.Controls.Add($linkDoc3)

# ---- Catégorie : Scripts ----
# Créer le GroupBox pour la catégorie Scripts
$groupScripts = New-Object System.Windows.Forms.GroupBox
$groupScripts.Text = ""  # Pas de texte pour le titre du GroupBox
$groupScripts.Size = New-Object System.Drawing.Size(350, 150)  # Taille du GroupBox
$groupScripts.Location = New-Object System.Drawing.Point(50, 460)  # Position du GroupBox
$formMain.Controls.Add($groupScripts)

# Dessiner manuellement le titre pour Scripts en dehors du GroupBox
$titleLabelScripts = New-Object System.Windows.Forms.Label
$titleLabelScripts.Text = "Scripts"  # Texte du titre
$titleLabelScripts.Font = New-Object System.Drawing.Font("Arial", 13, [System.Drawing.FontStyle]::Bold)  # Police et style du texte
$titleLabelScripts.Location = New-Object System.Drawing.Point(50, 430)  # Positionner au-dessus du GroupBox
$titleLabelScripts.Size = New-Object System.Drawing.Size(350, 15)  # Taille adaptée au titre
$titleLabelScripts.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter  # Centrer le texte
$formMain.Controls.Add($titleLabelScripts)  # Ajouter le titre au formulaire

$linkScriptAD = New-Object System.Windows.Forms.Label
$linkScriptAD.Text = "Comparer des groupes Active Directory"  # Texte du lien
$linkScriptAD.ForeColor = [System.Drawing.Color]::Blue  # Couleur du texte
$linkScriptAD.Location = New-Object System.Drawing.Point(20, 30)  # Position du lien
$linkScriptAD.Size = New-Object System.Drawing.Size(230, 15)  # Taille du lien
$linkScriptAD.Cursor = [System.Windows.Forms.Cursors]::Hand  # Curseur en forme de main
$linkScriptAD.Add_Click({
    # Exécuter le script de comparaison des droits AD avec des privilèges élevés
    Start-Process powershell.exe -ArgumentList "-WindowStyle hidden -File `"\\.ps1`"" -Verb Runas -WindowStyle hidden  # Exécuter le script PowerShell
})
$groupScripts.Controls.Add($linkScriptAD)

$linkADGroups = New-Object System.Windows.Forms.Label
$linkADGroups.Text = "Rechercher de groupe(s) Active Directory"  # Texte du lien
$linkADGroups.ForeColor = [System.Drawing.Color]::Blue  # Couleur du texte
$linkADGroups.Location = New-Object System.Drawing.Point(20, 60)  # Position du lien
$linkADGroups.Size = New-Object System.Drawing.Size(230, 15)  # Taille du lien
$linkADGroups.Cursor = [System.Windows.Forms.Cursors]::Hand  # Curseur en forme de main
$linkADGroups.Add_Click({
    # Exécuter le script ACL share avec des privilèges élevés
    Start-Process powershell.exe -ArgumentList "-NoExit -File `"\\.ps1`"" -Verb Runas  # Exécuter le script PowerShell
})
$groupScripts.Controls.Add($linkADGroups)

# Afficher le formulaire
$formMain.ShowDialog()  # Afficher la fenêtre
