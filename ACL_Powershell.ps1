# ----------------------------------------- Appuyer sur F5 pour lancer le script -----------------------------------------
cls  # Nettoyer la console

function question {
    <#
    ------------ Ce script permet de nous poser une question et d'exécuter un des deux scripts suivants ------------
    #>

    $compare_txt = ""  # Variable non utilisée, peut être supprimée
    $question = Read-Host "Bonjour, que souhaitez vous faire :`n
- Taper 1 pour comparer les groupes AD de deux utilisateurs :`n
- Taper 2 pour rechercher un groupe AD depuis sa description ou son nom "

    If ($question -ne $null) {  # Vérifier si une réponse a été donnée
        If ($question -eq 1) {  # Si l'utilisateur tape 1
            Compare_AD_Group  # Appeler la fonction pour comparer les groupes AD
        }
        If ($question -eq 2) {  # Si l'utilisateur tape 2
            search_AD_Group  # Appeler la fonction pour rechercher un groupe AD
        }
    }
}

function Compare_AD_Group {
    <#
    ------------ Ce script permet de comparer les groupes AD d'un user2 par rapport à un user1 ------------
    #>

    $User1 = Read-Host "`n `n Quel est l'utilisateur qui possède les droits actuellement (forme : pmaillard) ?"
    $User2 = Read-Host "Quel est l'utilisateur à qui il manque des droits actuellement (forme : sanne) ?"

    # Récupérer les groupes et leurs descriptions pour User1
    $arraytableau = Get-ADPrincipalGroupMembership $User1 | Get-ADGroup -Properties * | Select-Object name, description
    # Récupérer les groupes et leurs descriptions pour User2
    $arraytableau2 = Get-ADPrincipalGroupMembership $User2 | Get-ADGroup -Properties * | Select-Object name, description

    # Comparer les groupes de User1 et User2 et trouver ceux que User1 a mais pas User2
    $arrayComparatif = Compare-Object $arraytableau $arraytableau2 -Property name, description | Where-Object { $_.SideIndicator -eq "<=" }

    Write-Host "`n` `n` `n` `n $User1 a ces groupes que $User2 n'a pas :"
    $arrayComparatif | Select-Object name, description  # Afficher les groupes que User1 a mais pas User2
}

function search_AD_Group {
    <#
    ------------ Ce script permet de retrouver la présence d'un mot dans la description, le nom d'un groupe AD ------------
    #>

    $reponse = Read-Host "`n `n Écrire le mot à chercher dans la description ou le nom des groupes"
    # Rechercher les groupes dont la description contient le mot
    $description = Get-ADGroup -Filter "description -like '*$reponse*'" -Properties * | Select-Object Name, Description
    # Rechercher les groupes dont le nom contient le mot
    $nom_de_groupe = Get-ADGroup -Filter "name -like '*$reponse*'" -Properties * | Select-Object Name, Description

    if ( ([string]::IsNullOrEmpty($description)) -and ([string]::IsNullOrEmpty($nom_de_groupe)) ) {
        Write-Host "Il n'y a pas de groupe avec $reponse dans le nom ou la description"
    } else {
        Write-Host "Il y a ce(s) groupe(s) avec $reponse dans le nom et la description"
        $nom_de_groupe  # Afficher les groupes dont le nom contient le mot
        $description    # Afficher les groupes dont la description contient le mot
    }
}

# Appeler la fonction principale pour poser la question à l'utilisateur
question
