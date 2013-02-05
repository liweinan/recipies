---

	mini:learnbash weinanli$ echo $PS1
	\h:\W \u\$
	mini:learnbash weinanli$ echo $PS2
	>
	mini:learnbash weinanli$ echo $PS3

	mini:learnbash weinanli$ echo $PS4
	+

---

	mini:learnbash weinanli$ shopt -p
	shopt -u cdable_vars
	shopt -u cdspell
	shopt -u checkhash
	shopt -s checkwinsize
	shopt -s cmdhist
	shopt -u compat31
	shopt -u dotglob
	shopt -u execfail
	shopt -s expand_aliases
	shopt -u extdebug
	shopt -s extglob
	shopt -s extquote
	shopt -u failglob
	shopt -s force_fignore
	shopt -u gnu_errfmt
	shopt -u histappend
	shopt -u histreedit
	shopt -u histverify
	shopt -s hostcomplete
	shopt -u huponexit
	shopt -s interactive_comments
	shopt -u lithist
	shopt -s login_shell
	shopt -u mailwarn
	shopt -u no_empty_cmd_completion
	shopt -u nocaseglob
	shopt -u nocasematch
	shopt -u nullglob
	shopt -s progcomp
	shopt -s promptvars
	shopt -u restricted_shell
	shopt -u shift_verbose
	shopt -s sourcepath
	shopt -u xpg_echo

---

	mini:learnbash weinanli$ echo $HISTIGNORE

	mini:learnbash weinanli$ echo $HISTFILE
	/Users/weinanli/.bash_history
	mini:learnbash weinanli$ echo $HISTFILESIZE
	500
	mini:learnbash weinanli$ echo $HISTSIZE
	500

---

	mini:learnbash weinanli$ echo $HOME
	/Users/weinanli
	mini:learnbash weinanli$ echo $SECONDS
	2116
	mini:learnbash weinanli$ echo $BASH
	/bin/bash
	mini:learnbash weinanli$ echo $BASH_VERSION
	3.2.48(1)-release
	mini:learnbash weinanli$ echo $BASH_VERSINFO
	3
	mini:learnbash weinanli$ echo $PWD
	/Users/weinanli/projs/learnbash
	mini:learnbash weinanli$ echo $OLDPWD
	/Users/weinanli/projs

---

	Last login: Thu Jan 31 16:14:54 on ttys004
	mini:~ weinanli$ echo $BASH
	/bin/bash
	mini:~ weinanli$ echo $SHELL
	/bin/bash
	mini:~ weinanli$ echo $EDITOR

	mini:~ weinanli$

---

	mini:~ weinanli$ echo $COLUMNS
	80
	mini:~ weinanli$ echo $LINES
	25
	mini:~ weinanli$

---

	mini:~ weinanli$ stty all
	speed 38400 baud; 25 rows; 80 columns;
	lflags: icanon isig iexten echo echoe echok echoke -echonl echoctl
		-echoprt -altwerase -noflsh -tostop -flusho pendin -nokerninfo
		-extproc
	iflags: -istrip icrnl -inlcr -igncr ixon -ixoff ixany imaxbel iutf8
		-ignbrk brkint -inpck -ignpar -parmrk
	oflags: opost onlcr -oxtabs -onocr -onlret
	cflags: cread cs8 -parenb -parodd hupcl -clocal -cstopb -crtscts -dsrflow
		-dtrflow -mdmbuf
	discard dsusp   eof     eol     eol2    erase   intr    kill    lnext
	^O      ^Y      ^D      <undef> <undef> ^?      ^C      ^U      ^V
	min     quit    reprint start   status  stop    susp    time    werase
	1       ^\      ^R      ^Q      ^T      ^S      ^Z      0       ^W

---

	perl -p -i -e 's/<javac/<javac source="1.6" target="1.6"/' `find . -name '*build*.xml' -print`

---

	[weli@dhcp-66-78-87 jbossts]$ yum repolist
	Loaded plugins: product-id, rhnplugin, subscription-manager
	Not root, certificate-based repositories not updated
	*Note* Red Hat Network repositories are not listed below. You must run this command as root to access RHN repositories.
	brew                                                                                                                                                                                         | 1.9 kB     00:00
	rhpkg                                                                                                                                                                                        |  951 B     00:00
	rhpkg/primary                                                                                                                                                                                | 8.6 kB     00:00
	rhpkg                                                                                                                                                                                                         39/39
	repo id                                                                    repo name                                                                                                                          status
	brew                                                                       Brew Buildsystem for Red Hat Enterprise Linux 6Server - x86_64                                                                     17
	rhpkg                                                                      rhpkg for Red Hat Enterprise Linux 6Server                                                                                         39
	repolist: 56	

---

echo -e will evaluate the string:

	mini:learnbash weinanli$ echo  ${PATH//:/'\n'}
	/opt/local/lib/postgresql92/bin\n/opt/local/bin\n/opt/local/sbin\n/usr/bin\n/bin\n/usr/sbin\n/sbin\n/usr/local/bin\n/opt/X11/bin\n/Users/weinanli/.rvm/bin

	mini:learnbash weinanli$ echo -e ${PATH//:/'\n'}
	/opt/local/lib/postgresql92/bin
	/opt/local/bin
	/opt/local/sbin
	/usr/bin
	/bin
	/usr/sbin
	/sbin
	/usr/local/bin
	/opt/X11/bin
	/Users/weinanli/.rvm/bin

---

	mini:learnbash weinanli$ echo -e ${#PATH}
	145

---

	mini:learnbash weinanli$ ls !(d*)
	README.md arg.sh
	mini:learnbash weinanli$ ls
	README.md arg.sh    dollar.sh

---

	mini:learnbash weinanli$ ls -l $(type -path -all ruby)
	lrwxr-xr-x  1 root  wheel  76 Nov 17 00:30 /usr/bin/ruby -> ../../System/Library/Frameworks/Ruby.framework/Versions/Current/usr/bin/ruby

---

	mini:learnbash weinanli$ ls -l $(type -path -all ruby)
	lrwxr-xr-x  1 root  wheel  76 Nov 17 00:30 /usr/bin/ruby -> ../../System/Library/Frameworks/Ruby.framework/Versions/Current/usr/bin/ruby


