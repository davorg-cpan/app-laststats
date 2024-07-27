use Feature::Compat::Class;

class App::LastFM::LastStats {

  use strict;
  use warnings;
  no warnings 'experimental::class';
  use feature 'say';

  use Net::LastFM;
  use Getopt::Long;
  use JSON;

  field $username :param = 'davorg';
  field $period   :param = '7day';
  field $format   :param = 'text';
  field $count    :param = 10;
  field $lastfm   = Net::LastFM->new(
    api_key    => $ENV{LASTFM_API_KEY},
    api_secret => $ENV{LASTFM_SECRET},
  );
  field $method   = 'user.getTopArtists';
  field $data;
  field @artists;

  field $renderer = {
    text => \&render_text,
    html => \&render_html,
    json => \&render_json,
  };

  method run {
    GetOptions(
      'user=s'   => \$username,
      'period=s' => \$period,
      'format=s' => \$format,
      'count=i'  => \$count,
    );

    $self->laststats;
    $self->render;
  }

  method render_text {
    say "* $_->{name} ($_->{playcount})" for @artists;
  }

  method render_json {
    my $pos = 1;

    my @data = map { {
      position => $pos++,
      name     => $_->{name},
      count    => $_->{playcount},
    } } @artists;
    say JSON->new->canonical(1)->encode(\@data);
  }

  method render_html {
    my $html = "<ol>\n";
    $html .= "  <li>$_->{name} ($_->{playcount})</li>\n" for @artists;
    $html .= "</ol>";
    say $html;
  }

  method render {
    my $method;
    unless ($method = $renderer->{$format}) {
      die "Invalid render format: $format\n";
    }

    $self->$method;
  }

  method laststats {
    my $page = 1;

    while (@artists < $count) {

      $data = $lastfm->request_signed(
        method => $method,
        user   => $username,
        period => $period,
        limit  => $count,
        page   => $page++,
      );

      last unless @{$data->{topartists}{artist}};

      push @artists, @{$data->{topartists}{artist}};
    }

    $#artists = $count - 1 if @artists > $count;
  }
}

1;

