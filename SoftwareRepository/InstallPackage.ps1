$packageListName = '\\snapfs\ITSoftware$\SoftwareRepository\package_list.json'
$programs = (Get-Content -Raw -Path $packageListName | ConvertFrom-Json).list
$listOk = @()
$someFailed = $false
$choice = $null

function install{
    param($item)
    $pathhome = "\\snapfs\ITSoftware$\SoftwareRepository\"
    $path = $pathhome+$item
    Start-Process -Wait -FilePath $path -ArgumentList @('/S', "AllUser=1", 'RebootYesNo="No"', "REBOOT=ReallySuppress")
}

function startInstallation{
    try{
            for ($i = 1; $i -le $listOk.length; $i++){
            install($listOk[$i - 1])
        }
    }
    catch{
        Exit
    }
}

foreach($i in $programs){
        $result = Test-Path -Path C:\Software\$i -PathType Leaf
        if($result -eq $true){
            $listOk = $listOk + $i
            $i + ' - ok'
        }else{
            $someFailed = $true
            $i + ' - failed'
        }
    }
    
startInstallation