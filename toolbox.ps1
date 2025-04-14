# Create the main form
$formMain = New-Object System.Windows.Forms.Form
$formMain.Text = "Toolbox"  # Set the window title
$formMain.Size = New-Object System.Drawing.Size(450, 700)  # Set the window size

# Create a label for the title "Toolbox" and center it
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Text = "Toolbox"  # Label text
$labelTitle.Font = New-Object System.Drawing.Font("Arial", 21, [System.Drawing.FontStyle]::Bold)  # Font and style of the text
$labelTitle.Size = New-Object System.Drawing.Size(200, 30)  # Label size
$labelTitle.Location = New-Object System.Drawing.Point([int](($formMain.ClientSize.Width - $labelTitle.Width) / 2), 20)  # Centered position

$formMain.Controls.Add($labelTitle)  # Add the label to the form

# ---- Category: Tools ----
# Create the GroupBox without a title
$groupOutils = New-Object System.Windows.Forms.GroupBox
$groupOutils.Text = ""  # No text for the GroupBox title
$groupOutils.Size = New-Object System.Drawing.Size(350, 150)  # GroupBox size
$groupOutils.Location = New-Object System.Drawing.Point(50, 80)  # GroupBox position

# Add the GroupBox to the form
$formMain.Controls.Add($groupOutils)

# Manually draw the title outside the GroupBox
$titleLabelOutils = New-Object System.Windows.Forms.Label
$titleLabelOutils.Text = "Tools"  # Title text
$titleLabelOutils.Font = New-Object System.Drawing.Font("Arial", 13, [System.Drawing.FontStyle]::Bold)  # Larger font for the title
$titleLabelOutils.Location = New-Object System.Drawing.Point(50, 50)  # Position above the GroupBox
$titleLabelOutils.Size = New-Object System.Drawing.Size(350, 30)  # Size adapted to the title
$titleLabelOutils.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter  # Center the text
$formMain.Controls.Add($titleLabelOutils)  # Add the title to the form

# Open the Exchange Admin Center in incognito mode
$linkExchange = New-Object System.Windows.Forms.Label
$linkExchange.Text = "Admin Exchange"  # Link text
$linkExchange.ForeColor = [System.Drawing.Color]::Blue  # Text color
$linkExchange.Location = New-Object System.Drawing.Point(20, 30)  # Link position
$linkExchange.Size = New-Object System.Drawing.Size(100, 15)  # Link size
$linkExchange.Cursor = [System.Windows.Forms.Cursors]::Hand  # Hand cursor
# Define the click event for $linkExchange
$linkExchange.Add_Click({
    # Open the Exchange Admin Center in incognito mode
    $chromePath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"  # Path to Chrome
    if (Test-Path $chromePath) {
        Start-Process $chromePath -ArgumentList "--incognito https://admin.exchange.microsoft.com/#/"  # Open in incognito mode
    } else {
        Write-Output "Google Chrome is not installed at the specified path."  # Error message
    }
})

# Add the control to the GroupBox
$groupOutils.Controls.Add($linkExchange)

# Open the LAPS user interface
$linkLAPS = New-Object System.Windows.Forms.Label
$linkLAPS.Text = "LAPS UI"  # Link text
$linkLAPS.ForeColor = [System.Drawing.Color]::Blue  # Text color
$linkLAPS.Location = New-Object System.Drawing.Point(20, 60)  # Link position
$linkLAPS.Size = New-Object System.Drawing.Size(100, 15)  # Link size
$linkLAPS.Cursor = [System.Windows.Forms.Cursors]::Hand  # Hand cursor
# Define the click event for $linkLAPS
$linkLAPS.Add_Click({
    $LAPSpath = "C:\Program Files\LAPS\AdmPwd.UI.exe"  # Path to LAPS UI
    if (Test-Path $LAPSpath) {
        Start-Process $LAPSpath -Verb RunAs  # Run as administrator
    } else {
        Write-Output "LAPS UI is not installed at the specified path"  # Error message
    }
})
$groupOutils.Controls.Add($linkLAPS)

# Open an RDP connection to Bastion
$linkBastion = New-Object System.Windows.Forms.Label
$linkBastion.Text = "Bastion"  # Link text
$linkBastion.ForeColor = [System.Drawing.Color]::Blue  # Text color
$linkBastion.Location = New-Object System.Drawing.Point(230, 60)  # Link position
$linkBastion.Size = New-Object System.Drawing.Size(100, 15)  # Link size
$linkBastion.Cursor = [System.Windows.Forms.Cursors]::Hand  # Hand cursor
# Define the click event for $linkBastion
$linkBastion.Add_Click({
    Start-Process "C:\Windows\system32\mstsc.exe" -ArgumentList "/v:"  # Launch the RDP connection
})

