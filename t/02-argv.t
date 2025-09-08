$ENV{LASTFM_API_KEY}    = 'SomeRandomKey';
$ENV{LASTFM_API_SECRET} = 'Sekrit';
use Test::More;
use App::LastStats;

# Test valid usage - creating object with proper parameters
my $stats = App::LastStats->new(
    username => 'testuser',
    period => '7day',
    format => 'text',
    count => 5,
);

ok($stats, 'Object created with valid parameters');
is($stats->username, 'testuser', 'Username accessor method works');

done_testing;
