#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([Clay_Assignment], [1.0.1], [javad@jrahimi.ir])
AC_CONFIG_SRCDIR([src/main.cpp])
AC_CONFIG_HEADERS([config.h])
AM_INIT_AUTOMAKE  
AC_PROG_RANLIB
# Checks for programs.
AC_PROG_CXX

# Checks for libraries.

# Checks for header files.
AC_CHECK_HEADERS([arpa/inet.h stdlib.h sys/socket.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_UINT8_T
#REQUIRE_LIB(libmnl,mnl,mnl_socket_open,[Libmn NetFilter Libaray])
#REQUIRE_LIB(libpcap,pcap,pcap_dump_open,[Libpcap packet capture library])
# Checks for library functions.

AC_CONFIG_FILES([Makefile
                 src/Makefile])
AC_OUTPUT
