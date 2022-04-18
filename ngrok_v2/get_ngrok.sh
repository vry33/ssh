rm -rf ngrok ngrok.zip ng.sh > /dev/null 2>&1
echo "======================="
echo "Download ngrok"
echo "======================="
wget -q -c -nc -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
unzip -qq -n ngrok.zip > /dev/null 2>&1
read -p "Paste Ngrok Authtoken: " CRP
./ngrok authtoken $CRP
