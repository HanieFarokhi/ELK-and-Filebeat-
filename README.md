### Install and config ELK

![alt text](image-1.png)

## 1-	Update System Packages:
First, ensure your system packages are up to date:

    sudo apt update
    sudo apt upgrade

## 2-	Install Java:
ELK Stack relies on Java, so install the OpenJDK 11 package:

sudo apt install openjdk-11-jdk

## 3-	Installing Elasticsearch

•	Import the Elasticsearch PGP Key
               Download and install the public signing key:

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

•	Installing from the APT repository
You may need to install the apt-transport-https package on Debian before proceeding:

sudo apt-get install apt-transport-https

echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list

•	You can install the Elasticsearch Debian package with

s sudo apt-get update && sudo apt-get install elasticsearch


•	We go to vim /etc /elasticsearch /elasticsearch.yml and make the settings as shown:

 

•	Start and Enable Elasticsearch:

sudo systemctl daemon-reload
sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch

•	Now testing elasticsearch:

Curl http://localhost:9200   or curl http://serverIp:9200

## 4-	Install Kibana:
install the visualization and data exploration component:

sudo apt install kibana

		
•	Configure Kibana ( vim /etc/kibana/kibana.yml ):

 

•	Start and Enable Kibana:

sudo systemctl daemon-reload
sudo systemctl start kibana
sudo systemctl enable kibana

•	Test Kibana:

http://localhost:5601 or http://serverIp:5601

## 5-	Install Logstash:
Logstash dynamically ingests, transforms, and ships your data regardless of format or complexity. Derive structure from unstructured data with grok, decipher geo coordinates from IP addresses, anonymize or exclude sensitive fields, and ease overall processing.

              sudo apt install logstash

•	Config logstash ( vim /etc/logstash/logstash.yml):

Uncomment :
     
        api.enabled: true
        api.http.host: 0.0.0.0

•	Start and Enable logstash:

sudo systemctl start logstash 
sudo systemctl enable logstash


