AUTOMAKE_OPTIONS = subdir-objects

TESTS = test_repo
check_PROGRAMS = test_repo
test_repo_SOURCES = test_repo.cpp $(top_builddir)/inc/repository.h $(top_builddir)/src/repository.cpp 
test_repo_CFLAGS = @CHECK_CFLAGS@ 
test_repo_LDADD = -lal -lpthread -lunity
