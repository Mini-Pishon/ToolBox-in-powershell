# Create the main form
$formMain = New-Object System.Windows.Forms.Form
$formMain.Text = "Toolbox"  # Set the window title
$formMain.Size = New-Object System.Drawing.Size(490, 700)  # Set the window size

# Create a label for the title "Toolbox" and center it
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Text      = "Toolbox"  
$labelTitle.Font      = New-Object System.Drawing.Font("Arial", 16, [System.Drawing.FontStyle]::Bold)
$labelTitle.AutoSize  = $false               # disable AutoSize
$labelTitle.Dock      = 'Top'                # fill the form’s full width
$labelTitle.Height    = 40                   # fixed height, adjustable as needed
$labelTitle.TextAlign = 'MiddleCenter'       # horizontally center the text
$formMain.Controls.Add($labelTitle)

# ---- Category: Tools ----
# Create the GroupBox without a title
$groupOutils = New-Object System.Windows.Forms.GroupBox
$groupOutils.Size = New-Object System.Drawing.Size(380, 140)  # GroupBox size
$groupOutils.Location = New-Object System.Drawing.Point(50, 80)  # GroupBox position

# Add the GroupBox to the form
$formMain.Controls.Add($groupOutils)

# Title for Tools section
$titleLabelOutils = New-Object System.Windows.Forms.Label
$titleLabelOutils.Text      = "Tools"
$titleLabelOutils.Font      = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)  # slightly larger
$titleLabelOutils.ForeColor = [System.Drawing.Color]::Black                                                # black text
$titleLabelOutils.AutoSize  = $false
$titleLabelOutils.Size      = New-Object System.Drawing.Size(350, 25)                                      # match GroupBox width
$titleLabelOutils.Location  = New-Object System.Drawing.Point(50, 50)                                     # just above the Tools box
$titleLabelOutils.TextAlign = 'MiddleCenter'                                                               # center text
$formMain.Controls.Add($titleLabelOutils)


# Open the Exchange Admin Center in incognito mode
$linkExchange = New-Object System.Windows.Forms.LinkLabel
$linkExchange.Text              = "Admin Exchange"
$linkExchange.Font              = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Regular)  # smaller font
$linkExchange.LinkColor         = [System.Drawing.Color]::Blue                                             # link color
$linkExchange.ActiveLinkColor   = [System.Drawing.Color]::Blue                                             # color when clicked
$linkExchange.VisitedLinkColor  = [System.Drawing.Color]::Blue                                             # color after visit
$linkExchange.LinkBehavior      = 'NeverUnderline'
$linkExchange.AutoSize          = $true
$linkExchange.Location          = New-Object System.Drawing.Point(20, 30)
$linkExchange.Cursor            = [System.Windows.Forms.Cursors]::Hand
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
$linkLAPS = New-Object System.Windows.Forms.LinkLabel
$linkLAPS.Text              = "LAPS UI"
$linkLAPS.Font              = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Regular)  # smaller font
$linkLAPS.LinkColor         = [System.Drawing.Color]::Blue                                              # normal link color
$linkLAPS.ActiveLinkColor   = [System.Drawing.Color]::Blue                                              # color when clicked
$linkLAPS.VisitedLinkColor  = [System.Drawing.Color]::Blue                                              # color after visit
$linkLAPS.LinkBehavior      = 'NeverUnderline'
$linkLAPS.AutoSize          = $true                                                                     # size to its text
$linkLAPS.Location          = New-Object System.Drawing.Point(20, 60)
$linkLAPS.Cursor            = [System.Windows.Forms.Cursors]::Hand
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
$linkBastion = New-Object System.Windows.Forms.LinkLabel
$linkBastion.Text              = "Bastion"
$linkBastion.Font              = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Regular)  # smaller font
$linkBastion.LinkColor         = [System.Drawing.Color]::Blue                                                # normal link color
$linkBastion.ActiveLinkColor   = [System.Drawing.Color]::Blue                                                # color when clicked
$linkBastion.VisitedLinkColor  = [System.Drawing.Color]::Blue                                                # color after visit
$linkBastion.LinkBehavior      = 'NeverUnderline'
$linkBastion.AutoSize          = $true                                                                       # size to its text
$linkBastion.Location          = New-Object System.Drawing.Point(230, 60)
$linkBastion.Cursor            = [System.Windows.Forms.Cursors]::Hand
# Define the click event for $linkBastion
$linkBastion.Add_Click({
    Start-Process "C:\Windows\system32\mstsc.exe" -ArgumentList "/v:"  # Launch the RDP connection
})

$groupOutils.Controls.Add($linkBastion)

# Create a link label for Active Directory
$linkAD = New-Object System.Windows.Forms.LinkLabel
$linkAD.Text              = "Active Directory"
$linkAD.Font              = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Regular)  # 8pt font
$linkAD.LinkColor         = [System.Drawing.Color]::Blue                                                  # normal link color
$linkAD.ActiveLinkColor   = [System.Drawing.Color]::Blue                                                  # color when clicked
$linkAD.VisitedLinkColor  = [System.Drawing.Color]::Blue                                                  # color after visit
$linkAD.LinkBehavior      = 'NeverUnderline'
$linkAD.AutoSize          = $true                                                                           # size to its text
$linkAD.Location          = New-Object System.Drawing.Point(230, 30)
$linkAD.Cursor            = [System.Windows.Forms.Cursors]::Hand
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

