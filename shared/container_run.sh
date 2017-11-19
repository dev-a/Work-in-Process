echo "- -- --- Téléchargement de Hadoop --- -- -"
file="/shared/hadoop-2.9.0.tar.gz"
if [ ! -f "$file" ]
then
	curl http://apache.crihan.fr/dist/hadoop/common/hadoop-2.9.0/hadoop-2.9.0.tar.gz  -o data/hadoop-2.9.0.tar.gz
fi
echo "- -- --- Extraction de Hadoop --- -- -"
cd
tar xf /shared/hadoop-2.9.0.tar.gz
sudo mv hadoop-2.9.0 /opt/hadoop/

echo "- -- --- Preparation du Systeme --- -- -"
sudo apt-get update
echo "- -- Installation de Java -- -" # preconisation version de java8 : https://wiki.apache.org/hadoop/HadoopJavaVersions
sudo apt-get install -y default-jdk
sudo apt-get install -y ssh
sudo apt-get install -y pdsh
sudo apt-get install -y rsync
exit
echo "- -- edition du fichier etc/hadoop/hadoop-env.sh-- -"
my_java_home=$(readlink -f /usr/bin/java | sed "s:bin/java::")
sed -i -e "s|export JAVA_HOME=\${JAVA_HOME}|export JAVA_HOME=${my_java_home}|g" /opt/hadoop/etc/hadoop/hadoop-env.sh

echo "- -- edition du fichier etc/hadoop/core-site.xml -- -"
file="/opt/hadoop/etc/hadoop/core-site.xml.bak"
if [ ! -f "$file" ]
then
  cp /opt/hadoop/etc/hadoop/core-site.xml /opt/hadoop/etc/hadoop/core-site.xml.bak
fi
cd /opt/hadoop/etc/hadoop/
head -n -2 core-site.xml > tmp.txt
cat tmp.txt >  core-site.xml && rm tmp.txt
echo "<configuration>" >> core-site.xml
echo "    <property>" >> core-site.xml
echo "        <name>fs.defaultFS</name>" >> core-site.xml
echo "        <value>hdfs://localhost:9000</value>" >> core-site.xml
echo "    </property>" >> core-site.xml
echo "</configuration>" >> core-site.xml

echo "- -- edition du fichier etc/hadoop/hdfs-site.xml -- -"
file="/opt/hadoop/etc/hadoop/hdfs-site.xml.bak"
if [ ! -f "$file" ]
then
  cp /opt/hadoop/etc/hadoop/hdfs-site.xml /opt/hadoop/etc/hadoop/hdfs-site.xml.bak
fi
cd /opt/hadoop/etc/hadoop/
head -n -3 hdfs-site.xml > tmp.txt
cat tmp.txt >  hdfs-site.xml && rm tmp.txt
echo "<configuration>" >> hdfs-site.xml
echo "    <property>" >> hdfs-site.xml
echo "        <name>dfs.replication</name>" >> hdfs-site.xml
echo "        <value>1</value>" >> hdfs-site.xml
echo "    </property>" >> hdfs-site.xml
echo "</configuration>" >> hdfs-site.xml


echo "- -- configuration client ssh -- -"
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys


echo "- -- -- -"
/opt/hadoop/bin/hdfs namenode -format
/opt/hadoop/sbin/start-dfs.sh

/opt/hadoop/bin/hdfs dfs -mkdir /user
/opt/hadoop/bin/hdfs dfs -mkdir /user/hduser
#/opt/hadoop/bin/hdfs dfs -put /opt/hadoop/etc/hadoop input
#/opt/hadoop/bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.9.0.jar grep input output 'dfs[a-z.]+'
 /opt/hadoop/bin/hadoop jar /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.9.0.jar grep input output 'dfs[a-z.]+'
echo "- -- initialisation des variable d'environment -- -"
#echo "alias youralias='yourcmd'" >> /home/user/.bashrc

echo "- -- creation d'un utilisateur dédié : On crée l'utiliser hduser et le groupe hadoop -- -"
#sudo addgroup hadoop
#sudo adduser --ingroup hadoop hduser
#changement du proprietaire de dossier hadoop
#sudo chown -R hduser:hadoop /opt/hadoop
#/etc/hadoop/hadoop-env.sh
#/opt/hadoop/etc/hadoop/hadoop-env.sh
#rempalcement de java home par /usr/bin/java
