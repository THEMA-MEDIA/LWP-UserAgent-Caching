requires "HTTP::Caching" => ">= 0.09";

require "LWP::UserAgent"        => "0";
require "HTTP::Request::Common" => "0";
require "HTTP::Request"         => "0";

on "test" => sub {
    require "Test::Most"        => "0";
    require "Test::MockObject"  => "0";
}
