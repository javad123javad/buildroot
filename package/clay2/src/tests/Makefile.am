AUTOMAKE_OPTIONS = subdir-objects

TESTS = test_repo unix_cli_test
check_PROGRAMS = test_repo unix_cli_test
test_repo_SOURCES = test_repo.cpp $(top_builddir)/inc/repository.h $(top_builddir)/src/repository.cpp 
test_repo_CFLAGS = @CHECK_CFLAGS@ 
test_repo_LDADD = -lal -lpthread -lunity

unix_cli_test_SOURCES = unix_cli_test.cpp $(top_builddir)/inc/repository.h $(top_builddir)/src/repository.cpp 
unix_cli_test_CFLAGS = @CHECK_CFLAGS@ 
unix_cli_test_LDADD = -lal -lpthread -lunity
