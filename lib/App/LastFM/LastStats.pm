use Feature::Compat::Class;

class App::LastFM::LastStats {

  use strict;
  use warnings;
  no warnings 'experimental::class';
  use feature 'say';

  use Net::LastFM;
  use Getopt::Long;

  field $username :param = 'davorg';
  field $period   :param = '7day';
  field $lastfm   = Net::LastFM->new(
    api_key    => $ENV{LASTFM_API_KEY},
    api_secret => $ENV{LASTFM_SECRET},
  );
  field $method   = 'user.getTopArtists';
  field $data;
  field @artists;

  method run {
    $self->laststats;

    @artists = @{$data->{topartists}{artist}}[0 .. 9];

    $self->render;
  }

  method render {
    say "* $_->{name} ($_->{playcount})" for @artists;
  }

  method laststats {
    $data = $lastfm->request_signed(
      method => $method,
      user   => $username,
      period => $period,
    );
  }
}

1;