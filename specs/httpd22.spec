%define contentdir /var/www/httpd22
%define suexec_caller apache
%define mmn 20051115
%define vstring Red Hat
%define distro Red Hat Enterprise Web Server
# Minimum version of OpenSSL having support for the secure TLS reneg API
%define opensslver 0.9.8e-12.el5_4.4

%define _with_zips 1
%define _with_src_zips 1
# If you want to build the zips,
# give rpmbuild option '--with zips'
%define with_zips %{?_with_zips:1}%{!?_with_zips:0}
%define without_zips %{!?_with_zips:1}%{?_with_zips:0}
%define with_src_zips %{?_with_src_zips:1}%{!?_with_src_zips:0}
%define without_src_zips %{!?_without_src_zips:1}%{?_without_src_zips:0}

Summary: Apache HTTP Server
Name: httpd22
Version: 2.2.26
Release: 37%{?dist}
URL: http://httpd.apache.org/
Source0: http://www.apache.org/dist/httpd/httpd-%{version}.tar.gz
Source1: index.html
Source3: httpd.logrotate
Source4: httpd.init
Source5: httpd.sysconf
Source10: httpd.conf
Source11: ssl.conf
Source12: welcome.conf
Source13: manual.conf
Source14: proxy_ajp.conf
# Documentation
Source33: README.confd
Source34: httpd22.service
# build/scripts patches
Patch1: httpd-2.1.10-apctl.patch
Patch2: httpd-2.1.10-apxs.patch
Patch3: httpd-2.2.9-deplibs.patch
Patch4: httpd-2.1.10-disablemods.patch
Patch5: httpd-2.1.10-layout.patch
# Features/functional changes
Patch20: httpd-2.2.14-release.patch
Patch21: httpd-2.2.11-xfsz.patch
#Patch22: httpd-2.1.10-pod.patch 
Patch23: httpd-2.0.45-export.patch
Patch24: httpd-2.2.11-corelimit.patch
Patch25: httpd-2.2.22-selinux.patch
Patch26: httpd-2.2.14-sslocsp.patch
# Bug fixes
Patch60: httpd-2.0.52-logresline.patch
Patch61: httpd-2.2.3-defpidlog.patch
Patch62: httpd-2.2.3-extfiltereos.patch
Patch63: httpd-2.2.3-graceful-ebadf.patch
Patch64: httpd-2.2.3-noxpad.patch
Patch65: httpd-2.2.3-pngmagic.patch
Patch68: httpd-2.2.15-proxyconn.patch
#Patch69: httpd-2.2.0-authnoprov.patch
Patch70: httpd-2.2.15-ssloidval.patch
Patch71: httpd-2.2.15-davputfail.patch
#Patch72: httpd-2.2.15-expectnoka.patch
#for JBPAPP-5951 (apache issue 50481)
#Patch74: httpd-2.2.17-bz50481.patch
Patch75: httpd-2.2.17-bz48735.patch
#Patch76: httpd-MODCLUSTER-226.patch
Patch77: httpd-JBPAPP-3614.patch
#Patch78: httpd-2.2.15-CVE-2011-3192ver3.patch
Patch79: httpd-2.2.15-CVE-2011-3368.patch
#Patch80: httpd-2.2.15-CVE-2011-3348.patch
Patch81: httpd-2.2.22-r815719+.patch
#Patch82: httpd-2.2.22-CVE-2012-2687.patch
#Patch83: httpd-2.2.22-bz894955.patch
Patch84: httpd-2.2.3-r693108.patch
#Patch85: httpd-2.2.15-CVE-2012-3499.patch
#Patch86: httpd-2.2.15-CVE-2012-4558.patch
Patch87: httpd-ocsp-entrust.patch
Patch88: httpd-2.2.22-ocsptrust.patch
#Patch89: httpd-2.2.3-CVE-2013-1862.patch
#Patch90: httpd-2.2.25-CVE-2013-1896.patch
#Patch91: httpd-2.2.22-pcre-el7.patch
Patch92: httpd-2.2.15-CVE-2013-6438.patch
Patch93: httpd-2.2.15-CVE-2014-0098.patch
Patch94: CVE-2014-0026.patch
Patch95: CVE-2014-0118.patch
Patch96: CVE-2014-0231.patch

License: ASL 2.0
Group: System Environment/Daemons
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root
# 64 bit only natives on RHEL 7
ExcludeArch:   i386 i686

