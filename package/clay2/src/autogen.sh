#! /bin/sh
autoreconf --install
aclocal
automake --add-missing --force-missing
autoconf 