$groupOutils.Controls.Add($linkBastion)

$linkAD = New-Object System.Windows.Forms.Label
$linkAD.Text = "Active Directory"  # Link text
$linkAD.ForeColor = [System.Drawing.Color]::Blue  # Text color
$linkAD.Location = New-Object System.Drawing.Point(230, 30)  # Link position
$linkAD.Size = New-Object System.Drawing.Size(100, 15)  # Link size
$linkAD.Cursor = [System.Windows.Forms.Cursors]::Hand  # Hand cursor
# Define the click event for $linkAD
$linkAD.Add_Click({
    $ADPath = "C:\Windows\system32\dsa.msc"  # Path to the Active Directory tool
    if (Test-Path $ADPath) {
        Start-Process $ADPath -Verb Runas  # Run as administrator
    } else {
        Write-Output "The Active Directory tool is not installed at the specified path"  # Error message
    }
})
$groupOutils.Controls.Add($linkAD)

# Create a new label for Fleet Management
$linkGDP = New-Object System.Windows.Forms.Label
$linkGDP.Text = "Fleet Management"  # Link text
$linkGDP.ForeColor = [System.Drawing.Color]::Blue  # Text color
$linkGDP.Location = New-Object System.Drawing.Point(20, 90)  # Link position
$linkGDP.Size = New-Object System.Drawing.Size(100, 15)  # Link size
$linkGDP.Cursor = [System.Windows.Forms.Cursors]::Hand  # Hand cursor

# Define the click event for $linkGDP
$linkGDP.Add_Click({
    $GDPPath = ".xlsx"  # Link to the Excel file
    Start-Process "ms-excel:ofe|u|$GDPPath"  # Open the Excel file
})
$groupOutils.Controls.Add($linkGDP)

# Create a new label for RunDeck
$linkRD = New-Object System.Windows.Forms.Label
$linkRD.Text = "RunDeck"  # Link text
$linkRD.ForeColor = [System.Drawing.Color]::Blue  # Text color
$linkRD.Location = New-Object System.Drawing.Point(230, 90)  # Link position
$linkRD.Size = New-Object System.Drawing.Size(100, 15)  # Link size
$linkRD.Cursor = [System.Windows.Forms.Cursors]::Hand  # Hand cursor

# Define the click event for $linkRD
$linkRD.Add_Click({
    $chromePath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"  # Path to Chrome
    if (Test-Path $chromePath) {
        Start-Process $chromePath ""  # Open RunDeck
    } else {
        Write-Output "Google Chrome is not installed at the specified path."  # Error message
    }
})

$groupOutils.Controls.Add($linkRD)

# ---- Category: Docs ----
# Create the GroupBox for the Docs category
$groupDocs = New-Object System.Windows.Forms.GroupBox
$groupDocs.Text = ""  # No text for the GroupBox title
$groupDocs.Size = New-Object System.Drawing.Size(350, 150)  # GroupBox size
$groupDocs.Location = New-Object System.Drawing.Point(50, 270)  # GroupBox position
$formMain.Controls.Add($groupDocs)

# Manually draw the title for Docs outside the GroupBox
$titleLabelDocs = New-Object System.Windows.Forms.Label
$titleLabelDocs.Text = "Docs"  # Title text
$titleLabelDocs.Font = New-Object System.Drawing.Font("Arial", 13, [System.Drawing.FontStyle]::Bold)  # Font and style of the text
$titleLabelDocs.Location = New-Object System.Drawing.Point(50, 240)  # Position above the GroupBox
$titleLabelDocs.Size = New-Object System.Drawing.Size(350, 15)  # Size adapted to the title
$titleLabelDocs.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter  # Center the text
$formMain.Controls.Add($titleLabelDocs)  # Add the title to the form

# Documentation links inside the GroupBox
$linkDoc1 = New-Object System.Windows.Forms.Label
$linkDoc1.Text = "Documentation xxx"  # Link text
$linkDoc1.ForeColor = [System.Drawing.Color]::Blue  # Text color
$linkDoc1.Location = New-Object System.Drawing.Point(20, 30)  # Link position
$linkDoc1.Size = New-Object System.Drawing.Size(150, 15)  # Link size
$linkDoc1.Cursor = [System.Windows.Forms.Cursors]::Hand  # Hand cursor
$linkDoc1.Add_Click({
    # Open a documentation link (example)
    Start-Process "chrome.exe" ""  # Open the link in Chrome
})
$groupDocs.Controls.Add($linkDoc1)

