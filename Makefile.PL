use 5.006;
use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

name     'DevLog';
all_from 'lib/DevLog.pm';
author   q{Sholto Maud <sholto.maud@gmail.com>};
license  'artistic2';

perl_version 5.006;

tests_recursive('t');

resources (
   license    => 'http://www.perlfoundation.org/artistic_license_2_0',
   repository => 'git://github.com/Sholto Maud/DevLog.git',
);

configure_requires (
   'Module::Install' => 0,
);

build_requires (
   'Test::More' => 0,
);

requires (
);

install_as_cpan;
auto_install;
WriteAll;
