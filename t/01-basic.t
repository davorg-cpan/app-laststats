use Test::More tests => 3;
use App::LastStats;

my $stats = App::LastStats->new(
    username => 'davorg',
    period   => '7day',
    format   => 'text',
    count    => 10,
);

ok($stats, 'Object created');

$stats->run;

ok($stats->can('laststats'), 'Method laststats exists');
ok($stats->can('render'), 'Method render exists');
