# This simple script activates the TerminalServer as a standalone server

function _ActivateTSServer([string]$firstName,[string]$lastName,[string]$Company,[tring]$CountryRegion) {
    # $CountryRegion must be exactly like in the UI
    
    $TSwmi = Get-WmiObject -Class Win32_TSLicenseServer
    
    $TSwmi.FirstName = $firstName;
    $TSwmi.LastName = $lastName;
    $TSwmi.Company = $Company;
    $TSwmi.CountryRegion = $CountryRegion;

    try {
        $TSwmi.Put(); # save        
    }
    catch {
        Write-Host "Error saving contact informations. Please have verify your parameters..."
    }
    
    $wmiResult = Invoke-WmiMethod -Path Win32_TSLicenseServer -Name ActivateServerAutomatic -ComputerName localhost

    if ($wmiResult.ReturnValue -eq 0) 
    {
        Write-Host "The Remote Desktop license server is activated." -ForegroundColor Green
    } 
    elseif ($wmiResult.ReturnValue -eq 1) 
    {
        Write-Host "The Remote Desktop license server could not be activated." -ForegroundColor Red
    } 
    else {
        Write-Host "An unknown error occurred. It is not known whether the Remote Desktop license server is activated." -ForegroundColor DarkRed
    }
}
