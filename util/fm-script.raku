#!/usr/bin/env raku

use Data::Dump::Tree;

my @lines = "../static/demos/demo-script".IO.lines;

my @sections;
my %sections;
my $current;

for @lines -> $line {
    # ignore everything before #1.
    next unless $line ~~ /^ '#1.' / ff *;

    # section header
    if $line ~~ /^\s* '#' \d+ '.' \s* (.+) $/ {
        $current = ~$0.trim;
        %sections{$current} = [];
        @sections.append: $current;
        next;
    }

    # skip blank lines
    next if $line.trim eq '';

    %sections{$current}.push($line) if $current;
}


for @sections { .say; ddt %sections{$_} }
say @sections;
