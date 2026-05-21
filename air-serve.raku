#!/usr/bin/env raku
use RakuFoundation;

sub MAIN( :$host, :$port, :$scss=1, :$watch ) {
    $RakuFoundation::site.serve:
          :$host, :$port, :$scss, :$watch;
}