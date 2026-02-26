#!/usr/bin/env raku

constant $freq = '1';

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
    my $res = qqx`crag -- \'$line\'`.trim;

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

#my $one = $script.lines[0].split('#')[0].trim;
#say line-run($_) given $script.lines[0].split('#')[0].trim;

say $head.trim;
for $script.lines -> $line {
    say $line.split('#')[0].trim.&line-run.trim;
}
say $tail.trim;