BuildRequires: zip
BuildRequires: autoconf, perl, pkgconfig, findutils, ed
BuildRequires: expat, expat-devel, zlib-devel, libselinux-devel
BuildRequires: apr-devel >= 1.2.0, apr-util-devel >= 1.2.0, pcre-devel >= 5.0

BuildRequires: systemd-devel
Requires(preun): systemd-units
Requires(postun): systemd-units
Requires(post): systemd-units

Requires: initscripts >= 8.36, /etc/mime.types
#Obsoletes: httpd-suexec
Requires(pre): /usr/sbin/useradd, httpd22
Requires(post): chkconfig
Provides: webserver
Provides: httpd22-mmn = %{mmn}
#Obsoletes: apache, secureweb, mod_dav, mod_gzip, stronghold-apache, stronghold-htdocs
#Obsoletes: mod_put, mod_roaming
Conflicts: pcre < 4.0
Requires: httpd22-tools = %{version}-%{release}

%description
The Apache HTTP Server is a powerful, efficient, and extensible
web server.

%if %{with_zips}
%package zip
Summary:     Container for the zipped distribution of the Apache HTTP server.
Group:       Development

%description zip
Container for the zipped distribution of the Apache HTTP server.
%endif

%if %{with_src_zips}
%package src-zip
Summary:     Container for the zipped source code of the Apache HTTP server.
Group:       Development

%description src-zip
Container for the source code of the Apache HTTP server.
%endif

%package devel
Group: Development/Libraries
Summary: Development tools for the Apache HTTP server.
Obsoletes: secureweb-devel, apache-devel, stronghold-apache-devel
Requires: apr-devel, apr-util-devel, pkgconfig
Requires: httpd22 = %{version}-%{release}

%description devel
The httpd-devel package contains the APXS binary and other files
that you need to build Dynamic Shared Objects (DSOs) for the
Apache HTTP Server.

If you are installing the Apache HTTP server and you want to be
able to compile or develop additional modules for Apache, you need
to install this package.

%package tools
Group: System Environment/Daemons
Summary: Tools for use with the Apache HTTP Server

%description tools
The httpd-tools package contains tools which can be used with
the Apache HTTP Server.

%package -n mod_ssl22
Group: System Environment/Daemons
Summary: SSL/TLS module for the Apache HTTP server
Epoch: 1
BuildRequires: openssl-devel >= %{opensslver}
Requires(post): openssl >= 0.9.7f-4, /bin/cat
Requires: httpd22 = 0:%{version}-%{release}, httpd22-mmn = %{mmn}
Requires: openssl >= %{opensslver}
Obsoletes: stronghold-mod_ssl

%description -n mod_ssl22
The mod_ssl22 module provides strong cryptography for the Apache Web
server via the Secure Sockets Layer (SSL) and Transport Layer
Security (TLS) protocols.

%package manual
Group: Documentation
Summary: Documentation for the Apache HTTP server.
Requires: httpd22 = %{version}-%{release}

%description manual
The httpd-manual package contains the complete manual and
reference guide for the Apache HTTP server. The information can
also be found at http://httpd.apache.org/docs/2.2/.

%prep
%setup -q -n httpd-%{version}
%patch1 -p1 -b .apctl 
%patch2 -p1 -b .apxs
%patch3 -p1 -b .deplibs
%patch4 -p1 -b .disablemods
%patch5 -p1 -b .layout

%patch21 -p1 -b .xfsz
#%patch22 -p1 -b .pod
%patch23 -p1 -b .export
%patch24 -p1 -b .corelimit
%patch25 -p1 -b .selinux
%patch26 -p1 -b .sslocsp

%patch60 -p1 -b .logresline
%patch61 -p1 -b .defpidlog
%patch62 -p1 -b .extfiltereos
%patch63 -p1 -b .graceful-ebadf
%patch64 -p1 -b .noxpad
%patch65 -p1 -b .pngmagic
%patch68 -p1 -b .proxyconn
#%patch69 -p1 -b .authnoprov
%patch70 -p1 -b .ssloidval
%patch71 -p1 -b .davputfail
#%patch72 -p1 -b .expectnoka
#%patch74 -p1 -b .bz50481
%patch75 -p1 -b .bz48735
#%patch76 -p1 -b .modcluster226
%patch77 -p1 -b .jbpapp3614
#%patch78 -p1 -b .cve3192ver3
%patch79 -p1 -b .cve3368
#%patch80 -p1 -b .cve3348
%patch81 -p1 -b .r815719+
#%patch82 -p1 -b .cve20122687

