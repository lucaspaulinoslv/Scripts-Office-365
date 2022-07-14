$user = "Informe_o_email"
$PWord = Get-Content "Caminho_do_arquivo_de_senha"| ConvertTo-SecureString
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $PWord

connect-Msolservice -Credential $Credential

Import-Csv Caminho_do_csv | ForEach {Set-MsolUser - UserPrincipalName $_.name -bockCredential $true}

connect-azureAD -credential $Credential
import-Csv "Caminho_do_csv" | % {Get-azureADUser -SearchString $_.name | Revoke-AzureADUserAllRefreshToken}