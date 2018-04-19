function prompt { return "PS [$(get-date)] [$($pwd)]`r`n> " }

function fxTestUntilFailure {
    $cnt = 0
    while ($?) {
        $cnt++
        /home/pc/s/corefx/Tools/msbuild.sh /t:Test /p:ForceRunTests=True /p:Outerloop=True # /p:XunitOptions="-method System.Net.Http.Functional.Tests.PlatformHandler_HttpClientHandler_DangerousAcceptAllCertificatesValidator_Test.SetDelegate_ConnectionSucceeds"
    }

    "`n$cnt runs before error.`n"
}

function fxTestLoop {
    $cnt = 0
    while ($true) {
        $cnt++
        /home/pc/s/corefx/Tools/msbuild.sh /t:Test /p:ForceRunTests=True /p:Outerloop=True # /p:XunitOptions="-method System.Net.Http.Functional.Tests.PlatformHandler_HttpClientHandler_DangerousAcceptAllCertificatesValidator_Test.SetDelegate_ConnectionSucceeds"
        if (-not $?) {
            if (Test-Path /home/pc/s/corefx/bin/tests/System.Net.Http.Functional.Tests/netcoreapp-Linux-Debug-x64/testResults.xml) {
                cp /home/pc/s/corefx/bin/tests/System.Net.Http.Functional.Tests/netcoreapp-Linux-Debug-x64/testResults.xml "./testResults-$cnt.xml"
            }
        }
    }

    "`n$cnt runs before error.`n"
}
