param ([string] $password)
# Even though we connect to WinRM as "Administrator", internally WinRM uses the "Network Service" account. Therefore trying to import the certificate to
# Cert:\CurrentUser\My fails:
#
# <https://social.technet.microsoft.com/Forums/en-US/a07dab5a-3ad2-4982-84c1-28f7d4ba77f9/import-certificate-into-certcurrentusermy>
#
Import-PfxCertificate -FilePath C:\Windows\Temp\authenticode.pfx -CertstoreLocation Cert:\LocalMachine\My -Password (ConvertTo-SecureString -String $password -Force -AsPlainText)
