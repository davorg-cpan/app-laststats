use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'App::LastStats',
    VERSION_FROM => 'lib/App/LastStats.pm',
    ABSTRACT_FROM => 'lib/App/LastStats.pm',
    AUTHOR       => 'Your Name <you@example.com>',
    LICENSE      => 'perl',
    PREREQ_PM    => {
        'Net::LastFM' => 0,
        'Getopt::Long' => 0,
        'JSON' => 0,
    },
);
