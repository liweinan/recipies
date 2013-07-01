#!/bin/sh
yum clean all
yum update -y --nogpgcheck

# needed for jarsigner
yum install -y java-devel
#FIXME remove the following line after group is ready
yum install -y --nogpgcheck tomcat6 tomcat6-webapps tomcat6-admin-webapps tomcat7 tomcat7-webapps tomcat7-admin-webapps mod_jk tomcat-native httpd mod_cluster mod_cluster-native mod_rt mod_snmp mod_nss mod_auth_kerb 2>&1 | tee ews2-install
#FIXME groupinstall after group is ready
#yum groupinstall -y --nogpgcheck jboss-ews2 2>&1  | tee ews2-install
#FIXME add jboss-ews2plus install
yum install -y --nogpgcheck hibernate4 hibernate3-commons-annotations hibernate-jpa-2.0-api hibernate4-envers hibernate4-javadoc hibernate4-core hibernate4-entitymanager hibernate4-c3p0
#Install optional packages
yum install -y --nogpgcheck httpd-devel httpd-manual mod_jk-manual mod_ssl tomcat[67]-docs-webapp tomcat[67]-log4j mod_jk-ap22 mod_cluster-demo hibernate3-commons-annotations-javadoc hibernate-jpa-2.0-api-javadoc tomcat[67]-javadoc apache-commons-daemon-jsvc-eap6 mod_cluster-tomcat[67]

# find leftovers
yum clean all
mkdir -p leftovers; pushd leftovers
yum list available -q | /root/yum_list_format.pl | grep -v rhel-x86_64-server-6 | column -t | sort > leftover
grep el5 leftover |grep i386 > leftover.el5.i386
grep el5 leftover |grep -v i386 > leftover.el5.x86_64
grep el6 leftover |grep i386 > leftover.el6.i386
grep el6 leftover |grep -v i386 > leftover.el6.x86_64
grep -v "javadoc" leftover.el5.x86_64 > core-leftover.el5
grep -v "javadoc" leftover.el6.x86_64 > core-leftover.el6
grep "javadoc" leftover.el5.x86_64 > javadoc-leftover.el5
grep "javadoc" leftover.el6.x86_64 > javadoc-leftover.el6
popd

# find signed / unsigned jars
for i in `find /usr/share/java -name "*.jar"`; do jarsigner --verify $i |grep "verified" >/dev/null &&  echo $i; done | tee ~/signed-jars-usr-share-java;
for i in `find /usr/share/java-signed -name "*.jar"`; do jarsigner --verify $i |grep "unsigned" >/dev/null &&  echo $i; done | tee ~/unsigned-jars-usr-share-java-signed;
for i in `find /usr/share/tomcat7 -name "*.jar"`; do jarsigner --verify $i |grep "verified" >/dev/null &&  echo $i; done | tee ~/signed-jars-usr-share-tomcat7;
for i in `find /usr/share/tomcat7 -name "*.jar"`; do jarsigner --verify $i |grep "unsigned" >/dev/null &&  echo $i; done | tee ~/unsigned-jars-usr-share-tomcat7;
for i in `find /usr/share/java/tomcat7 -name "*.jar"`; do jarsigner --verify $i |grep "verified" >/dev/null &&  echo $i; done | tee ~/signed-jars-usr-share-java-tomcat7;
for i in `find /usr/share/java/tomcat7 -name "*.jar"`; do jarsigner --verify $i |grep "unsigned" >/dev/null &&  echo $i; done | tee ~/unsigned-jars-usr-share-java-tomcat7;
for i in `find /usr/share/tomcat6 -name "*.jar"`; do jarsigner --verify $i |grep "verified" >/dev/null &&  echo $i; done | tee ~/signed-jars-usr-share-tomcat6;
for i in `find /usr/share/tomcat6 -name "*.jar"`; do jarsigner --verify $i |grep "unsigned" >/dev/null &&  echo $i; done | tee ~/unsigned-jars-usr-share-tomcat6;
for i in `find /usr/share/java/tomcat6 -name "*.jar"`; do jarsigner --verify $i |grep "verified" >/dev/null &&  echo $i; done | tee ~/signed-jars-usr-share-java-tomcat6;
for i in `find /usr/share/java/tomcat6 -name "*.jar"`; do jarsigner --verify $i |grep "unsigned" >/dev/null &&  echo $i; done | tee ~/unsigned-jars-usr-share-java-tomcat6;
pushd  /usr/share/java/tomcat6;find . -type l | (while read FN ; do test -e "$FN" || ls -ld "$FN"; done) | tee ~/broken-links.usr-share-java-tomcat6; popd
pushd  /usr/share/java/tomcat7;find . -type l | (while read FN ; do test -e "$FN" || ls -ld "$FN"; done) | tee ~/broken-links.usr-share-java-tomcat7; popd
pushd  /usr/share/tomcat6;find . -type l | (while read FN ; do test -e "$FN" || ls -ld "$FN"; done) | tee ~/broken-links.usr-share-tomcat6; popd
pushd  /usr/share/tomcat7;find . -type l | (while read FN ; do test -e "$FN" || ls -ld "$FN"; done) | tee ~/broken-links.usr-share-tomcat7; popd


