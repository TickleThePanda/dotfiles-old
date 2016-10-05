if hash powershell 2>/dev/null; then
  powershell -Command ./fonts/install.ps1
else
  ./fonts/install.sh
fi
