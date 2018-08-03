


# Script to workaround coverlet.msbuild and build-tests -coverage
$selectedProjects = Get-ChildItem src/*/tests/**/*.Tests.csproj -r | Where-Object { ($_.Directory -notmatch 'System.Private.Xml') -and ($_.Name -notmatch 'Performance') }

$selectedProjects | ForEach-Object { 
    Push-Location $_.Directory
    dotnet msbuild /t:Test /p:ForceRunTests=True /p:Coverage=True /p:SkipCoverageReport=true /p:Outerloop=True
    Pop-Location
} | Tee-Object coverage.run.log

# reportgenerator -targetdir:./bin/tests/coverage "-reporttypes:Html;Badges" -reports:./bin/tests/coverage/*.coverlet.xml

# open ./bin/tests/coverage/index.htm
# xdgopen ./bin/tests/coverage/index.htm

