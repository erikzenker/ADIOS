#
#
# AC_BROTLI
#
#
#
dnl @synopsis AC_BROTLI
dnl
dnl This macro test if BROTLI is to be used.
dnl Use in C code:
dnl     #ifdef BROTLI
dnl     #include "brotli_c.h"
dnl     #endif
dnl
dnl @version 1.0
dnl @author Erik Zenker
dnl
AC_DEFUN([AC_BROTLI],[

AC_MSG_NOTICE([=== checking for BROTLI  ===])

AM_CONDITIONAL(HAVE_BROTLI,true)

AC_ARG_WITH(brotli,
        [  --with-brotli=DIR      Location of brotli library],
        [:], [with_brotli=no])

if test "x$with_brotli" == "xno"; then

   AM_CONDITIONAL(HAVE_BROTLI,false)

else

    save_CPPFLAGS="$CPPFLAGS"
    save_LIBS="$LIBS"
    save_LDFLAGS="$LDFLAGS"

    if test "x$with_brotli" == "xyes"; then
        dnl No path given
        BROTLI_CPPFLAGS=""
        BROTLI_LDFLAGS=""
        BROTLI_LIBS="-lbrotli_c"
    else
        dnl Path given, first try path/lib64
	BROTLI_CPPFLAGS="-I$withval/include"
        BROTLI_LDFLAGS="-L$withval/lib64"
        BROTLI_LIBS="-lbrotli_c"
    fi

    LIBS="$LIBS $BROTLI_LIBS"
    LDFLAGS="$LDFLAGS $BROTLI_LDFLAGS"
    CPPFLAGS="$CPPFLAGS $BROTLI_CPPFLAGS"

    dnl Find header file first
    AC_CHECK_HEADERS(brotli_c.h,
              ,
              [AM_CONDITIONAL(HAVE_BROTLI,false)])

    #if test -z "${HAVE_BROTLI_TRUE}"; then
    #    dnl Try to link an example now
    #    AC_MSG_CHECKING([if brotli code can be linked with $ZLIB_LDFLAGS])
    #    AC_TRY_LINK(
    #        [#include <stdlib.h>
    #         #include "brotli_c.h"],
    #        [Bytef* in, *out;
    #         uLongf in_len, *out_len;
    #         int level = 5;
    #         int zerr = compress2 (out, out_len, in, in_len, level);
    #         return (zerr != Z_OK);],
    #        [AC_MSG_RESULT(yes)],
    #        [AM_CONDITIONAL(HAVE_ZLIB,false)
    #         AC_MSG_RESULT(no)
    #        ])
    #        
    #    dnl If linking above failed, one reason might be that we looked in lib64/
    #    dnl instead of lib/
    #    if test -z "${HAVE_ZLIB_FALSE}"; then
    #        if test "x$with_lustre" != "xyes"; then
    #        ZLIB_LDFLAGS="-L$withval/lib"
    #        LDFLAGS="$LDFLAGS $ZLIB_LDFLAGS"
    #        AC_MSG_CHECKING([if zlib code can be linked with $ZLIB_LDFLAGS])
    #        AC_TRY_LINK(
    #            [#include <stdlib.h>
    #             #include "zlib.h"],
    #            [Bytef* in, *out;
    #             uLongf in_len, *out_len;
    #             int level = 5;
    #             int zerr = compress2 (out, out_len, in, in_len, level);
    #             return (zerr != Z_OK);],
    #            [AC_MSG_RESULT(yes)],
    #            [AM_CONDITIONAL(HAVE_ZLIB,false)
    #             AC_MSG_RESULT(no)
    #            ])
    #        fi
    #    fi
    #fi

    LIBS="$save_LIBS"
    LDFLAGS="$save_LDFLAGS"
    CPPFLAGS="$save_CPPFLAGS"

    AC_SUBST(BROTLI_LIBS)
    AC_SUBST(BROTLI_LDFLAGS)
    AC_SUBST(BROTLI_CPPFLAGS)

    # Finally, execute ACTION-IF-FOUND/ACTION-IF-NOT-FOUND:
    if test -z "${HAVE_BROTLI_TRUE}"; then
            ifelse([$1],,[AC_DEFINE(HAVE_BROTLI,1,[Define if you have BROTLI.])],[$1])
            :
    else
            $2
            :
    fi
fi
])dnl AC_BROTLI
