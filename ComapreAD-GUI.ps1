# Ajouter les types necessaires pour utiliser les formulaires Windows
Add-Type -AssemblyName System.Windows.Forms

# Fonction pour comparer les groupes AD de deux utilisateurs
function Compare-ADUserGroups {
    param (
        [string]$User1,
        [string]$User2
    )

    # Recuperer les groupes de l'utilisateur 1
    $user1Groups = Get-ADUser -Identity $User1 -Properties MemberOf | Select-Object -ExpandProperty MemberOf
    # Recuperer les groupes de l'utilisateur 2
    $user2Groups = Get-ADUser -Identity $User2 -Properties MemberOf | Select-Object -ExpandProperty MemberOf

    # Trouver les groupes communs aux deux utilisateurs
    $commonGroups = $user1Groups | Where-Object { $user2Groups -contains $_ }
    # Trouver les groupes specifiques a l'utilisateur 1
    $user1SpecificGroups = $user1Groups | Where-Object { $user2Groups -notcontains $_ }
    # Trouver les groupes specifiques a l'utilisateur 2
    $user2SpecificGroups = $user2Groups | Where-Object { $user1Groups -notcontains $_ }

    # Fonction pour formater les groupes
    function Format-Groups {
        param (
            [string]$title,
            [array]$groups,
            [string]$groupType
        )

        $output = "${title}:`n"
        if ($groups) {
            $output += "--------------------------------------------------`n"
            foreach ($group in $groups) {
                # Ajouter en gras pour les groupes communs
                if ($groupType -eq "common") {
                    $output += "**$group**`n"
                } elseif ($groupType -eq "user1") {
                    $output += "$group`n"
                } elseif ($groupType -eq "user2") {
                    $output += "$group`n"
                }
            }
        } else {
            $output += "Aucun groupe trouve.`n"
            $output += "--------------------------------------------------`n"
        }
        return $output
    }

    # Formatage des resultats avec separateurs
    $results = Format-Groups -title "GROUPES COMMUNS" -groups ($commonGroups | ForEach-Object { Get-ADGroup -Identity $_ | Select-Object -ExpandProperty Name }) -groupType "common"
	# Separateur entre les groupes communs et specifiques
    $results += "`n--------------------------------------------------`n"  
    $results += (Format-Groups -title "GROUPES SPECIFIQUES A ${User1}" -groups ($user1SpecificGroups | ForEach-Object { Get-ADGroup -Identity $_ | Select-Object -ExpandProperty Name }) -groupType "user1")
	# Separateur entre les groupes specifiques de l'utilisateur 1 et de l'utilisateur 2
    $results += "`n--------------------------------------------------`n"  
    $results += (Format-Groups -title "GROUPES SPECIFIQUES A ${User2}" -groups ($user2SpecificGroups | ForEach-Object { Get-ADGroup -Identity $_ | Select-Object -ExpandProperty Name }) -groupType "user2")

    return $results
}

# Creer le formulaire principal
$form = New-Object System.Windows.Forms.Form
$form.Text = "Comparateur de Groupes AD"
# Hauteur augmente pour accueillir la boite de sortie
$form.Size = New-Object System.Drawing.Size(500,500)  
$form.StartPosition = "CenterScreen"

# Creer et ajouter le label pour l'utilisateur 1
$label1 = New-Object System.Windows.Forms.Label
$label1.Location = '10,20'
$label1.Size = '200,20'
$label1.Text = "Utilisateur 1 (SamAccountName):"
$form.Controls.Add($label1)

# Creer et ajouter la boite de texte pour l'utilisateur 1
$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = '220,20'
$textBox1.Size = '200,20'
$form.Controls.Add($textBox1)

# Creer et ajouter le label pour l'utilisateur 2
$label2 = New-Object System.Windows.Forms.Label
$label2.Location = '10,60'
$label2.Size = '200,20'
$label2.Text = "Utilisateur 2 (SamAccountName):"
$form.Controls.Add($label2)

# Creer et ajouter la boite de texte pour l'utilisateur 2
$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = '220,60'
$textBox2.Size = '200,20'
$form.Controls.Add($textBox2)

# Creer et ajouter le bouton de comparaison
$button = New-Object System.Windows.Forms.Button
$button.Location = '150,100'
$button.Size = '200,30'
$button.Text = "Comparer"
$button.Add_Click({
    $result = Compare-ADUserGroups -User1 $textBox1.Text -User2 $textBox2.Text
    $outputBox.Text = $result
})
$form.Controls.Add($button)

# Creer la boite de sortie et l'ajouter au formulaire
$outputBox = New-Object System.Windows.Forms.RichTextBox
# Placee sous les autres controles
$outputBox.Location = '10,150'
# Taille ajustee pour s'adapter au formulaire
$outputBox.Size = '460,300'  
$outputBox.Multiline = $true
$outputBox.ScrollBars = "Vertical"
$form.Controls.Add($outputBox)

# Afficher le formulaire
$form.ShowDialog()