# Create a new link label for Fleet Management
$linkGDP = New-Object System.Windows.Forms.LinkLabel
$linkGDP.Text              = "Fleet Management"
$linkGDP.Font              = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Regular)  # 8pt font
$linkGDP.LinkColor         = [System.Drawing.Color]::Blue                                                  # normal link color
$linkGDP.ActiveLinkColor   = [System.Drawing.Color]::Blue                                                  # color when clicked
$linkGDP.VisitedLinkColor  = [System.Drawing.Color]::Blue                                                  # color after visit
$linkGDP.LinkBehavior      = 'NeverUnderline'
$linkGDP.AutoSize          = $true                                                                           # size to its text
$linkGDP.Location          = New-Object System.Drawing.Point(20, 90)
$linkGDP.Cursor            = [System.Windows.Forms.Cursors]::Hand

# Define the click event for $linkGDP
$linkGDP.Add_Click({
    $GDPPath = ".xlsx"  # Link to the Excel file
    Start-Process "ms-excel:ofe|u|$GDPPath"  # Open the Excel file
})
$groupOutils.Controls.Add($linkGDP)

# Create a new link label for RunDeck
$linkRD = New-Object System.Windows.Forms.LinkLabel
$linkRD.Text              = "RunDeck"
$linkRD.Font              = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Regular)  # 8pt font
$linkRD.LinkColor         = [System.Drawing.Color]::Blue                                                  # normal link color
$linkRD.ActiveLinkColor   = [System.Drawing.Color]::Blue                                                  # color when clicked
$linkRD.VisitedLinkColor  = [System.Drawing.Color]::Blue                                                  # color after visit
$linkRD.LinkBehavior      = 'NeverUnderline'
$linkRD.AutoSize          = $true                                                                           # size to its text
$linkRD.Location          = New-Object System.Drawing.Point(230, 90)
$linkRD.Cursor            = [System.Windows.Forms.Cursors]::Hand

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
$groupDocs.Size = New-Object System.Drawing.Size(380, 140)  # GroupBox size
$groupDocs.Location = New-Object System.Drawing.Point(50, 270)  # GroupBox position
$formMain.Controls.Add($groupDocs)

# Title for Docs section
$titleLabelDocs = New-Object System.Windows.Forms.Label
$titleLabelDocs.Text      = "Docs"
$titleLabelDocs.Font      = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)  # slightly larger
$titleLabelDocs.ForeColor = [System.Drawing.Color]::Black                                              # black text
$titleLabelDocs.AutoSize  = $false
$titleLabelDocs.Size      = New-Object System.Drawing.Size(350, 25)                                    # match GroupBox width
$titleLabelDocs.Location  = New-Object System.Drawing.Point(50, 240)                                   # just above the Docs box
$titleLabelDocs.TextAlign = 'MiddleCenter'                                                             # center text
$formMain.Controls.Add($titleLabelDocs)

# Documentation links inside the GroupBox
$linkDoc1 = New-Object System.Windows.Forms.LinkLabel
$linkDoc1.Text              = "Documentation xxx"
$linkDoc1.Font              = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Regular)  # 8pt font
$linkDoc1.LinkColor         = [System.Drawing.Color]::Blue                                                  # normal link color
$linkDoc1.ActiveLinkColor   = [System.Drawing.Color]::Blue                                                  # color when clicked
$linkDoc1.VisitedLinkColor  = [System.Drawing.Color]::Blue                                                  # color after visit
$linkDoc1.LinkBehavior      = 'NeverUnderline'
$linkDoc1.AutoSize          = $true                                                                           # size to its text
$linkDoc1.Location          = New-Object System.Drawing.Point(20, 30)
$linkDoc1.Cursor            = [System.Windows.Forms.Cursors]::Hand  

$linkDoc1.Add_Click({
    # Open a documentation link (example)
    Start-Process "chrome.exe" ""  # Open the link in Chrome
})
$groupDocs.Controls.Add($linkDoc1)

# Documentation link 2 inside the GroupBox
$linkDoc2 = New-Object System.Windows.Forms.LinkLabel
$linkDoc2.Text              = "Documentation xxx"
$linkDoc2.Font              = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Regular)  # 8pt font
$linkDoc2.LinkColor         = [System.Drawing.Color]::Blue                                                  # normal link color
$linkDoc2.ActiveLinkColor   = [System.Drawing.Color]::Blue                                                  # color when clicked
$linkDoc2.VisitedLinkColor  = [System.Drawing.Color]::Blue                                                  # color after visit
$linkDoc2.LinkBehavior      = 'NeverUnderline'
$linkDoc2.AutoSize          = $true                                                                           # size to its text
$linkDoc2.Location          = New-Object System.Drawing.Point(20, 60)
$linkDoc2.Cursor            = [System.Windows.Forms.Cursors]::Hand        
$linkDoc2.Add_Click({
    # Open another documentation link (example)
    Start-Process "chrome.exe" ""  # Open the link in Chrome
})
$groupDocs.Controls.Add($linkDoc2)

