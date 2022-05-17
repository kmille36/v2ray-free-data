clear
echo "Script by fb.com/thuong.hai.581"
echo "Hỗ trợ: Ubuntu/Centos"
echo "Đang nhận diện distro linux"
dist=$(hostnamectl | egrep "Operating System" | cut -f2 -d":" | cut -f2 -d " ")
if [ $dist = "CentOS" ] ; then
	echo "Bạn đang sử dụng CentOS"
	sleep 1
        echo "Đang update hệ thống"
	sudo yum update -y
        clear
	echo" Đang cài đặt phần mềm cần thiết"
	sudo yum install -y yum-utils
	sudo yum-config-manager \
          --add-repo \
          https://download.docker.com/linux/centos/docker-ce.repo
	sudo yum -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
        clear
        echo "Đang tắt firewall"
        sudo systemctl stop firewalld
        sudo systemctl disable firewalld
        clear
elif [ $dist = "Ubuntu" -o $dist = "Debian" ] ; then
	echo "Bạn đang sử dụng Ubuntu"
	sleep 1
        echo "Đang update hệ thống"
	sudo apt-get update -y
        clear
	echo "Đang cài đặt phần mềm cần thiết"
	sudo apt install -y docker docker.io
        clear
	echo "Đang tắt firewall"
        sudo ufw disable
        clear
fi
echo "Đang khởi tạo server V2ray"
sudo docker run --name v2ray -d -p 80:8081 thuonghai2711/v2ray-azure-web:latest
clear
IP=$(curl -s ifconfig.me)
echo "Đang kiểm tra kết nối tới v2ray server (đảm bảo VPS đã mở port 80)"
sleep 2
echo -n "- Đang khởi tạo kết nối: " && if curl -s --connect-timeout 1 $IP | grep -q Bad; then echo -e "$(tput setaf 2)ONLINE - Ping thành công đến IP$(tput sgr0)"; else echo -e "$(tput setaf 1)OFFLINE - Không thể Ping đến IP, vui lòng mở port 80$(tput sgr0)"; fi
echo "Thành công, sau đây là thông tin v2ray, vui lòng sử dụng nó để điền vào ứng dụng v2ray"
echo "Address (Địa chỉ): $IP"
echo "Port (Cổng): 80"
echo "UUID(id) (Địa chỉ ID): ba651c8c-cb35-4c46-bf6c-f90bd6f094e3"
echo "AlterID: 64"
echo "Protocol (Kiểu kết nối): WS"
echo "Request host (Yêu cầu host): thay thế 1 trong 2 địa chỉ sau"
echo " + Vietnamobile: vietnamobile.com.vn"
echo " + Viettel: Mijutv.akamaized.net"
echo "Các phần còn lại để mặc định hoặc để trống"
echo "Nếu gặp khó khăn khi nhập thủ công, import vmess này vào (thay 12.34.56.78 = IP VPS: $IP)"
echo " + Vietnamobile: vmess://ew0KICAidiI6ICIyIiwNCiAgInBzIjogInYycmF5LXZpZXRuYW1vYmlsZSIsDQogICJhZGQiOiAiMTIuMzQuNTYuNzgiLA0KICAicG9ydCI6ICI4MCIsDQogICJpZCI6ICJiYTY1MWM4Yy1jYjM1LTRjNDYtYmY2Yy1mOTBiZDZmMDk0ZTMiLA0KICAiYWlkIjogIjY0IiwNCiAgInNjeSI6ICJhdXRvIiwNCiAgIm5ldCI6ICJ3cyIsDQogICJ0eXBlIjogIm5vbmUiLA0KICAiaG9zdCI6ICJ2aWV0bmFtb2JpbGUuY29tLnZuIiwNCiAgInBhdGgiOiAiIiwNCiAgInRscyI6ICIiLA0KICAic25pIjogIiIsDQogICJhbHBuIjogIiINCn0=
"
echo " + Viettel: vmess://ew0KICAidiI6ICIyIiwNCiAgInBzIjogInYycmF5LXZpZXR0ZWwiLA0KICAiYWRkIjogIjEyLjM0LjU2Ljc4IiwNCiAgInBvcnQiOiAiODAiLA0KICAiaWQiOiAiYmE2NTFjOGMtY2IzNS00YzQ2LWJmNmMtZjkwYmQ2ZjA5NGUzIiwNCiAgImFpZCI6ICI2NCIsDQogICJzY3kiOiAiYXV0byIsDQogICJuZXQiOiAid3MiLA0KICAidHlwZSI6ICJub25lIiwNCiAgImhvc3QiOiAiTWlqdXR2LmFrYW1haXplZC5uZXQiLA0KICAicGF0aCI6ICIiLA0KICAidGxzIjogIiIsDQogICJzbmkiOiAiIiwNCiAgImFscG4iOiAiIg0KfQ==
"
