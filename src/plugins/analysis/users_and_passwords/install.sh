#!/usr/bin/env bash

cd "$( dirname "${BASH_SOURCE[0]}" )" || exit 1

echo "------------------------------------"
echo "     install password cracker       "
echo "------------------------------------"

sudo -EH pip3 install --upgrade git+https://gitee.com/litinghui/common_helper_passwords.git || exit 1
# sudo -EH pip3 install --upgrade git+https://github.com/fkie-cad/common_helper_passwords.git || exit 1

# installing JohnTheRipper
sudo apt-get install -y john || exit 1

if [[ $(lsb_release -i) == *"Debian" ]]
then
	# link to path since debian does not include /usr/sbin
	sudo ln -s /usr/sbin/john /usr/local/bin || exit 1
fi

# Add common credentials
(
	cd internal
	(
		cd passwords		
		wget -N https://raw.githubusercontent.com/danielmiessler/SecLists/f9c1ec678c1cae461f1dc8b654ceb6719fd03d33/Passwords/Common-Credentials/10k-most-common.txt
# 		wget -N http://112.126.82.245/files/10k-most-common.txt
	)
	python3 update_password_list.py
) || exit 1

exit 0

