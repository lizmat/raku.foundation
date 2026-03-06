#!/usr/bin/env raku

use Data::Dump::Tree;

constant $path = "../static/demos/";
constant $from = "demo-script";
constant $freq = '0.7';  #was 1.0
constant $last = 20;
#constant $mask-sh = ().SetHash;
constant $mask-sh = (^$last).SetHash;
$mask-sh{6}:delete;

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

#ddt @sections; die;

## Common head and tail

my $head = q:to/END/;   #note idle_time_limit was 1.0
{"version":3,"term":{"cols":116,"rows":36,"type":"xterm-256color","theme":{"fg":"#ffffff","bg":"#1e1e1e","palette":"#000000:#990000:#00a600:#999900:#0000b3:#b300b3:#00a6b3:#bfbfbf:#666666:#e60000:#00d900:#e6e600:#0000ff:#e600e6:#00e6e6:#e6e6e6"}},"timestamp":1770210678,"idle_time_limit":0.7,"env":{"SHELL":"/bin/zsh"}}
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

sub line-out($s) {
    my $rand = $freq.rand.round(0.001).fmt('%.3f');
    qq`[$rand, "o", "$s"]`;
}

sub drip($line, $stanza is rw) {
    $stanza ~= .&line-out ~ "\n" for $line.comb;
    $stanza ~= .&line-out given '\r\n';
    $stanza ~= "\n";
    $stanza;
}

sub drop($line, $stanza is rw) {
    $stanza ~= .&line-out ~ "\n" given $line;
    $stanza ~= .&line-out given '\r\n';
    $stanza ~= "\n";
    $stanza;
}

sub line-run($line, :$auto, :$prompt) {
    say $line;

    my $stanza;
    ##iamerejh
    #drip when prompt line
    if $prompt {
        $stanza ~= .&line-out given '> ';
        $stanza ~= "\n";

        drip($line, $stanza);
    } else {
        drop($line, $stanza);
    }

    if $auto {
        my $res = qqx`crag -- \'$line\'`.trim;
        drop($res, $stanza)
    }

    $stanza;
}

sub cast-out($section is copy, @script, :$auto) {
    $section ~~ s/<.ws> '(!auto)'//;
    say my $to = "demo-$section.cast";

    my $out-str = $head;

    my $prompt = 1;
    for @script -> $line {
        $prompt = $++ %% 2 unless $auto;
        $out-str ~= $line.split('#')[0].trim.&line-run(:$auto, :$prompt).trim ~ "\n";
    }

    $out-str ~= $tail.trim;

    spurt "$path$to", $out-str;
}

# output all sections
for @sections -> $section {
    my $this = $++;
    next if $this ∈ $mask-sh;

    my $auto = not $section ~~ /'!auto'/;
    say "$this: $section; auto: $auto";

    cast-out($section, %sections{$section}, :$auto);
}
