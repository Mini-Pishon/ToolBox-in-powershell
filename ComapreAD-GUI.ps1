# Add the necessary types to use Windows Forms
Add-Type -AssemblyName System.Windows.Forms

# Function to compare the AD groups of two users
function Compare-ADUserGroups {
    param (
        [string]$User1,  # Parameter for the first user
        [string]$User2   # Parameter for the second user
    )

    # Retrieve the groups of user 1
    $user1Groups = Get-ADUser -Identity $User1 -Properties MemberOf | Select-Object -ExpandProperty MemberOf
    # Retrieve the groups of user 2
    $user2Groups = Get-ADUser -Identity $User2 -Properties MemberOf | Select-Object -ExpandProperty MemberOf

    # Find the groups common to both users
    $commonGroups = $user1Groups | Where-Object { $user2Groups -contains $_ }
    # Find the groups specific to user 1
    $user1SpecificGroups = $user1Groups | Where-Object { $user2Groups -notcontains $_ }
    # Find the groups specific to user 2
    $user2SpecificGroups = $user2Groups | Where-Object { $user1Groups -notcontains $_ }

    # Function to format the groups
    function Format-Groups {
        param (
            [string]$title,       # Title of the section
            [array]$groups,       # List of groups to format
            [string]$groupType    # Type of group (common, specific to user1, specific to user2)
        )

        $output = "${title}:`n"  # Initialize the output with the title
        if ($groups) {  # Check if groups exist
            $output += "--------------------------------------------------`n"
            foreach ($group in $groups) {
                # Add in bold for common groups
                if ($groupType -eq "common") {
                    $output += "**$group**`n"
                } elseif ($groupType -eq "user1") {
                    $output += "$group`n"
                } elseif ($groupType -eq "user2") {
                    $output += "$group`n"
                }
            }
        } else {
            $output += "No groups found.`n"
            $output += "--------------------------------------------------`n"
        }
        return $output  # Return the formatted output
    }

    # Format the results with separators
    $results = Format-Groups -title "COMMON GROUPS" -groups ($commonGroups | ForEach-Object { Get-ADGroup -Identity $_ | Select-Object -ExpandProperty Name }) -groupType "common"
    # Separator between common and specific groups
    $results += "`n--------------------------------------------------`n"
    $results += (Format-Groups -title "GROUPS SPECIFIC TO ${User1}" -groups ($user1SpecificGroups | ForEach-Object { Get-ADGroup -Identity $_ | Select-Object -ExpandProperty Name }) -groupType "user1")
    # Separator between specific groups of user 1 and user 2
    $results += "`n--------------------------------------------------`n"
    $results += (Format-Groups -title "GROUPS SPECIFIC TO ${User2}" -groups ($user2SpecificGroups | ForEach-Object { Get-ADGroup -Identity $_ | Select-Object -ExpandProperty Name }) -groupType "user2")

    return $results  # Return the formatted results
}

# Create the main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "AD Group Comparator"  # Form title
# Increased height to accommodate the output box
$form.Size = New-Object System.Drawing.Size(500,500)
$form.StartPosition = "CenterScreen"  # Position the form in the center of the screen

# Create and add the label for user 1
$label1 = New-Object System.Windows.Forms.Label
$label1.Location = '10,20'  # Label position
$label1.Size = '200,20'     # Label size
$label1.Text = "User 1 (SamAccountName):"  # Label text
$form.Controls.Add($label1)  # Add the label to the form

# Create and add the text box for user 1
$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = '220,20'  # Text box position
$textBox1.Size = '200,20'      # Text box size
$form.Controls.Add($textBox1)  # Add the text box to the form

# Create and add the label for user 2
$label2 = New-Object System.Windows.Forms.Label
$label2.Location = '10,60'  # Label position
$label2.Size = '200,20'     # Label size
$label2.Text = "User 2 (SamAccountName):"  # Label text
$form.Controls.Add($label2)  # Add the label to the form

# Create and add the text box for user 2
$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = '220,60'  # Text box position
$textBox2.Size = '200,20'      # Text box size
$form.Controls.Add($textBox2)  # Add the text box to the form

# Create and add the comparison button
$button = New-Object System.Windows.Forms.Button
$button.Location = '150,100'  # Button position
$button.Size = '200,30'       # Button size
$button.Text = "Compare"      # Button text
$button.Add_Click({
    $result = Compare-ADUserGroups -User1 $textBox1.Text -User2 $textBox2.Text  # Call the comparison function
    $outputBox.Text = $result  # Display the result in the output box
})
$form.Controls.Add($button)  # Add the button to the form

# Create the output box and add it to the form
$outputBox = New-Object System.Windows.Forms.RichTextBox
# Placed below the other controls
$outputBox.Location = '10,150'  # Output box position
# Size adjusted to fit the form
$outputBox.Size = '460,300'
$outputBox.Multiline = $true  # Enable multiline mode
$outputBox.ScrollBars = "Vertical"  # Add a vertical scroll bar
$form.Controls.Add($outputBox)  # Add the output box to the form

# Display the form
$form.ShowDialog()
