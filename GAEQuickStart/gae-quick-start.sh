#!/bin/bash

# GDG Basel 2014
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

## Author: Jean-Baptiste Clion (jbclion@gmail.com) For Google Developer Group Basel
## Date: 30/08/2014
## Version 1.0

# Initiate start time
start_time=`date +%s`

echo "\n\n\n"
echo "Installing Java..."
echo "------------------"
echo "\n\n\n"

# Install Java 1.7
wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.tar.gz
sudo mkdir -p /opt/jdk
sudo tar -zxf jdk-7u67-linux-x64.tar.gz -C /opt/jdk
sudo ls /opt/jdk
sudo update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.7.0_67/bin/java 100
sudo update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.7.0_67/bin/javac 100

echo "\n\n\n"
echo "Installing Maven..."
echo "------------------"
echo "\n\n\n"

# Install Maven
sudo mkdir -p /opt/apps/apache-maven-3.1.1
wget http://apache.mirrors.timporter.net/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz
sudo tar -zxf apache-maven-3.1.1-bin.tar.gz -C /opt/apps
export M2_HOME=/opt/apps/apache-maven-3.1.1
export PATH=/opt/apps/apache-maven-3.1.1/bin:${PATH}

echo "\n\n\n"
echo "---------------------------------------"
read -p "Input your Google Cloud Project ID: " gcpid

# Creating Google App Engine Project
mvn archetype:generate -DgroupId=com.gdgbasel.tuto -DartifactId="$gcpid" -Dversion=1.0-SNAPSHOT -DpackageName=com.gdgbasel.tuto -DarchetypeGroupId=com.google.appengine.archetypes -DarchetypeArtifactId=guestbook-archetype -DarchetypeVersion=1.8.4 -DinteractiveMode=false

echo "\n\n\n"
echo "-----------------------------------------"
read -p "Press any key to compile : " key
echo "\n\n\n"

# Compiling
cd "$gcpid"
mvn clean install

echo "\n\n\n"
echo "-----------------------------------------"
read -p "Press any key to deploy : " key
echo "\n\n\n"
mvn appengine:update

echo "--------------------------------------"
echo "--------------------------------------"

end_time=`date +%s`
echo GAE setup and deployed in `expr $end_time - $start_time` s.

echo ""
echo "--------------------------------------"
echo "--------------------------------------"
