#  List buckets only from a certain region using the CLI
#  Requires jq https://stedolan.github.io/jq/
#  A jq program is a "filter": it takes an input, and produces an output. 
#  Requires awscli  https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html

 if($null -eq $region){ Set-Variable -name region -value 'us-west-2' }
 Write-Output "Buckets in $region" "---------------------------------"
 aws s3api list-buckets --output json |  jq .Buckets[].Name | 
 foreach-object { 
    Set-Variable -name bname -value $_
    aws s3api get-bucket-location --bucket $_  
    } | 
 foreach-object{ if($region -eq $_) { Write-Output $bName } } 
 