cp -p $RPM_SOURCE_DIR/httpd.init httpd.init
#%patch83 -p0 -b .bz894955
%patch84 -p1 -b .r693108
#%patch85 -p1 -b .cve20123499
#%patch86 -p1 -b .cve20124558
%patch87 -p1 -b .ocspentrust
%patch88 -p1 -b .ocsptrust
#%patch89 -p1 -b .cve1862
#%patch90 -p1 -b .cve1896
#%patch91 -p1 -b .pcre
%patch92 -p1 -b .cve_2013_6438
%patch93 -p1 -b .cve_2014_0098
%patch94 -p0
%patch95 -p0
%patch96 -p0

# Patch in vendor/release string
sed "s/@VENDOR@/%{distro}/;s/@RELEASE@/%{version}-%{release}/" < %{PATCH20} | patch -p1 -b -z .release

# Safety check: prevent build if defined MMN does not equal upstream MMN.
vmmn=`echo MODULE_MAGIC_NUMBER_MAJOR | cpp -include include/ap_mmn.h | sed -n '/^2/p'`
if test "x${vmmn}" != "x%{mmn}"; then
   : Error: Upstream MMN is now ${vmmn}, packaged MMN is %{mmn}.
   : Update the mmn macro and rebuild.
   exit 1
fi

: Building for '%{distro}' with MMN %{mmn} and vendor string '%{vstring}'

# Fix for JBPAPP-3740
sed -i -e '/  Installation$/{N;N;N;N;N;d;}' README

%if %{with_src_zips}
pushd $RPM_BUILD_DIR
tar czf $RPM_BUILD_DIR/httpd-%{version}-src.tar.gz httpd-%{version}
popd
%endif

%build
# forcibly prevent use of bundled apr, apr-util, pcre
rm -rf srclib/{apr,apr-util,pcre}

# regenerate configure scripts
autoheader && autoconf || exit 1

# Before configure; fix location of build dir in generated apxs
%{__perl} -pi -e "s:\@exp_installbuilddir\@:/httpd22/build:g" \
	support/apxs.in

CFLAGS="$RPM_OPT_FLAGS -Wformat-security -fno-strict-aliasing"
SH_LDFLAGS="-Wl,-z,relro"
export CFLAGS SH_LDFLAGS

# Hard-code path to links to avoid unnecessary builddep
export LYNX_PATH=/usr/bin/links

function mpmbuild()
{
mpm=$1; shift
mkdir $mpm; pushd $mpm
../configure \
 	--prefix=%{_sysconfdir}/httpd22 \
 	--exec-prefix=%{_prefix} \
 	--bindir=%{_bindir} \
 	--sbindir=%{_sbindir} \
 	--mandir=%{_mandir} \
	--libdir=%{_libdir} \
	--sysconfdir=%{_sysconfdir}/httpd22/conf \
	--includedir=%{_includedir}/httpd22 \
	--libexecdir=%{_libdir}/httpd22/modules \
	--datadir=%{contentdir} \
        --with-installbuilddir=%{_libdir}/httpd22/build \
	--with-mpm=$mpm \
    --with-apr=%{_prefix} --with-apr-util=%{_prefix} \
	--enable-suexec --with-suexec \
	--with-suexec-caller=%{suexec_caller} \
	--with-suexec-docroot=%{contentdir} \
	--with-suexec-logfile=%{_localstatedir}/log/httpd22/suexec.log \
	--with-suexec-bin=%{_sbindir}/suexec \
	--with-suexec-uidmin=500 --with-suexec-gidmin=100 \
        --enable-pie \
        --with-pcre \
	$*

make %{?_smp_mflags}
popd
}

# Build everything and the kitchen sink with the prefork build
mpmbuild prefork \
        --enable-mods-shared=all \
	--enable-ssl --with-ssl \
	--enable-proxy \
        --enable-cache \
        --enable-disk-cache \
        --enable-ldap --enable-authnz-ldap \
        --enable-cgid \
        --enable-authn-anon --enable-authn-alias \
        --disable-imagemap


# For the other MPMs, just build httpd and no optional modules
mpmbuild worker --enable-modules=none
mpmbuild event --enable-modules=none

%install
rm -rf $RPM_BUILD_ROOT

# Classify ab and logresolve as section 1 commands, as they are in /usr/bin
#mv docs/man/ab.8 docs/man/ab.1
#mv docs/man/logresolve.8 docs/man/logresolve.1

