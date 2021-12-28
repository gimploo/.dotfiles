#the desktop and workspace path variable are exported from the ~/.bashrc folder.
alias filesystem='df -h'
alias tools='dpkg -l'
alias asiet='cd ~/Documents/ASIET/year2/; clear'
alias course='cd ~/Documents/tutorials/; clear'
alias cwd='pwd|clip.exe'
alias gamer='cd ~/Documents/gameDev/'
alias dumb='cd ~/Documents/dumb-projects'

# Removes trailing \r characters in win files
win2unix() { tr -d '\15\32' < $1 > $2 && echo "Successfully created $2 file!" || echo "Failed"; }

# Calling windows executables
alias wordpad='/mnt/c/Program\ Files/Windows\ NT/Accessories/wordpad.exe'
alias love='love.exe'
alias cmd='cmd.exe'
alias cls='clear'
alias chrome='chrome.exe'
alias spotify='cmd.exe /c spotify'
alias java='java.exe'
alias javac='javac.exe'
alias open='explorer.exe'
alias notepad='notepad.exe'
alias token='cat ~/.git/.git_token | clip.exe && echo "git token copied to clipboard"'
alias clip='clip.exe'

# Hardware simulator 
alias Hard='cmd /c "C:\Users\Gokul\OneDrive\Documents\tutorials\coursera\Build a Modern Computer from first principles\nand2tetris\tools\HardwareSimulator.bat" '

# Compiling c files for windows x86-64 bit
alias cl='cmd.exe /k "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x64'
#alias vscmd='cmd.exe /k "C:\Users\Gokul\OneDrive\Documents\gameDev\HandmadeHero\misc\shell.bat" && cls'

