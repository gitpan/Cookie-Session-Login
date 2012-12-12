use 5.010000;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Cookie::Session::Login',
    VERSION_FROM      => 'lib/Cookie/Session/Login.pm', # finds $VERSION
    PREREQ_PM         => {CGI::Cookie=>1.29}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Cookie/Session/Login.pm', # retrieve abstract from module
       AUTHOR         => 'Mahesh Raghunath <blackwind@cpan.org>') : ()),
);
