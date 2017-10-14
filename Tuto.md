# Initialisation d'un Cluster Hadoop

## Téléchargement
https://hadoop.apache.org/releases.html

**Pour la version 2.8.1** 

http://apache.crihan.fr/dist/hadoop/common/hadoop-2.8.1/hadoop-2.8.1.tar.gz
## Préparation sur un Systeme Debian 
Liste des éléments a installer :

* java [Choisir une version](https://wiki.apache.org/hadoop/HadoopJavaVersions) 
* SSH
* pdsh (Permet d’exécuter des commandes Shell en parallèle sur un ensemble de systèmes)

[Référence 1 ](http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SingleCluster.html)
### création de d'utilisateurs
On crée un utilisateur dédié pour hadoop (un groupe Hadoop et un utilisateur hduser)

## Installation 
on va décompresser Hadoop dans le répertoire /opt/hadoop
> /opt est l'emplacement désigné pour les logiciels propriétaires .

### Préparation du cluster
On détermine la JAVA_HOME
> readlink -f /usr/bin/java | sed "s:bin/java::"

On modifie le fichier /opt/hadoop/[]/etc/hadoop/hadoop-env.sh ligne 25
> export JAVA_HOME=/usr/java/latest
  
