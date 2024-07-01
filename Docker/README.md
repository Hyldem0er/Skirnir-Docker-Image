# Skirnir Under Docker 

### Install curl and git on your system  

```
git clone https://github.com/Hyldem0er/Skirnir && cd Skirnir/Docker && chmod +x docker-install.sh && ./docker-install.sh && docker-compose build && docker exec -it Skirnir sudo python3 ../Skirnir/main.py --ui
```

### install on debian or ubuntu in one line  
```
apt-get install curl git -y && git clone https://github.com/Hyldem0er/Skirnir && cd Skirnir/Docker && chmod +x docker-install.sh && ./docker-install.sh && docker-compose build && docker exec -it Skirnir sudo python3 ../Skirnir/main.py --ui
```

### Launching Skirnir  
```
docker exec -it Skirnir sudo python3 ../Skirnir/main.py --ui
```

## On windows 
#### With Administrator rights  
```
Invoke-WebRequest -Uri https://raw.githubusercontent.com/Hyldem0er/Skirnir/master/Docker/win-install.ps1 -OutFile .\win-install.ps1
```
```
powershell -noexit -ExecutionPolicy Bypass -File .\win-install.ps1
```


when you're on your debian under wsl, you'll need to create a user with a password, after which you can run the same one-line command as the debian installation.  
