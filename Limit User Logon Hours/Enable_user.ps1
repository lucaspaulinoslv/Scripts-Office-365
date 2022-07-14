$user = "Informe_o_email"
$PWord = Get-Content "C:\scripts\pw.txt"| ConvertTo-SecureString
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $PWord

connect-Msolservice -Credential $Credential

Import-Csv Caminho_do_csv | ForEach {Set-MsolUser - UserPrincipalName $_.name -bockCredential $false}