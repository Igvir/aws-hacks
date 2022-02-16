REM List buckets only from a certain region using the CLI

 if($region -eq $null){ Set-Variable -name region -value 'us-west-2' }
 Write-Output "Buckets in $region" "------------------------------------"
 aws s3api list-buckets --output json |  jq .Buckets[].Name | 
 foreach-object { 
    Set-Variable -name bname -value $_
    aws s3api get-bucket-location --bucket $_  
    } | 
 foreach-object{ if($region -eq $_) { Write-Output $bName } } 
 
