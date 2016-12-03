use LWP::UserAgent::Caching;
use CHI;

my $chi_cache = CHI->new(
    driver          => 'File',
    root_dir        => '/tmp/LWP_UserAgent_Caching',
    file_extension  => '.cache',
);

my $chi_cache_meta = CHI->new(
    driver          => 'File',
    root_dir        => '/tmp/LWP_UserAgent_Caching',
    file_extension  => '.cache',
    l1_cache        => {
        driver          => 'Memory',
        global          => 1,
        max_size        => 1024*1024
    }
);

my $ua = LWP::UserAgent::Caching->new(
    cache           => $chi_cache,
#   cache_meta      => $chi_cache_meta,
);

# $HTTP::Caching::DEBUG = 1;

my $method  = shift;
my $url     = shift;

if ($method =~ /^GET$/i ) {
print "\n#####\n";
print "\nGETTING\n";
print "\n#####\n";


    my $resp = $ua->get($url);
    print $resp->headers->as_string;
    exit
}

my $http_request = HTTP::Request->new( $method, $url );

my $http_response = $ua->request($http_request);

print $http_response->headers->as_string;