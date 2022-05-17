clear
echo "Script by fb.com/thuong.hai.581"
echo "Hỗ trợ: Ubuntu/Centos"
echo "Đang dừng v2ray server"
sudo docker kill v2ray
echo "Đang nhận diện distro linux"
dist=$(hostnamectl | egrep "Operating System" | cut -f2 -d":" | cut -f2 -d " ")
if [ $dist = "CentOS" ] ; then
	echo "Bạn đang sử dụng CentOS"
	sleep 1
        echo "Đang gỡ cài đặt phần mềm cần thiết"
        sudo yum remove -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
        clear
        echo "Đang bật firewall"
        sudo systemctl start firewalld
        sudo systemctl enable firewalld
        clear
elif [ $dist = "Ubuntu" -o $dist = "Debian" ] ; then
      	echo "Bạn đang sử dụng Ubuntu"
      	sleep 1
      	echo "Đang gỡ đặt phần mềm cần thiết"
	sudo apt remove -y docker docker.io
        clear
	echo "Đang bật firewall"
        sudo ufw enable
        clear
fi
echo "Xong!!!"
