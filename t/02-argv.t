$ENV{LASTFM_API_KEY}    = 'SomeRandomKey';
$ENV{LASTFM_API_SECRET} = 'Sekrit';
use Test::More;
use App::LastStats;

# Test that passing username as a positional argument is not required
my $stats = App::LastStats->new(
    username => 'testuser',
    period => '7day',
    format => 'text',
    count => 5,
);

# Simulate what the main program does with ARGV (should not be needed)
my $stats_argv = App::LastStats->new(username => 'testuser');
ok($stats_argv, 'Object created with username positional argument');

# Ensure both objects have the correct username
is($stats->username, 'testuser', 'Username set via option');
is($stats_argv->username, 'testuser', 'Username set via positional argument');

done_testing;