pushd prefork
make DESTDIR=$RPM_BUILD_ROOT install
popd

# Move build directory to correct position
mv $RPM_BUILD_ROOT%{_libdir}/httpd/build $RPM_BUILD_ROOT%{_libdir}/httpd22/
rm -rf $RPM_BUILD_ROOT%{_libdir}/httpd/build

# install alternative MPMs
install -m 755 worker/httpd $RPM_BUILD_ROOT%{_sbindir}/httpd22.worker
install -m 755 event/httpd $RPM_BUILD_ROOT%{_sbindir}/httpd22.event

# install var directory
mkdir $RPM_BUILD_ROOT%{_sysconfdir}/httpd22/var

# install conf file/directory
mkdir $RPM_BUILD_ROOT%{_sysconfdir}/httpd22/conf.d
install -m 644 $RPM_SOURCE_DIR/README.confd \
    $RPM_BUILD_ROOT%{_sysconfdir}/httpd22/conf.d/README
for f in ssl.conf welcome.conf manual.conf proxy_ajp.conf; do
  install -m 644 $RPM_SOURCE_DIR/$f $RPM_BUILD_ROOT%{_sysconfdir}/httpd22/conf.d/$f
done

rm $RPM_BUILD_ROOT%{_sysconfdir}/httpd22/conf/*.conf
install -m 644 $RPM_SOURCE_DIR/httpd.conf \
   $RPM_BUILD_ROOT%{_sysconfdir}/httpd22/conf/httpd.conf

#JBPAPP-9446
sed -i -e "s:LoadModule proxy_balancer_module:#LoadModule proxy_balancer_module:" $RPM_BUILD_ROOT%{_sysconfdir}/httpd22/conf/httpd.conf

mkdir $RPM_BUILD_ROOT%{_sysconfdir}/sysconfig
install -m 644 $RPM_SOURCE_DIR/httpd.sysconf \
   $RPM_BUILD_ROOT%{_sysconfdir}/sysconfig/httpd22

# https://issues.jboss.org/browse/JBPAPP-10212
mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/run/httpd22

# for holding mod_dav lock database
mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/lib/dav

# create a prototype session cache
mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/cache/mod_ssl22
touch $RPM_BUILD_ROOT%{_localstatedir}/cache/mod_ssl22/scache.{dir,pag,sem}

# create cache root
mkdir $RPM_BUILD_ROOT%{_localstatedir}/cache/mod_proxy

# Install systemd service files
mkdir -p $RPM_BUILD_ROOT%{_unitdir}
for s in httpd22; do
  install -p -m 644 $RPM_SOURCE_DIR/${s}.service \
                    $RPM_BUILD_ROOT%{_unitdir}/${s}.service
done

%if %{with_zips}
mkdir -p httpd/{include,lib/build,sbin,cache/mod_ssl22,conf,conf.d,logs,run,var,modules,www/html,www/error}
cp -r $RPM_SOURCE_DIR/index.html httpd/www/error/noindex.html
cp -r $RPM_BUILD_ROOT%{_sysconfdir}/httpd22/conf.d/* httpd/conf.d/
cp -r $RPM_BUILD_ROOT%{_sysconfdir}/httpd22/conf/{httpd.conf,magic} httpd/conf/
cp -r $RPM_BUILD_ROOT%{_localstatedir}/www/httpd22/{cgi-bin,error,icons} httpd/www
cp -r $RPM_BUILD_ROOT%{_localstatedir}/cache/* httpd/cache/
cp -r $RPM_BUILD_ROOT%{_sbindir}/* httpd/sbin/
mv httpd/sbin/httpd22.worker httpd/sbin/httpd.worker
sed -e "s|/usr/sbin/httpd|./httpd|" -e "s|/etc/sysconfig/httpd|../conf/httpd.conf|" \
 $RPM_BUILD_ROOT%{_sbindir}/apachectl > httpd/sbin/apachectl
cp -r $RPM_BUILD_ROOT%{_libdir}/httpd22/modules/* httpd/modules/
cp -r $RPM_BUILD_ROOT%{_libdir}/httpd22/build/* httpd/lib/build/
cp -r $RPM_BUILD_ROOT%{_libdir}/* httpd/lib/
rm -fr httpd/lib/httpd22
cp -r $RPM_BUILD_ROOT%{_includedir}/httpd22/* httpd/include/
mv httpd/sbin/httpd22.event httpd/sbin/httpd.event


#JBPAPP-3635
rm httpd/sbin/{checkgid,envvars,envvars-std,dbmmanage}
zip -q -r httpd-%{version}.zip httpd
%endif

#Fix JBPAPP-3883
sed -i -e "s|/usr/sbin/httpd|/usr/sbin/httpd22|" $RPM_BUILD_ROOT%{_sbindir}/apachectl

# Remove everything duplicated with the base httpd package
rm -rf $RPM_BUILD_ROOT%{_sysconfdir}/httpd22/logs

# Rename everything else
for f in $RPM_BUILD_ROOT%{_sbindir}/*; do
    mv ${f} ${f}22
done

# Rename man pages
for f in $RPM_BUILD_ROOT%{_mandir}/man8/*.8; do
    mv ${f} ${f%.8}22.8
done

for f in $RPM_BUILD_ROOT%{_mandir}/man1/*.1; do
    mv ${f} ${f%.1}22.1
done

# move utilities to /usr/bin
mv $RPM_BUILD_ROOT%{_sbindir}/{ab22,htdbm22,logresolve22,htpasswd22,htdigest22} \
   $RPM_BUILD_ROOT%{_bindir}

# Processing httpd.conf
sed -i "s|httpd.pid|httpd22.pid|" $RPM_BUILD_ROOT/etc/httpd22/conf/httpd.conf
sed -i "s|/var/www|/var/www/httpd22|" $RPM_BUILD_ROOT/etc/httpd22/conf/httpd.conf
sed -i "s|lockdb|lockdb22|" $RPM_BUILD_ROOT/etc/httpd22/conf/httpd.conf
sed -i "s|ServerRoot \"/etc/httpd\"|ServerRoot \"/etc/httpd22\"|" $RPM_BUILD_ROOT/etc/httpd22/conf/httpd.conf

# Make the MMN accessible to module packages
echo %{mmn} > $RPM_BUILD_ROOT%{_includedir}/httpd22/.mmn

# docroot
mkdir -p $RPM_BUILD_ROOT%{contentdir}/{html,error}
install -m 644 $RPM_SOURCE_DIR/index.html \
        $RPM_BUILD_ROOT%{contentdir}/error/noindex.html

# remove manual sources
find $RPM_BUILD_ROOT%{contentdir}/manual \( \
    -name \*.xml -o -name \*.xml.* -o -name \*.ent -o -name \*.xsl -o -name \*.dtd \
    \) -print0 | xargs -0 rm -f

# Strip the manual down just to English and replace the typemaps with flat files:
set +x
for f in `find $RPM_BUILD_ROOT%{contentdir}/manual -name \*.html -type f`; do
   if test -f ${f}.en; then
      cp ${f}.en ${f}
      rm ${f}.*
   fi
done
set -x

# logs
#rmdir $RPM_BUILD_ROOT%{_sysconfdir}/httpd22/logs
mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/log/httpd22

# symlinks for /etc/httpd
ln -s ../..%{_localstatedir}/log/httpd22 $RPM_BUILD_ROOT/etc/httpd22/logs
ln -s ../..%{_localstatedir}/run/httpd22 $RPM_BUILD_ROOT/etc/httpd22/run
ln -s ../..%{_libdir}/httpd22/modules $RPM_BUILD_ROOT/etc/httpd22/modules

# Processing config_vars.mk
sed -i "s|httpd/build|httpd22/build|" $RPM_BUILD_ROOT%{_libdir}/httpd22/build/config_vars.mk

# install log rotation stuff
mkdir -p $RPM_BUILD_ROOT/etc/logrotate.d
install -m644 $RPM_SOURCE_DIR/httpd.logrotate \
	$RPM_BUILD_ROOT/etc/logrotate.d/httpd22

# fix man page paths
sed -e "s|/usr/local/apache2/conf/httpd.conf|/etc/httpd22/conf/httpd.conf|" \
    -e "s|/usr/local/apache2/conf/mime.types|/etc/mime.types|" \
    -e "s|/usr/local/apache2/conf/magic|/etc/httpd22/conf/magic|" \
    -e "s|/usr/local/apache2/logs/error_log|/var/log/httpd22/error_log|" \
    -e "s|/usr/local/apache2/logs/access_log|/var/log/httpd22/access_log|" \
    -e "s|/usr/local/apache2/logs/httpd.pid|/var/run/httpd22.pid|" \
    -e "s|/usr/local/apache2|/etc/httpd|" < docs/man/httpd.8 \
  > $RPM_BUILD_ROOT%{_mandir}/man8/httpd22.8

# Make ap_config_layout.h libdir-agnostic
sed -i '/.*DEFAULT_..._LIBEXECDIR/d;/DEFAULT_..._INSTALLBUILDDIR/d' \
    $RPM_BUILD_ROOT%{_includedir}/httpd22/ap_config_layout.h

# Fix path to instdso in special.mk
sed -i '/instdso/s,top_srcdir,top_builddir,' \
    $RPM_BUILD_ROOT%{_libdir}/httpd22/build/special.mk

# Remove unpackaged files
rm -f $RPM_BUILD_ROOT%{_libdir}/*.exp \
      $RPM_BUILD_ROOT/etc/httpd22/conf/mime.types \
      $RPM_BUILD_ROOT%{_libdir}/httpd22/modules/*.exp \
      $RPM_BUILD_ROOT%{_libdir}/httpd22/build/config.nice \
      $RPM_BUILD_ROOT%{_bindir}/ap?-config \
      $RPM_BUILD_ROOT%{_sbindir}/{checkgid22,dbmmanage22,envvars*} \
      $RPM_BUILD_ROOT%{contentdir}/htdocs/* \
      $RPM_BUILD_ROOT%{contentdir}/cgi-bin/*

rm -rf $RPM_BUILD_ROOT/etc/httpd22/conf/{original,extra}

# Make suexec a+rw so it can be stripped.  %%files lists real permissions
chmod 755 $RPM_BUILD_ROOT%{_sbindir}/suexec22

%pre
# Add the "apache" user
/usr/sbin/useradd -c "Apache" -u 48 \
	-s /sbin/nologin -r -d %{contentdir} apache 2> /dev/null || :

%post
%systemd_post httpd.service

%preun
%systemd_preun httpd.service

%define sslcert %{_sysconfdir}/pki/tls/certs/localhost.crt
%define sslkey %{_sysconfdir}/pki/tls/private/localhost.key

%postun
%systemd_postun

%post -n mod_ssl22
umask 077

if [ ! -f %{sslkey} ] ; then
%{_bindir}/openssl genrsa -rand /proc/apm:/proc/cpuinfo:/proc/dma:/proc/filesystems:/proc/interrupts:/proc/ioports:/proc/pci:/proc/rtc:/proc/uptime 1024 > %{sslkey} 2> /dev/null
fi

FQDN=`hostname`
if [ "x${FQDN}" = "x" ]; then
   FQDN=localhost.localdomain
fi

if [ ! -f %{sslcert} ] ; then
cat << EOF | %{_bindir}/openssl req -new -key %{sslkey} \
         -x509 -days 365 -set_serial $RANDOM \
         -out %{sslcert} 2>/dev/null
--
SomeState
SomeCity
SomeOrganization
SomeOrganizationalUnit
${FQDN}
root@${FQDN}
EOF
fi

%check
# Check the built modules are all PIC
if readelf -d $RPM_BUILD_ROOT%{_libdir}/httpd22/modules/*.so | grep TEXTREL; then
   : modules contain non-relocatable code
   exit 1
fi

# Verify that the same modules were built into the httpd binaries
./prefork/httpd -l | grep -v prefork > prefork.mods
for mpm in worker; do
  ./${mpm}/httpd -l | grep -v ${mpm} > ${mpm}.mods
  if ! diff -u prefork.mods ${mpm}.mods; then
    : Different modules built into httpd binaries, will not proceed
    exit 1
  fi
done

%if %{with_zips}
install -dm 755 $RPM_BUILD_ROOT/%{_javadir}/jbossas-fordev
# Copy over zip for the zip subpackage
install -m 644 httpd-%{version}.zip $RPM_BUILD_ROOT/%{_javadir}/jbossas-fordev/httpd-%{version}.zip
%endif

%if %{with_src_zips}
install -dm 755 $RPM_BUILD_ROOT/%{_javadir}/jbossas-fordev
# Copy over source the src-zip subpackage
install -m 644 $RPM_BUILD_DIR/httpd-%{version}-src.tar.gz $RPM_BUILD_ROOT/%{_javadir}/jbossas-fordev/httpd-%{version}-src.tar.gz
%endif


%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)

%doc ABOUT_APACHE README CHANGES LICENSE VERSIONING NOTICE

%dir %{_sysconfdir}/httpd22
%{_sysconfdir}/httpd22/modules
%{_sysconfdir}/httpd22/logs
%{_sysconfdir}/httpd22/run
%dir %{_sysconfdir}/httpd22/conf
%config %{_sysconfdir}/httpd22/conf/httpd.conf
%config(noreplace) %{_sysconfdir}/httpd22/conf.d/welcome.conf
%config(noreplace) %{_sysconfdir}/httpd22/conf.d/proxy_ajp.conf
%config(noreplace) %{_sysconfdir}/httpd22/conf/magic

%config(noreplace) %{_sysconfdir}/logrotate.d/httpd22

%{_unitdir}/*.service

%dir %{_sysconfdir}/httpd22/conf.d
%{_sysconfdir}/httpd22/conf.d/README

%config(noreplace) %{_sysconfdir}/sysconfig/httpd22

%{_sbindir}/ht*
%{_sbindir}/apachectl22
%{_sbindir}/rotatelogs22
%attr(4510,root,%{suexec_caller}) %{_sbindir}/suexec22

%dir %{_libdir}/httpd22
%dir %{_libdir}/httpd22/modules
%{_libdir}/httpd22/modules/mod*.so
%exclude %{_libdir}/httpd22/modules/mod_ssl.so

%dir %{contentdir}
%dir %{contentdir}/cgi-bin
%dir %{contentdir}/html
%dir %{contentdir}/icons
%dir %{contentdir}/error
%dir %{contentdir}/error/include
%{contentdir}/icons/*
%{contentdir}/error/README
%{contentdir}/error/noindex.html
%config %{contentdir}/error/*.var
%config %{contentdir}/error/include/*.html

%attr(0700,root,root) %dir %{_localstatedir}/log/httpd22
%attr(0700,apache,apache) %dir %{_localstatedir}/lib/dav
%attr(0700,apache,apache) %dir %{_localstatedir}/cache/mod_proxy
%attr(0710,root,apache) %dir %{_localstatedir}/run/httpd22

%{_mandir}/man8/*

%files tools
%defattr(-,root,root)
%{_bindir}/*
%{_mandir}/man1/*
%doc LICENSE

%files manual
%defattr(-,root,root)
%{contentdir}/manual
%config %{_sysconfdir}/httpd22/conf.d/manual.conf

%files -n mod_ssl22
%defattr(-,root,root)
%{_libdir}/httpd22/modules/mod_ssl.so
%config(noreplace) %{_sysconfdir}/httpd22/conf.d/ssl.conf
%attr(0700,apache,root) %dir %{_localstatedir}/cache/mod_ssl22
%attr(0600,apache,root) %ghost %{_localstatedir}/cache/mod_ssl22/scache.dir
%attr(0600,apache,root) %ghost %{_localstatedir}/cache/mod_ssl22/scache.pag
%attr(0600,apache,root) %ghost %{_localstatedir}/cache/mod_ssl22/scache.sem

%files devel
%defattr(-,root,root)
%{_includedir}/httpd22
%{_sbindir}/apxs22
%dir %{_libdir}/httpd22/build
%{_libdir}/httpd22/build/*.mk
%{_libdir}/httpd22/build/*.sh

%if %{with_zips}
%files zip
%defattr(0644,root,root,0755)
%{_javadir}/jbossas-fordev/httpd-%{version}.zip
%endif

%if %{with_src_zips}
%files src-zip
%defattr(0644,root,root,0755)
%{_javadir}/jbossas-fordev/httpd-%{version}-src.tar.gz
%endif

%changelog
* Fri Jul 18 2014 Weinan Li <weli@redhat.com> - 2.2.26-37
- CVE-2014-0026
- CVE-2014-0118
- CVE-2014-0231

* Wed Jul 09 2014 Dustin Kut Moy Cheung <dcheung@redhat.com> - 2.2.26-36
- Remove Requires: apr-util-ldap
- apr-util-ldap is found in 'Optional' RHEL7 channel, which should not be
  enabled by default. If user wants ldap authentication, she should install this
  package manually.

* Thu Jun 12 2014 Dustin Kut Moy Cheung <dcheung@redhat.com> - 2.2.26-35
- Fix for bz-1108181 :: [rhel7] Add Requires: apr-util-ldap to httpd22.spec

* Fri May 16 2014 Dustin Kut Moy Cheung <dcheung@redhat.com> - 2.2.26-34
- Add the Requires: httpd22-tools line

* Wed May 07 2014 Dustin Kut Moy Cheung <dcheung@redhat.com> - 2.2.26-33
- Apply fix for CVE-2013-6438 and CVE-2014-0098

* Tue Apr 01 2014 Permaine Cheung <pcheung@redhat.com> - 2.2.26-32
- Rebuild as ppc64 builders are enabled in our buildroot

* Tue Mar 25 2014 Weinan Li <weli@redhat.com> - 2.2.26-31
- Fix config location error in apxs22

* Thu Feb 27 2014 Weinan Li <weli@redhat.com> - 2.2.26-30
- Migrate from sysvinit to systemd
- Apply necessary patches

* Mon Feb 24 2014 Weinan Li <weli@redhat.com> - 2.2.26-29
- Clean up Requires section

* Mon Feb 17 2014 Weinan Li <weli@redhat.com> - 2.2.26-28
- Upgrade to 2.2.26

* Fri Dec 20 2013 Weinan Li <weli@redhat.com> - 2.2.22-27
- Fix httpd-tools

* Tue Dec 10 2013 Weinan Li <weli@redhat.com> - 2.2.22-26
- Rename to httpd22

* Thu Jul 25 2013 Weinan Li <weli@redhat.com> - 2.2.22-25
- include patch 89 and 90

* Wed Jul 24 2013 Weinan Li <weli@redhat.com> - 2.2.22-24
- CVE-2013-1862
- CVE-2013-1896

* Mon Jun 17 2013 Weinan Li <weli@redhat.com> - 2.2.22-23
- bz973189

* Tue Jun  4 2013 Joe Orton <jorton@redhat.com> - 2.2.22-22
- mod_ssl: add "SSLOCSPResponderCertificateFile" config option
- fix init script handling in spec file
- Add patch for one-off: support the Tumbleweed OCSP responder

* Mon May 27 2013 Weinan Li <weli@redhat.com> - 2.2.22-19
- CVE2012-3499
- CVE2012-4558

* Wed May 08 2013 Weinan Li <weli@redhat.com> - 2.2.22-18
- relax checks for status-line validity #853128

* Thu May 02 2013 Weinan Li <weli@redhat.com> - 2.2.22-17
- generate src zip correctly

* Mon Apr 08 2013 Weinan Li <weli@redhat.com> - 2.2.22-16
- move httpd.init to correct position during build process

* Mon Apr 08 2013 Weinan Li <weli@redhat.com> - 2.2.22-15
- bz894955
- bz947391

* Wed Oct 17 2012 Weinan Li <weli@redhat.com> - 2.2.22-14
- More fix on JBPAPP-10212

* Tue Oct 16 2012 Weinan Li <weli@redhat.com> - 2.2.22-13
- JBPAPP-10212

* Fri Sep 21 2012 Weinan Li <weli@redhat.com> - 2.2.22-12
- JBPAPP-9446,9578

* Tue Sep 04 2012 Weinan Li <weli@redhat.com> - 2.2.22-11
- httpd-2.2.22-CVE-2012-2687.patch

* Thu Jul 12 2012 Joe Orton <jorton@redhat.com> - 2.2.22-10
- mod_ssl: pull latest upstream OCSP code (r815719+) 
  Thanks to Joe Orton for providing the patch

* Wed Jun 20 2012 Weinan Li <weli@redhat.com> - 2.2.22-9
- Fix incorrect src-zip

* Tue Jun 19 2012 Weinan Li <weli@redhat.com> - 2.2.22-8
- Bundle patched sources instead of the pristine one

* Wed May 23 2012 Weinan Li <weli@redhat.com> - 2.2.22-7
- JBPAPP-7633

* Tue May 01 2012 Weinan Li <weli@redhat.com> - 2.2.22-6
- Add var directory for zip

* Mon Apr 30 2012 Weinan Li <weli@redhat.com> - 2.2.22-5
- Add var directory

* Fri Apr 27 2012 Weinan Li <weli@redhat.com> - 2.2.22-4
- Fix src-zip package name

* Thu Apr 26 2012 Weinan Li <weli@redhat.com> - 2.2.22-3
- Add src-zip

* Mon Apr 23 2012 Weinan Li <weli@redhat.com> - 2.2.22-2
- Rebuild 2.2.22

* Wed Apr 04 2012 Weinan Li <weli@redhat.com> - 2.2.22-1
- Upgrade to 2.2.22
