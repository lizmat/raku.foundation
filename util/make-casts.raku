#!/usr/bin/env raku

use Data::Dump::Tree;

constant $path = "../static/demos/";
constant $from = "demo-script";
constant $freq = '0.4';  #1.0 is ponderous, 0.1 is lightning fast

my $last = 40; #much too large
my $dry-run = 0;
my $one-only = 34;  #set to index(s), Nil means do all

#eg agg demo-Arithmetic.cast demo-Arithmetic.gif --theme nord
my $agg = 1;

my $mask = ().SetHash;

with $one-only {
    $mask = (^$last).SetHash;
    $mask{$one-only}:delete;
}

my @lines = "$path$from".IO.lines;

my @sections;
my %sections;
my $current;

# ingest the demo-script
for @lines -> $line {
    # ignore everything before ####.
    next unless $line ~~ /^ '####' / ^ff *;

    # section header
    if $line ~~ /^\s* '##' \s* (.+) $/ {
        $current = ~$0.trim;
        %sections{$current} = [];
        @sections.append: $current;
        next;
    }

    # skip blank lines
    next if $line.trim eq '';

    %sections{$current}.push($line) if $current;
}

if $dry-run {
    ddt @sections;
    die "^^ this is the full list, add +1 for website text";
}

## Common head and tail

my $head = q:to/END/;   #note idle_time_limit was 1.0
{"version":3,"term":{"cols":64,"rows":12,"type":"xterm-256color","theme":{"fg":"#ffffff","bg":"#1e1e1e","palette":"#000000:#990000:#00a600:#999900:#0000b3:#b300b3:#00a6b3:#bfbfbf:#666666:#e60000:#00d900:#e6e600:#0000ff:#e600e6:#00e6e6:#e6e6e6"}},"timestamp":1770210678,"idle_time_limit":0.3,"env":{"SHELL":"/bin/zsh"}}
[0.000, "o", "\r\u001b[0m\u001b[27m\u001b[24m\u001b[J~ > \u001b[K\u001b[?2004h"]
[0.524, "o", "c"]
[0.203, "o", "r"]
[0.191, "o", "a"]
[0.090, "o", "g"]
[0.603, "o", "\u001b[?2004l\r\r\n"]
END

my $tail = q:to/END/;
[1.395, "o", "e"]
[0.314, "o", "x"]
[0.296, "o", "i"]
[0.116, "o", "t"]
[1.000, "o", "\r\n"]
[1.000, "o", "\r\n"]
[1.000, "o", "\r\n"]
[1.000, "o", "\r\n"]
[1.000, "o", "\r\n"]
END

sub chars-out($s, :$drop) {
    my $rand = (0.001).fmt('%.3f');
    $rand = $freq.rand.round(0.001).fmt('%.3f') unless $drop;
    qq`[$rand, "o", "$s"]`;
}

sub line-new($stanza is rw) {
    $stanza ~= .&chars-out given '\r\n';
    $stanza ~= "\n";
}

sub prompt-out($stanza is rw) {
    $stanza ~= .&chars-out given '> ';
    $stanza ~= "\n";
}

sub drip($stanza is rw, $line) {
    $stanza ~= .&chars-out ~ "\n" for $line.comb;
}

sub drop($stanza is rw, $line) {
    $stanza ~= .&chars-out(:drop) ~ "\n" given $line;
}

sub line-run($line, :$auto, :$prompt) {
    say $line;

    my $do-comment = so $line ~~ /'#'/;

    my ($code, $space, $comment) = '' xx 3;
    if $do-comment {
        $line ~~ /(.*?) (\s*) '#' (.*)/;
        ($code, $space, $comment) = $0, $1, $2;

#        say "$code";     # $v = ^<328 km/h>
#        say "$space#$comment";  #     # exit speed
    } else {
        $code = $line;
    }


    my $stanza;

    if $prompt {
        $stanza.&prompt-out;
        $stanza.&drip($code);
        $stanza.&drop("$space#$comment") if $do-comment;
        $stanza.&line-new;
    } else {
        $stanza.&drop($code);
        $stanza.&line-new;
    }

    if $auto {
        my $res = qqx`crag -- \'$code\'`.trim;
        $stanza.&drop($res);
        $stanza.&line-new;
    }

    $stanza;
}

sub cast-out($section is copy, @script, :$auto) {
    $section ~~ s/<.ws> '(!auto)'//;
    say my $cast = "demo-$section.cast";

    my $out-str = $head;

    my $prompt = 1;
    for @script -> $line {
        $prompt = $++ %% 2 unless $auto;
        $out-str ~= $line.trim.&line-run(:$auto, :$prompt).trim ~ "\n";
    }

    $out-str ~= $tail.trim;

    spurt "$path$cast", $out-str;

    if $agg {
        my $gif = "demo-$section.gif";
        my $cmd = "agg $path$cast $path$gif --theme nord";

        say qqx`$cmd`;
    }
}

# output all sections
for @sections -> $section {
    my $this = $++;
    next if $this ∈ $mask;

    my $auto = not $section ~~ /'!auto'/;
    say "$this: $section; auto: $auto";

    cast-out($section, %sections{$section}, :$auto);
}
