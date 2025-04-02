# Create the main form
$formMain = New-Object System.Windows.Forms.Form
$formMain.Text = "Tools Dashboard"
$formMain.Size = New-Object System.Drawing.Size(450, 700)

# Create a Label for the title "Tools Dashboard" and center it
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Text = "Tools Dashboard"
$labelTitle.Font = New-Object System.Drawing.Font("Arial", 16, [System.Drawing.FontStyle]::Bold)
$labelTitle.Size = New-Object System.Drawing.Size(200, 30)
$labelTitle.Location = New-Object System.Drawing.Point([int](($formMain.ClientSize.Width - $labelTitle.Width) / 2), 20)
$formMain.Controls.Add($labelTitle)

# ---- Category: Outils ----
# Create the GroupBox without title
$groupOutils = New-Object System.Windows.Forms.GroupBox
$groupOutils.Text = ""
$groupOutils.Size = New-Object System.Drawing.Size(350, 150)
$groupOutils.Location = New-Object System.Drawing.Point(50, 80)

# Add the GroupBox to the form
$formMain.Controls.Add($groupOutils)

# Manually draw the title outside the GroupBox
$titleLabelOutils = New-Object System.Windows.Forms.Label
$titleLabelOutils.Text = "Outils"
$titleLabelOutils.Font = New-Object System.Drawing.Font("Arial", 13, [System.Drawing.FontStyle]::Bold)  # Larger font for the title
$titleLabelOutils.Location = New-Object System.Drawing.Point(50, 50)  # Position it above the GroupBox
$titleLabelOutils.Size = New-Object System.Drawing.Size(350, 30)  # Size to match the title
$titleLabelOutils.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter  # Center the text
$formMain.Controls.Add($titleLabelOutils)

#Open Exchange Admin Center in Incognito mode
$linkExchange = New-Object System.Windows.Forms.Label
$linkExchange.Text = "Admin Exchange"
$linkExchange.ForeColor = [System.Drawing.Color]::Blue
$linkExchange.Location = New-Object System.Drawing.Point(20, 30)
$linkExchange.Size = New-Object System.Drawing.Size(100, 30)
$linkExchange.Cursor = [System.Windows.Forms.Cursors]::Hand
# Define the click event for $linkExchange
$linkExchange.Add_Click({
    # Open Exchange Admin Center in Incognito mode
    $chromePath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    if (Test-Path $chromePath) {
        Start-Process $chromePath -ArgumentList "--incognito https://admin.exchange.microsoft.com/#/"
    } else {
        Write-Output "Google Chrome n'est pas installé au chemin spécifié."
    }
})

# Add the control to the GroupBox
$groupOutils.Controls.Add($linkExchange)

#Open LAPS UI
$linkLAPS = New-Object System.Windows.Forms.Label
$linkLAPS.Text = "LAPS UI"
$linkLAPS.ForeColor = [System.Drawing.Color]::Blue
$linkLAPS.Location = New-Object System.Drawing.Point(20, 60)
$linkLAPS.Size = New-Object System.Drawing.Size(100, 30)
$linkLAPS.Cursor = [System.Windows.Forms.Cursors]::Hand
# Define the click event for $linkLAPS
$linkLAPS.Add_Click({
    $LAPSpath = "C:\Program Files\LAPS\AdmPwd.UI.exe"
    if (Test-Path $LAPSpath) {
    Start-Process $LAPSpath
    } else {
        Write-Output "LAPS UI n'est pas installé au chemin spécifié"
    }
})
$groupOutils.Controls.Add($linkLAPS)

#Open RDP to Bastion
$linkBastion = New-Object System.Windows.Forms.Label
$linkBastion.Text = "Bastion"
$linkBastion.ForeColor = [System.Drawing.Color]::Blue
$linkBastion.Location = New-Object System.Drawing.Point(230, 60)
$linkBastion.Size = New-Object System.Drawing.Size(100, 30)
$linkBastion.Cursor = [System.Windows.Forms.Cursors]::Hand
# Define the click event for $linkBastion
$linkBastion.Add_Click({
    Start-Process "C:\Windows\system32\mstsc.exe" -ArgumentList "/v:"
})

$groupOutils.Controls.Add($linkBastion)

$linkAD = New-Object System.Windows.Forms.Label
$linkAD.Text = "Active Directory"
$linkAD.ForeColor = [System.Drawing.Color]::Blue
$linkAD.Location = New-Object System.Drawing.Point(230, 30)
$linkAD.Size = New-Object System.Drawing.Size(100, 30)
$linkAD.Cursor = [System.Windows.Forms.Cursors]::Hand
# Define the click event for $linkAD
$linkAD.Add_Click({
    $ADPath = "C:\Windows\system32\dsa.msc"
    if (Test-Path $ADPath) {
    Start-Process $ADPath -Verb Runas
    } else {
        Write-Output "L'outil Active Directory n'est pas installé au chemin spécifié"
    }
})
$groupOutils.Controls.Add($linkAD)

# Create a new label for Gestion de Parc
$linkGDP = New-Object System.Windows.Forms.Label
$linkGDP.Text = "Gestion de Parc"
$linkGDP.ForeColor = [System.Drawing.Color]::Blue
$linkGDP.Location = New-Object System.Drawing.Point(20, 90)
$linkGDP.Size = New-Object System.Drawing.Size(100, 30)
$linkGDP.Cursor = [System.Windows.Forms.Cursors]::Hand

# Define the click event for $linkGDP
$linkGDP.Add_Click({
    $GDPPath = "https://.xlsl"
    Start-Process "ms-excel:ofe|u|$GDPPath"
 
})
$groupOutils.Controls.Add($linkGDP)