# Documentation link 3 inside the GroupBox
$linkDoc3 = New-Object System.Windows.Forms.LinkLabel
$linkDoc3.Text              = "Documentation xxx"
$linkDoc3.Font              = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Regular)  # 8pt font
$linkDoc3.LinkColor         = [System.Drawing.Color]::Blue                                                  # normal link color
$linkDoc3.ActiveLinkColor   = [System.Drawing.Color]::Blue                                                  # color when clicked
$linkDoc3.VisitedLinkColor  = [System.Drawing.Color]::Blue                                                  # color after visit
$linkDoc3.LinkBehavior      = 'NeverUnderline'
$linkDoc3.AutoSize          = $true                                                                           # size to its text
$linkDoc3.Location          = New-Object System.Drawing.Point(20, 90)
$linkDoc3.Cursor            = [System.Windows.Forms.Cursors]::Hand        

$linkDoc3.Add_Click({
    # Open Explorer with DEX
    Start-Process "explorer.exe" "\\"  # Open the network path
})
$groupDocs.Controls.Add($linkDoc3)

# ---- Category: Scripts ----
# Create the GroupBox for the Scripts category
$groupScripts = New-Object System.Windows.Forms.GroupBox
$groupScripts.Size = New-Object System.Drawing.Size(380, 140)  # GroupBox size
$groupScripts.Location = New-Object System.Drawing.Point(50, 460)  # GroupBox position
$formMain.Controls.Add($groupScripts)

# Title for Scripts section
$titleLabelScripts = New-Object System.Windows.Forms.Label
$titleLabelScripts.Text      = "Scripts"
$titleLabelScripts.Font      = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)  # slightly larger
$titleLabelScripts.ForeColor = [System.Drawing.Color]::Black                                              # black text
$titleLabelScripts.AutoSize  = $false
$titleLabelScripts.Size      = New-Object System.Drawing.Size(350, 25)                                    # match GroupBox width
$titleLabelScripts.Location  = New-Object System.Drawing.Point(50, 430)                                   # just above the Scripts box
$titleLabelScripts.TextAlign = 'MiddleCenter'                                                             # center text
$formMain.Controls.Add($titleLabelScripts)

# Link label for Compare Active Directory Groups
$linkScriptAD = New-Object System.Windows.Forms.LinkLabel
$linkScriptAD.Text              = "Compare Active Directory Groups"
$linkScriptAD.Font              = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Regular)  # 8pt font
$linkScriptAD.LinkColor         = [System.Drawing.Color]::Blue                                                  # normal link color
$linkScriptAD.ActiveLinkColor   = [System.Drawing.Color]::Blue                                                  # color when clicked
$linkScriptAD.VisitedLinkColor  = [System.Drawing.Color]::Blue                                                  # color after visit
$linkScriptAD.LinkBehavior      = 'NeverUnderline'
$linkScriptAD.AutoSize          = $true                                                                           # size to its text
$linkScriptAD.Location          = New-Object System.Drawing.Point(20, 30)
$linkScriptAD.Cursor            = [System.Windows.Forms.Cursors]::Hand 

$linkScriptAD.Add_Click({
    # Execute the AD rights comparison script with elevated privileges
    Start-Process powershell.exe -ArgumentList "-WindowStyle hidden -File `"\\.ps1`"" -Verb Runas -WindowStyle hidden  # Execute the PowerShell script, path to ps1 file
})
$groupScripts.Controls.Add($linkScriptAD)

# Link label for Search Active Directory Group(s)
$linkADGroups = New-Object System.Windows.Forms.LinkLabel
$linkADGroups.Text              = "Search Active Directory Group(s)"
$linkADGroups.Font              = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Regular)  # 8pt font
$linkADGroups.LinkColor         = [System.Drawing.Color]::Blue                                                  # normal link color
$linkADGroups.ActiveLinkColor   = [System.Drawing.Color]::Blue                                                  # color when clicked
$linkADGroups.VisitedLinkColor  = [System.Drawing.Color]::Blue                                                  # color after visit
$linkADGroups.LinkBehavior      = 'NeverUnderline'
$linkADGroups.AutoSize          = $true                                                                           # size to its text
$linkADGroups.Location          = New-Object System.Drawing.Point(20, 60)
$linkADGroups.Cursor            = [System.Windows.Forms.Cursors]::Hand  
$linkADGroups.Add_Click({
    # Execute the ACL share script with elevated privileges
    Start-Process powershell.exe -ArgumentList "-NoExit -File `"\\.ps1`"" -Verb Runas  # Execute the PowerShell script, path to ps1 file
})
$groupScripts.Controls.Add($linkADGroups)

# Display the form
$formMain.ShowDialog()  # Display the window
