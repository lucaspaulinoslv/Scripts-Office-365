﻿$user = "admin@contoso.com.br" #INforme o email do administrador global
$PWord = Get-Content "C:\scripts\pw.txt"| ConvertTo-SecureString #Informe o arquivo criado no pw.ps1 | descriptografa a senha 
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $PWord #cria uma instância de um objeto

connect-Msolservice -Credential $Credential #Conecta no portal do office usando as credenciais declaradas acma
#Necessario criar um arquivo csv com os e-mails que serão bloqueados
#name
#teste01@contoso.com.br
#teste02@contoso.com.br
Import-Csv Caminho_do_csv | ForEach-Object {Set-MsolUser - UserPrincipalName $_.name -bockCredential $true} #Usa o csv para veificar quais nomes serão bloqueados 

connect-azureAD -credential $Credential #Conecta no azure com as credenciais declaradas acima
import-Csv "C:\scripts\email.csv" | ForEach-Object {Get-azureADUser -SearchString $_.name | Revoke-AzureADUserAllRefreshToken} #Revoga a sessão de todos usuarios declarados no csv forçando o logoff