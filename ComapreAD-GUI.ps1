# Ajouter les types nécessaires pour utiliser les formulaires Windows
Add-Type -AssemblyName System.Windows.Forms

# Fonction pour comparer les groupes AD de deux utilisateurs
function Compare-ADUserGroups {
    param (
        [string]$User1,  # Paramètre pour le premier utilisateur
        [string]$User2   # Paramètre pour le second utilisateur
    )

    # Récupérer les groupes de l'utilisateur 1
    $user1Groups = Get-ADUser -Identity $User1 -Properties MemberOf | Select-Object -ExpandProperty MemberOf
    # Récupérer les groupes de l'utilisateur 2
    $user2Groups = Get-ADUser -Identity $User2 -Properties MemberOf | Select-Object -ExpandProperty MemberOf

    # Trouver les groupes communs aux deux utilisateurs
    $commonGroups = $user1Groups | Where-Object { $user2Groups -contains $_ }
    # Trouver les groupes spécifiques à l'utilisateur 1
    $user1SpecificGroups = $user1Groups | Where-Object { $user2Groups -notcontains $_ }
    # Trouver les groupes spécifiques à l'utilisateur 2
    $user2SpecificGroups = $user2Groups | Where-Object { $user1Groups -notcontains $_ }

    # Fonction pour formater les groupes
    function Format-Groups {
        param (
            [string]$title,       # Titre de la section
            [array]$groups,       # Liste des groupes à formater
            [string]$groupType    # Type de groupe (commun, spécifique à user1, spécifique à user2)
        )

        $output = "${title}:`n"  # Initialiser la sortie avec le titre
        if ($groups) {  # Vérifier si des groupes existent
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
            $output += "Aucun groupe trouvé.`n"
            $output += "--------------------------------------------------`n"
        }
        return $output  # Retourner la sortie formatée
    }

    # Formatage des résultats avec séparateurs
    $results = Format-Groups -title "GROUPES COMMUNS" -groups ($commonGroups | ForEach-Object { Get-ADGroup -Identity $_ | Select-Object -ExpandProperty Name }) -groupType "common"
    # Séparateur entre les groupes communs et spécifiques
    $results += "`n--------------------------------------------------`n"
    $results += (Format-Groups -title "GROUPES SPECIFIQUES A ${User1}" -groups ($user1SpecificGroups | ForEach-Object { Get-ADGroup -Identity $_ | Select-Object -ExpandProperty Name }) -groupType "user1")
    # Séparateur entre les groupes spécifiques de l'utilisateur 1 et de l'utilisateur 2
    $results += "`n--------------------------------------------------`n"
    $results += (Format-Groups -title "GROUPES SPECIFIQUES A ${User2}" -groups ($user2SpecificGroups | ForEach-Object { Get-ADGroup -Identity $_ | Select-Object -ExpandProperty Name }) -groupType "user2")

    return $results  # Retourner les résultats formatés
}

# Créer le formulaire principal
$form = New-Object System.Windows.Forms.Form
$form.Text = "Comparateur de Groupes AD"  # Titre du formulaire
# Hauteur augmentée pour accueillir la boîte de sortie
$form.Size = New-Object System.Drawing.Size(500,500)
$form.StartPosition = "CenterScreen"  # Positionner le formulaire au centre de l'écran

# Créer et ajouter le label pour l'utilisateur 1
$label1 = New-Object System.Windows.Forms.Label
$label1.Location = '10,20'  # Position du label
$label1.Size = '200,20'     # Taille du label
$label1.Text = "Utilisateur 1 (SamAccountName):"  # Texte du label
$form.Controls.Add($label1)  # Ajouter le label au formulaire

# Créer et ajouter la boîte de texte pour l'utilisateur 1
$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Location = '220,20'  # Position de la boîte de texte
$textBox1.Size = '200,20'      # Taille de la boîte de texte
$form.Controls.Add($textBox1)  # Ajouter la boîte de texte au formulaire

# Créer et ajouter le label pour l'utilisateur 2
$label2 = New-Object System.Windows.Forms.Label
$label2.Location = '10,60'  # Position du label
$label2.Size = '200,20'     # Taille du label
$label2.Text = "Utilisateur 2 (SamAccountName):"  # Texte du label
$form.Controls.Add($label2)  # Ajouter le label au formulaire

# Créer et ajouter la boîte de texte pour l'utilisateur 2
$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Location = '220,60'  # Position de la boîte de texte
$textBox2.Size = '200,20'      # Taille de la boîte de texte
$form.Controls.Add($textBox2)  # Ajouter la boîte de texte au formulaire

# Créer et ajouter le bouton de comparaison
$button = New-Object System.Windows.Forms.Button
$button.Location = '150,100'  # Position du bouton
$button.Size = '200,30'       # Taille du bouton
$button.Text = "Comparer"     # Texte du bouton
$button.Add_Click({
    $result = Compare-ADUserGroups -User1 $textBox1.Text -User2 $textBox2.Text  # Appeler la fonction de comparaison
    $outputBox.Text = $result  # Afficher le résultat dans la boîte de sortie
})
$form.Controls.Add($button)  # Ajouter le bouton au formulaire

# Créer la boîte de sortie et l'ajouter au formulaire
$outputBox = New-Object System.Windows.Forms.RichTextBox
# Placée sous les autres contrôles
$outputBox.Location = '10,150'  # Position de la boîte de sortie
# Taille ajustée pour s'adapter au formulaire
$outputBox.Size = '460,300'
$outputBox.Multiline = $true  # Activer le mode multiligne
$outputBox.ScrollBars = "Vertical"  # Ajouter une barre de défilement verticale
$form.Controls.Add($outputBox)  # Ajouter la boîte de sortie au formulaire

# Afficher le formulaire
$form.ShowDialog()
