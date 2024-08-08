#!/bin/bash

echo "desconetando da conta anterior..."
SUSEConnect --cleanup

echo "registrando nova conta..."

sudo SUSEConnect -e ti@av.eti.br -r 0C1B11469524B8EF

echo "instalando Wazuh..."

curl -o wazuh-agent-4.8.0-1.x86_64.rpm https://packages.wazuh.com/4.x/yum/wazuh-agent-4.8.0-1.x86_64.rpm && sudo WAZUH_MANAGER='security-demetraplatform.demetrati.com.br' WAZUH_AGENT_GROUP='DemetraPlatform' rpm -ihv wazuh-agent-4.8.0-1.x86_64.rpm

sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent

echo "Wazuh instalado com sucesso..."

echo "instalando Bitdefender..."

tar xvpf installer.tar

chmod +x installer

./installer

echo "Bitdefender instalado com sucesso..."

echo "instalando Netwall..."

tar xvpf UnitPlatformDirectAgent-opensuse.tar.gz

cd UnitPlatformDirectAgent-Installer

zypper install openssl-devel -y

./install.sh

echo "desconectando da conta SUSE..."
SUSEConnect --cleanup

echo "Liberando porta 8970 no firewall..."

firewall-cmd --zone=public --add-port=8970/tcp --permanent
firewall-cmd --reload

echo "Instalacao dos agentes realizada com sucesso!!!"
sleep 2


