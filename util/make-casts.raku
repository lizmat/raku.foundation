#!/usr/bin/env raku

use Data::Dump::Tree;

constant $path = "../static/demos/";
constant $from = "demo-script";
constant $freq = '1';

## First, we set up some common data and subs

my $script = q:to/END/;
2 + 3 * 4           #bidmas precedence
(2+3) * 4           #parentheses
-0.1-0.2            #negatives
1.23e4 / 23         #divide
(7/2) % 3           #modulo (%)
END

my $head = q:to/END/;
{"version":3,"term":{"cols":116,"rows":36,"type":"xterm-256color","theme":{"fg":"#ffffff","bg":"#1e1e1e","palette":"#000000:#990000:#00a600:#999900:#0000b3:#b300b3:#00a6b3:#bfbfbf:#666666:#e60000:#00d900:#e6e600:#0000ff:#e600e6:#00e6e6:#e6e6e6"}},"timestamp":1770210678,"idle_time_limit":1.0,"env":{"SHELL":"/bin/zsh"}}
[0.000, "o", "\r\u001b[0m\u001b[27m\u001b[24m\u001b[J~ > \u001b[K\u001b[?2004h"]
[1.524, "o", "c"]
[0.203, "o", "r"]
[0.191, "o", "a"]
[0.090, "o", "g"]
[0.603, "o", "\u001b[?2004l\r\r\n"]
[0.964, "o", "> "]
END

my $tail = q:to/END/;
[2.395, "o", "e"]
[0.314, "o", "x"]
[0.296, "o", "i"]
[0.116, "o", "t"]
[1.000, "o", "\r\n"]
[1.000, "o", "\r\n"]
[1.000, "o", "\r\n"]
[1.000, "o", "\r\n"]
[1.000, "o", "\r\n"]
END

sub line-out($s) {
    my $rand = $freq.rand.round(0.001).fmt('%.3f');
    qq`[$rand, "o", "$s"]`;
}

sub line-run($line) {
    say my $res = qqx`crag -- \'$line\'`.trim;

    my $stanza;
    $stanza ~= .&line-out ~ "\n" for $line.comb;
    $stanza ~= .&line-out given '\r\n';
    $stanza ~= "\n";
    $stanza ~= .&line-out given $res ~ '\r\n';
    $stanza ~= "\n";
    $stanza ~= .&line-out given '> ';
    $stanza ~= "\n";
    $stanza;
}

sub cast-out($section, @script) {
    my $to = "demo-$section.cast";

    my $out-str = $head;

    for @script -> $line {
        say $line;
        $out-str ~= $line.split('#')[0].trim.&line-run.trim ~ "\n";
    }

    $out-str ~= $tail.trim;

    spurt "$path$to", $out-str;
}


my @lines = "$path$from".IO.lines;

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

for @sections {
    .say;
    cast-out($_, %sections{$_})
}

#for @sections { .say; ddt %sections{$_} }
#say @sections;
#ddt %sections<Arithmetic>;