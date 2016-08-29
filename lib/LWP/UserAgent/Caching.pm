package LWP::UserAgent::Caching;

=head1 NAME

LWP::UserAgent::Caching

=cut

use parent 'LWP::UserAgent';
use HTTP::Caching;

=head1 SYNOPSIS

    use LWP::UserAgent::Caching;
    
    my $ua = LWP::UserAgent::Caching->new(
        cache           => {
            driver          => 'File',
            root_dir        => '/tmp/LWP_UserAgent_Caching',
            file_extension  => '.cache',
            l1_cache        => {
                driver          => 'Memory',
                global          => 1,
                max_size        => 1024*1024
            }
        },
        cache_type      => 'private',
        cache_control   => (
            'max-age=86400',            # 24hrs
            'min-fresh=60',             # not over due within the next minute
        )
    );
    
    my $rqst = HTTP::Request->new( GET => 'http://example.com' );
    
    $rqst->header( cache_control => 'no-cache' ); # Oh... now we bypass it ?
    $rqst->header( accept_language => 'nl, en-GB; q=0.9, en; 0.8, *' ); 
    
    my $resp = $ua->request($rqst);

or a bit simpler:

    
    my $ua = LWP::UserAgent::Caching->new;
    my $resp = $ua->get( 'http://example.com/cached?');
    

=cut

sub new {
    my ( $class, %params ) = @_;

    $self = SUPER::new(@_);

    $self->{http_caching} = HTTP::Caching->new(
        cache                   => %params{cache},
        cache_type              => %params{cache_type} || 'private',
        cache_control_request   => %params{cache_control},
        forwarder               => sub { SUPER::request(shift) }
    );

    return $self;
}

sub request {
    return shift->{http_caching}->request(@_);
}

1;