# Create a new label for RunDeck
$linkRD = New-Object System.Windows.Forms.Label
$linkRD.Text = "RunDeck"
$linkRD.ForeColor = [System.Drawing.Color]::Blue
$linkRD.Location = New-Object System.Drawing.Point(230, 90)
$linkRD.Size = New-Object System.Drawing.Size(100, 30)
$linkRD.Cursor = [System.Windows.Forms.Cursors]::Hand

# Define the click event for $linkRD
$linkRD.Add_Click({
    $chromePath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    if (Test-Path $chromePath) {
        Start-Process $chromePath ""
    } else {
        Write-Output "Google Chrome n'est pas installé au chemin spécifié."
    }
   
})
   
$groupOutils.Controls.Add($linkRD)

# ---- Category: Docs ----
# Create the GroupBox for Docs category
$groupDocs = New-Object System.Windows.Forms.GroupBox
$groupDocs.Text = ""
$groupDocs.Size = New-Object System.Drawing.Size(350, 150)
$groupDocs.Location = New-Object System.Drawing.Point(50, 270)
$formMain.Controls.Add($groupDocs)

# Manually draw the title for Docs outside the GroupBox
$titleLabelDocs = New-Object System.Windows.Forms.Label
$titleLabelDocs.Text = "Docs"
$titleLabelDocs.Font = New-Object System.Drawing.Font("Arial", 13, [System.Drawing.FontStyle]::Bold)
$titleLabelDocs.Location = New-Object System.Drawing.Point(50, 240)  # Position it above the GroupBox
$titleLabelDocs.Size = New-Object System.Drawing.Size(350, 30)
$titleLabelDocs.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter  # Center the text
$formMain.Controls.Add($titleLabelDocs)

# Docs Links inside the GroupBox
$linkDoc1 = New-Object System.Windows.Forms.Label
$linkDoc1.Text = "Documentation Confluence"
$linkDoc1.ForeColor = [System.Drawing.Color]::Blue
$linkDoc1.Location = New-Object System.Drawing.Point(20, 30)
$linkDoc1.Size = New-Object System.Drawing.Size(150, 30)
$linkDoc1.Cursor = [System.Windows.Forms.Cursors]::Hand
$linkDoc1.Add_Click({
    # Open a document link (example)
     Start-Process "chrome.exe" ""
})
$groupDocs.Controls.Add($linkDoc1)

$linkDoc2 = New-Object System.Windows.Forms.Label
$linkDoc2.Text = "Documentation Fresh Service"
$linkDoc2.ForeColor = [System.Drawing.Color]::Blue
$linkDoc2.Location = New-Object System.Drawing.Point(20, 60)
$linkDoc2.Size = New-Object System.Drawing.Size(180, 30)
$linkDoc2.Cursor = [System.Windows.Forms.Cursors]::Hand
$linkDoc2.Add_Click({
    # Open another document link (example)
    Start-Process "chrome.exe" ""
})
$groupDocs.Controls.Add($linkDoc2)

$linkDoc3 = New-Object System.Windows.Forms.Label
$linkDoc3.Text = "Documentation DEX"
$linkDoc3.ForeColor = [System.Drawing.Color]::Blue
$linkDoc3.Location = New-Object System.Drawing.Point(20, 90)
$linkDoc3.Size = New-Object System.Drawing.Size(150, 30)
$linkDoc3.Cursor = [System.Windows.Forms.Cursors]::Hand
$linkDoc3.Add_Click({
    # Open Explorer with DEX
    Start-Process "explorer.exe" "\\"

})
$groupDocs.Controls.Add($linkDoc3)

# ---- Category: Scripts ----
# Create the GroupBox for Scripts category
$groupScripts = New-Object System.Windows.Forms.GroupBox
$groupScripts.Text = ""
$groupScripts.Size = New-Object System.Drawing.Size(350, 150)
$groupScripts.Location = New-Object System.Drawing.Point(50, 460)
$formMain.Controls.Add($groupScripts)

# Manually draw the title for Scripts outside the GroupBox
$titleLabelScripts = New-Object System.Windows.Forms.Label
$titleLabelScripts.Text = "Scripts"
$titleLabelScripts.Font = New-Object System.Drawing.Font("Arial", 13, [System.Drawing.FontStyle]::Bold)
$titleLabelScripts.Location = New-Object System.Drawing.Point(50, 430)  # Position it above the GroupBox
$titleLabelScripts.Size = New-Object System.Drawing.Size(350, 30)
$titleLabelScripts.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter  # Center the text
$formMain.Controls.Add($titleLabelScripts)

$linkScriptAD = New-Object System.Windows.Forms.Label
$linkScriptAD.Text = "PowerShell Script"
$linkScriptAD.ForeColor = [System.Drawing.Color]::Blue
$linkScriptAD.Location = New-Object System.Drawing.Point(20, 30)
$linkScriptAD.Size = New-Object System.Drawing.Size(180, 30)
$linkScriptAD.Cursor = [System.Windows.Forms.Cursors]::Hand
$linkScriptAD.Add_Click({
    # Execute AD Rights Comparison script with elevated privileges
    #$scriptPath = "C:\Users\ccheron\Desktop\ComapreAD-GUI.ps1"  # Replace with the actual path to your script
Start-Process powershell.exe -ArgumentList "-WindowStyle hidden -File `"\\.ps1`"" -Verb Runas -WindowStyle hidden})
$groupScripts.Controls.Add($linkScriptAD)

# Show the form
$formMain.ShowDialog()
