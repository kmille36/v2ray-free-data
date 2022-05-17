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
	sudo yum install -y docker docker.io
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
