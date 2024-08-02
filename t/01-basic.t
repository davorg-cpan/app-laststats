use Test::More;
use App::LastStats;

# These are only useful while we're not actually making
# API calls
$ENV{LASTFM_API_KEY} = 'SomeRandomKey';
$ENV{LASTFM_SECRET}  = 'Sekrit';

my $stats = App::LastStats->new(
    username => 'davorg',
    period   => '7day',
    format   => 'text',
    count    => 10,
    api_key  => 'SomeRandomKey',
    api_secret => 'Sekrit',
);

ok($stats, 'Object created');

ok($stats->can('laststats'), 'Method laststats exists');
ok($stats->can('render'), 'Method render exists');

# Test command-line options for API key and secret
my $stats_with_options = App::LastStats->new(
    username => 'davorg',
    period   => '7day',
    format   => 'text',
    count    => 10,
);

Getopt::Long::Configure("pass_through");
GetOptions(
    'api-key=s'   => \$stats_with_options->{api_key},
    'api-secret=s'=> \$stats_with_options->{api_secret},
);

ok($stats_with_options->{api_key} eq 'SomeRandomKey', 'API key set from command-line option');
ok($stats_with_options->{api_secret} eq 'Sekrit', 'API secret set from command-line option');

done_testing;
