#!/usr/bin/env raku
use RakuFoundation;

sub MAIN( :$host, :$port, :$scss, :$watch ) {
    $RakuFoundation::site.start:
          :$host, :$port, :$scss, :$watch;
}