rm -rf ngrok ngrok.zip main.sh > /dev/null 2>&1
wget -O ng.sh https://raw.githubusercontent.com/vry33/ssh/main/ngrok_v2/get_ngrok.sh > /dev/null 2>&1
chmod +x ng.sh
./ng.sh
clear
./ngrok tcp 22 &>/dev/null &
echo "======================="
echo Updating Please Wait
echo "======================="
sudo apt update > /dev/null 2>&1
sudo apt install openssh-server > /dev/null 2>&1
pasw=$(</dev/urandom tr -dc _A-Z-a-z-0-9 | head -c12)
echo $passw | passwd
mkdir -p /var/run/sshd
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "LD_LIBRARY_PATH=/usr/lib64-nvidia" >> /root/.bashrc
echo "export LD_LIBRARY_PATH" >> /root/.bashrc
sudo service ssh start
echo "===================================="
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo create root password
echo $pasw
#passwd
echo "===================================="