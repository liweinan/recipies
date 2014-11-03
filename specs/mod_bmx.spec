%define _jarsign_opts --nocopy
%if "%{?rhel}" == "6"
%bcond_without zip
%else
%bcond_with zip
%endif

%if "%{?rhel}" == "7"
%define apxs apxs24
%define httpd httpd24
%else
%define apxs apxs
%define httpd httpd
%endif

%define reltag GA
#%define namedversion %{name}-%{version}.%{reltag}
%define namedversion %{name}-%{version}

Name: mod_bmx
Summary: BMX is a framework for Apache to provide internal runtime statistics and configuration information to interested remote agents.
Version: 0.9.5
Release: 2.%{reltag}%{?dist}
License: Apache License, Version 2.0

# https://github.com/hyperic/mod_bmx/archive/0.9.5.tar.gz
Source0: %{namedversion}.tar.gz

Group: Development/Libraries

BuildRoot: %{_tmppath}/%{name}-%{version}-buildroot

%if "%{?rhel}" == "7"
# 64 bit only natives on RHEL7
#ExcludeArch: i386 i686 ppc64
ExcludeArch: i386 i686
%endif

BuildRequires: perl
BuildRequires: libtool
BuildRequires: %{httpd}-devel
BuildRequires: zip

Requires: %{httpd}

%description
BMX is a framework for Apache to provide internal runtime statistics
and configuration information to interested remote agents. It can
be used to report on the internal workings and status of Apache at
runtime, such as performance metrics and current capacity.

%if %with zip
%package src-zip
Summary:     Container for the source distribution of mod_bmx
Group:       Development

%description src-zip
Container for the source distribution of mod_bmx.
%endif

%prep
%setup -q -n %{namedversion}

#Create src zip to include any patches
%if %with zip
zip -q -r %{name}-%{version}-src.zip *
%endif

%build
sh ./configure.apxs --APXS=`which %{apxs}`
make

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT%{_libdir}/%{httpd}/modules/ \
         $RPM_BUILD_ROOT%{_sysconfdir}/%{httpd}/conf.d

cp modules/bmx/.libs/*.so $RPM_BUILD_ROOT%{_libdir}/%{httpd}/modules/

# mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/httpd/conf.d/snmpd
# cp %{SOURCE90} $RPM_BUILD_ROOT%{_sysconfdir}/httpd/conf.d/snmpd
                                                                                                    
%if %with zip
mkdir -p $RPM_BUILD_ROOT%{_javadir}/jbossas-fordev
cp %{name}-%{version}-src.zip $RPM_BUILD_ROOT%{_javadir}/jbossas-fordev/
%endif

%clean
rm -rf $RPM_BUILD_ROOT

%post

%preun

%files
%defattr(-,root,root,-)

# %config(noreplace) %{_sysconfdir}/httpd/conf.d/mod_snmp.conf.sample
# %config(noreplace) %{_sysconfdir}/httpd/conf.d/snmpd/snmpd.conf.sample
%{_libdir}/%{httpd}/modules/*.so

%if %with zip
%files src-zip
%defattr(-,root,root,-)
%{_javadir}/jbossas-fordev/*
%endif

%changelog
* Thu Oct 16 2014 Weinan Li <weli@redhat.com> - 0:0.9.5-2
- Use correct httpd for el7

* Thu Sep 18 2014 Weinan Li <weli@redhat.com> - 0:0.9.5
- Initial import