# find SHA1
mkdir -p ~/SHA1

for i in `find /usr/share/java -name "*.jar"`
do
    out=`unzip -p "$i" META-INF/MANIFEST.MF 2>/dev/null | grep "SHA1-Digest"`
    if [ "$out" ]; then
        echo "$i" >> ~/SHA1/SHA1-Digest-usr-share-java
    fi
done

for i in `find /usr/share/java-signed -name "*.jar"`
do
    out=`unzip -p "$i" META-INF/MANIFEST.MF 2>/dev/null | grep "SHA1-Digest"`
    if [ "$out" ]; then
        echo "$i" >> ~/SHA1/SHA1-Digest-usr-share-java-signed
    fi
done

for i in `find /usr/share/tomcat6 -name "*.jar"`
do
    out=`unzip -p "$i" META-INF/MANIFEST.MF 2>/dev/null | grep "SHA1-Digest"`
    if [ "$out" ]; then
        echo "$i" >> ~/SHA1/SHA1-Digest-usr-share-tomcat6
    fi
done

for i in `find /usr/share/tomcat7 -name "*.jar"`
do
    out=`unzip -p "$i" META-INF/MANIFEST.MF 2>/dev/null | grep "SHA1-Digest"`
    if [ "$out" ]; then
        echo "$i" >> ~/SHA1/SHA1-Digest-usr-share-tomcat7
    fi
done

for i in `find /usr/share/java/tomcat6 -name "*.jar"`
do
    out=`unzip -p "$i" META-INF/MANIFEST.MF 2>/dev/null | grep "SHA1-Digest"`
    if [ "$out" ]; then
        echo "$i" >> ~/SHA1/SHA1-Digest-usr-share-java-tomcat6
    fi
done

for i in `find /usr/share/java/tomcat7 -name "*.jar"`
do
    out=`unzip -p "$i" META-INF/MANIFEST.MF 2>/dev/null | grep "SHA1-Digest"`
    if [ "$out" ]; then
        echo "$i" >> ~/SHA1/SHA1-Digest-usr-share-java-tomcat7
    fi
done

rpm -qa | grep "ep5" | tee ep5-packages
rpm -qa | grep "jpp" | tee jpp-packages
rpm -qa | grep "ep1" | tee ep1-packages
rpm -qa | grep "ep2" | tee ep2-packages
for i in `find /usr/share/tomcat6 -name "*.jar"`; do echo $i | xargs readlink | xargs rpm -q --whatprovides | grep -v ep6; done | tee non-ep6-in-usr-share-tomcat6
for i in `find /usr/share/java/tomcat6 -name "*.jar"`; do echo $i | xargs readlink | xargs rpm -q --whatprovides | grep -v ep6; done | tee non-ep6-in-usr-share-java-tomcat6
for i in `find /usr/share/tomcat7 -name "*.jar"`; do echo $i | xargs readlink | xargs rpm -q --whatprovides | grep -v ep6; done | tee non-ep6-in-usr-share-tomcat7
for i in `find /usr/share/java/tomcat7 -name "*.jar"`; do echo $i | xargs readlink | xargs rpm -q --whatprovides | grep -v ep6; done | tee non-ep6-in-usr-share-java-tomcat7
