#    ----------------------------------------- Appuyer sur F5 pour lancer le script -----------------------------------------
cls











function question
{
<#



    ------------ Ce script permet de nour poser une question et d'éxécuter un des deux scripts suivants ------------



    #>
$compare_txt = 
$question = Read-Host "Bonjour, que souhaitez vous faire :`n
- Taper 1 pour comparer les groupes AD de deux utilisateurs :`n
- Taper 2 pour rechercher un groupe AD depuis sa descriptions ou son nom "

If ($question -ne $null )
{
If($question -eq 1)
{

Compare_AD_Group

}
If($question -eq 2)
{
search_AD_Group
}
}
}


function Compare_AD_Group
{
     <#



    ------------ Ce script permet de comparer les groupes AD d'un user2 par rapport à un user1 ------------



    #>



$User1 = Read-Host "`n `n Quel est l'utilisateur qui possede les droits actuellement (forme : pmaillard) ?"
$User2 = Read-Host "Quel est l'utilisateur a qui il manque des droits actuellement (forme : sanne) ?"

$arraytableau = Get-ADPrincipalGroupMembership $User1 | Get-ADGroup -Properties * | select name, description
$arraytableau2 = Get-ADPrincipalGroupMembership $User2 | Get-ADGroup -Properties * | select name, description


$arrayComparatif = Compare-Object $arraytableau $arraytableau2 -Property name,description |Where{$_.SideIndicator -eq "<="}


Write-Host "`n` `n` `n` `n` $User1 a ces groupes que $user2 n'a pas :"
$arrayComparatif | Select-Object name,description
}


Function search_AD_Group
{
     <#



    ------------ Ce script permet de retrouver la présence d'un mot dans la description, le nom d'un groupe AD ------------



    #>



$reponse = Read-Host "`n `n Ecrire le mot a chercher dans la description ou le nom des groupes"
$description = get-adgroup -filter "description -like '*$reponse*'" -Properties *| select Name,Description
$nom_de_groupe = get-adgroup -filter "name -like '*$reponse*'" -Properties *| select Name,Description

if ( ([string]::IsNullOrEmpty($description)) -and ([string]::IsNullOrEmpty($nom_de_groupe)) ) 
    {
    Write-Host "Il n'y a pas de groupe avec $reponse dans le nom ou la description"
    } 

else
    {
    Write-Host "Il y a ce(s) groupe(s) avec $reponse dans le nom et la description"
    $nom_de_groupe
    $description
    }

}

question