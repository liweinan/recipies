Name: foo
Version: 1.0
Release:	1%{?dist}
Summary: foo
License: ASL 2.0
URL: http://example.com
#Source0: foo.tgz

BuildRequires: zip
Requires: zip

%description
foo

%prep
#%setup ${name}

%build
#%configure
#make

%install
#%make_install

%files

%doc

%changelog
* Mon Nov 03 2014 Foo <foo@example.com> - 1.0-1
- Initial import