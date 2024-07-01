$admin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($admin) {
    # check if the script is run with administrator privileges
    Write-Host "You are already administrator - We continue Installation !" -ForegroundColor green
}
else {
    # if the user is not administrator, ask him to run the script with administrator privileges if not, the script will be executed normally
    throw "It's necessary to run the script with administrator privileges !"
    exit
}

function Enablingfeatures {
    # Enable the VirtualMachinePlatform feature and WSL
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
}
function InstallDocker {
    # Install Docker Desktop and start it
    winget.exe install Docker.DockerDesktop -e
    & "C:\Program Files\Docker\Docker\Docker Desktop.exe"
}
function InstallWSL {
    # Set the default version of WSL to 2 update it install debian and start it
    wsl --set-default-version 2
    wsl --update
    wsl --install -d debian
    Start-Process debian
}
Enablingfeatures
InstallDocker
InstallWSL
