AC_INIT([Jupiter], [1.0], [bug@example.com])
AC_MSG_WARN([Hello])
AC_MSG_RESULT([result])
AC_MSG_NOTICE([notice])
AC_ARG_ENABLE([async-exec],
	[AS_HELP_STRING([--enable-async-exec],  [enable async exec])],
	[async_exec=${enableval}],
	[async_exec=no])

if test x${async_exec} = xyes; then
	AC_DEFINE([ASYNC_EXEC], 1, [async execution enabled])
fi

AC_CONFIG_HEADERS([config.h])
AC_OUTPUT
