#!/usr/bin/env raku
use Cragcli;

sub MAIN( :$host, :$port, :$scss=1, :$watch ) {
    $Cragcli::site.serve:
          :$host, :$port, :$scss, :$watch;
}