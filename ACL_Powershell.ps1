# ----------------------------------------- Press F5 to run the script -----------------------------------------
cls  # Clear the console

function question {
    <#
    ------------ This script allows us to ask a question and execute one of the following scripts ------------
    #>

    $compare_txt = ""  # Unused variable, can be removed
    $question = Read-Host "Hello, what would you like to do:`n
- Type 1 to compare the AD groups of two users:`n
- Type 2 to search for an AD group by its description or name"

    If ($question -ne $null) {  # Check if a response was given
        If ($question -eq 1) {  # If the user types 1
            Compare_AD_Group  # Call the function to compare AD groups
        }
        If ($question -eq 2) {  # If the user types 2
            search_AD_Group  # Call the function to search for an AD group
        }
    }
}

function Compare_AD_Group {
    <#
    ------------ This script allows comparing the AD groups of user2 against user1 ------------
    #>

    $User1 = Read-Host "`n `n Who is the user who currently has the rights (format: pmaillard)?"
    $User2 = Read-Host "Who is the user who is currently missing rights (format: sanne)?"

    # Retrieve the groups and their descriptions for User1
    $arraytableau = Get-ADPrincipalGroupMembership $User1 | Get-ADGroup -Properties * | Select-Object name, description
    # Retrieve the groups and their descriptions for User2
    $arraytableau2 = Get-ADPrincipalGroupMembership $User2 | Get-ADGroup -Properties * | Select-Object name, description

    # Compare the groups of User1 and User2 and find those that User1 has but User2 does not
    $arrayComparatif = Compare-Object $arraytableau $arraytableau2 -Property name, description | Where-Object { $_.SideIndicator -eq "<=" }

    Write-Host "`n` `n` `n` `n $User1 has these groups that $User2 does not have:"
    $arrayComparatif | Select-Object name, description  # Display the groups that User1 has but User2 does not
}

function search_AD_Group {
    <#
    ------------ This script allows finding the presence of a word in the description or name of an AD group ------------
    #>

    $reponse = Read-Host "`n `n Write the word to search in the description or name of the groups"
    # Search for groups whose description contains the word
    $description = Get-ADGroup -Filter "description -like '*$reponse*'" -Properties * | Select-Object Name, Description
    # Search for groups whose name contains the word
    $nom_de_groupe = Get-ADGroup -Filter "name -like '*$reponse*'" -Properties * | Select-Object Name, Description

    if ( ([string]::IsNullOrEmpty($description)) -and ([string]::IsNullOrEmpty($nom_de_groupe)) ) {
        Write-Host "There are no groups with $reponse in the name or description"
    } else {
        Write-Host "There are the following group(s) with $reponse in the name and description"
        $nom_de_groupe  # Display the groups whose name contains the word
        $description    # Display the groups whose description contains the word
    }
}

# Call the main function to ask the user the question
question
