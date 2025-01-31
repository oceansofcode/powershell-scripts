
[CmdletBinding(PositionalBinding)]
param (
    [Parameter(Mandatory, Position=0)]
    [string]
    $SearchTerm
)

$Urls = @{
    '7.3' = 'https://learn.liferay.com/w/dxp/liferay-development/liferay-internals/reference/7-3-breaking-changes'
    '7.4' = 'https://learn.liferay.com/w/dxp/liferay-development/liferay-internals/reference/7-4-breaking-changes'
    '2024_Q1' = 'https://learn.liferay.com/w/dxp/installation-and-upgrades/upgrading-liferay/reference/deprecations-and-breaking-changes/2024/2024-q1-breaking-changes'
    '2024_Q2' = 'https://learn.liferay.com/w/dxp/installation-and-upgrades/upgrading-liferay/reference/deprecations-and-breaking-changes/2024/2024-q2-breaking-changes'
    '2024_Q3' = 'https://learn.liferay.com/w/dxp/installation-and-upgrades/upgrading-liferay/reference/deprecations-and-breaking-changes/2024/2024-q3-breaking-changes'
    '2024_Q4' = 'https://learn.liferay.com/w/dxp/installation-and-upgrades/upgrading-liferay/reference/deprecations-and-breaking-changes/2024/2024-q4-breaking-changes'
};

foreach ($Url in $Urls.GetEnumerator()) {
    $Res = Invoke-WebRequest $Url.Value
    $Content = $Res.Content -split "`n" | Where-Object {$_ -ne ''}
    $Match = $Content | Select-String $SearchTerm

    if ($Match) {
        Write-Output "$($Url.Key)`n" -ForegroundColor Green
        $Content -replace "<[^>]*>", "" | Select-String $SearchTerm
        Write-Output "`n`n" 
    }
}