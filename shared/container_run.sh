echo "- -- --- Téléchargement de Hadoop --- -- -"
file="/shared/hadoop-2.8.1.tar.gz"
if [ ! -f "$file" ]
then
	curl http://apache.crihan.fr/dist/hadoop/common/hadoop-2.8.1/hadoop-2.8.1.tar.gz  -o data/hadoop-2.8.1.tar.gz
fi
echo "- -- --- Extraction de Hadoop --- -- -"
cd
tar xf /shared/hadoop-2.8.1.tar.gz
sudo mv hadoop-2.8.1 /opt/hadoop/

echo "- -- --- Preparation du Systeme --- -- -"
sudo apt-get update
echo "- -- Installation de Java -- -" # preconisation version de java8 : https://wiki.apache.org/hadoop/HadoopJavaVersions
sudo apt-get install -y default-jdk
sudo apt-get install -y ssh
sudo apt-get install -y pdsh

echo "- -- initialisation des variable d'environment -- -"
#/opt/hadoop/etc/hadoop/hadoop-env.sh
#rempalcement de java home par /usr/bin/java