$linkDoc2 = New-Object System.Windows.Forms.Label
$linkDoc2.Text = "Documentation xxx"  # Link text
$linkDoc2.ForeColor = [System.Drawing.Color]::Blue  # Text color
$linkDoc2.Location = New-Object System.Drawing.Point(20, 60)  # Link position
$linkDoc2.Size = New-Object System.Drawing.Size(180, 15)  # Link size
$linkDoc2.Cursor = [System.Windows.Forms.Cursors]::Hand  # Hand cursor
$linkDoc2.Add_Click({
    # Open another documentation link (example)
    Start-Process "chrome.exe" ""  # Open the link in Chrome
})
$groupDocs.Controls.Add($linkDoc2)

$linkDoc3 = New-Object System.Windows.Forms.Label
$linkDoc3.Text = "Documentation xxx"  # Link text
$linkDoc3.ForeColor = [System.Drawing.Color]::Blue  # Text color
$linkDoc3.Location = New-Object System.Drawing.Point(20, 90)  # Link position
$linkDoc3.Size = New-Object System.Drawing.Size(150, 15)  # Link size
$linkDoc3.Cursor = [System.Windows.Forms.Cursors]::Hand  # Hand cursor
$linkDoc3.Add_Click({
    # Open Explorer with DEX
    Start-Process "explorer.exe" "\\"  # Open the network path
})
$groupDocs.Controls.Add($linkDoc3)

# ---- Category: Scripts ----
# Create the GroupBox for the Scripts category
$groupScripts = New-Object System.Windows.Forms.GroupBox
$groupScripts.Text = ""  # No text for the GroupBox title
$groupScripts.Size = New-Object System.Drawing.Size(350, 150)  # GroupBox size
$groupScripts.Location = New-Object System.Drawing.Point(50, 460)  # GroupBox position
$formMain.Controls.Add($groupScripts)

# Manually draw the title for Scripts outside the GroupBox
$titleLabelScripts = New-Object System.Windows.Forms.Label
$titleLabelScripts.Text = "Scripts"  # Title text
$titleLabelScripts.Font = New-Object System.Drawing.Font("Arial", 13, [System.Drawing.FontStyle]::Bold)  # Font and style of the text
$titleLabelScripts.Location = New-Object System.Drawing.Point(50, 430)  # Position above the GroupBox
$titleLabelScripts.Size = New-Object System.Drawing.Size(350, 15)  # Size adapted to the title
$titleLabelScripts.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter  # Center the text
$formMain.Controls.Add($titleLabelScripts)  # Add the title to the form

$linkScriptAD = New-Object System.Windows.Forms.Label
$linkScriptAD.Text = "Compare Active Directory Groups"  # Link text
$linkScriptAD.ForeColor = [System.Drawing.Color]::Blue  # Text color
$linkScriptAD.Location = New-Object System.Drawing.Point(20, 30)  # Link position
$linkScriptAD.Size = New-Object System.Drawing.Size(230, 15)  # Link size
$linkScriptAD.Cursor = [System.Windows.Forms.Cursors]::Hand  # Hand cursor
$linkScriptAD.Add_Click({
    # Execute the AD rights comparison script with elevated privileges
    Start-Process powershell.exe -ArgumentList "-WindowStyle hidden -File `"\\.ps1`"" -Verb Runas -WindowStyle hidden  # Execute the PowerShell script, path to ps1 file
})
$groupScripts.Controls.Add($linkScriptAD)

$linkADGroups = New-Object System.Windows.Forms.Label
$linkADGroups.Text = "Search Active Directory Group(s)"  # Link text
$linkADGroups.ForeColor = [System.Drawing.Color]::Blue  # Text color
$linkADGroups.Location = New-Object System.Drawing.Point(20, 60)  # Link position
$linkADGroups.Size = New-Object System.Drawing.Size(230, 15)  # Link size
$linkADGroups.Cursor = [System.Windows.Forms.Cursors]::Hand  # Hand cursor
$linkADGroups.Add_Click({
    # Execute the ACL share script with elevated privileges
    Start-Process powershell.exe -ArgumentList "-NoExit -File `"\\.ps1`"" -Verb Runas  # Execute the PowerShell script, path to ps1 file
})
$groupScripts.Controls.Add($linkADGroups)

# Display the form
$formMain.ShowDialog()  # Display the window
