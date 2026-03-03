unit module Cragcli;

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Asciinema;

my $source = external :href<https://github.com/librasteve/raku-App-Crag>;

sub code-note($s) {
    p( :style('font-size:small; text-align:right'), em("...$s") )
}
sub vignette(*@a, *%h) {
    grid :grid-template-columns<2.2fr 3.2fr>, :gap(1.5), |%h, @a
}

my &index = &page.assuming( #:REFRESH(15),
    title => 'CragCLI',
    description => 'Command line Calculator using Raku Grammars',

    nav => nav(
        logo =>
            span(
                a( :href<https://cragcli.info>, :target<_self>, :style("display: flex; align-items: center; gap: 0.5rem; text-decoration: none;"),
                [
                    img( :src</img/IMG_0159_mid.png>, :width<80px> );
                    p "CragCLI";
                ])
            ),
        items   => [:$source],
        widgets => [lightdark],
    ),

    footer => footer(
        p safe Q|
        Hypered with <a href="https://htmx.org" target="_blank">htmx</a>.
        Aloft on <a href="https://github.com/librasteve/Air" target="_blank"><b>&Aring;ir</b></a>.
        Remembered by <a href="https://fco.github.io/Red/" target="_blank">red</a>.
        Constructed in <a href="https://cro.raku.org" target="_blank">cro</a>.
        &nbsp;&amp;&nbsp;
        Styled by <a href="https://picocss.com" target="_blank">picocss</a>.
    |),
);

my @tools = [Analytics.new: :provider(Umami), :key<132eec10-cb18-4a4a-be38-84f6d693f249>,];

# https://commons.wikimedia.org/wiki/File:Horsenden_Hill_contours.jpg#Licensing
my &shadow = &background.assuming(
    :src</img/Horsenden_Hill_contours.jpg>,
    :top(120), :height(480), :size('cover'),
);

our $site =
site :@tools, :register[Background.new, LightDark.new, Air::Plugin::Asciinema.new, Tabs.new], :theme-color<green>, :bold-color<saddlebrown>,
    index
        main [
            shadow;
            div :align<center>, [
                h1 b 'CragCLI: Command Line Calculator';
                spacer;
            ];

            div [
                p :style('margin-bottom: unset;'), b em 'the boring bits: ';
                tabs [
                    Arithmetic => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### 1. Arithmetic

                                As you would expect, all math operations are here.

                                  - `+`add,`-`subtract, `*`multiply, `/`divide
                                  - `()` parentheses (bidmas precedence)
                                  - `-ve` numbers
                                  - `%` modulo operator
                                  - exact rational math

                                Just type `crag` in your console.

                                Type `exit` to quit.

                                END
                                code-note 'starts in 1 second [note 1]';
                            ];
                            article [
                                asciinema '/static/demos/demo-Arithmetic.cast';
                            ];
                        ];

                    Functions => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### 2. Functions

                                Powers and roots are here too.

                                  - `x%` percentage
                                  - `1/x` reciprocal
                                  - `x!` factorial
                                  - `sqrt x` square root
                                  - `x**2`, `x**3`, `x**n` powers
                                  - `x**(1/2)`, `x**(1/3)`, `x**(1/n)` roots

                                Use `Up` / `Down` keys to navigate history.

                                History persists between sessions.
                                END
                                code-note 'right in your terminal ';
                            ];
                            article [
                                asciinema '/static/demos/demo-Functions.cast';
                            ];
                        ];

                    Logarithms => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### 3. Logarithms

                                Logarithms are provided with exponential inverse.

                                  - `log10 x` base `10` logarithms
                                  - `log x` natural logarithms (base `e`)
                                  - `exp x` exponentials

                                Use `$_` for the previous result (the topic)
                                END
                                code-note 'Euler\'s identity works fine';
                            ];
                            article [
                                asciinema '/static/demos/demo-Logs.cast';
                            ];
                        ];

                    Trigonometry => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### 4. Trigonometry

                                Trigonometric and hyperbolic functions with inverse (arc-) variants.

                                  - `sin x`, `cos x`, `tan x` trigonometry
                                  - `asin x`, `acos x`, `atan x` inverse
                                  - `sinh x`, `cosh x`, `tanh x` hyperbolics
                                  - `asinh x`, `acosh x`, `atanh x` inverse

                                Use `Inf` (or ∞) for infinity.
                                END
                                code-note 'degrees, radians, grads';
                            ];
                            article [
                                asciinema '/static/demos/demo-Trig.cast';
                            ];
                        ];

                    Complex => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### 5. Complex

                                A built-in number type that works with the operations and functions.

                                  - `i` Imaginary
                                  - `3+4i` Complex
                                  - `.abs` absolute magnitude

                                Use `i` represents square root of `-1`.
                                END
                                code-note 'polar coordinate transformations';
                            ];
                            article [
                                asciinema '/static/demos/demo-Complex.cast';
                            ];
                        ];

                    Random => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### 6. Random

                                  - `rand` random generate (0-1)
                                  - `10.rand` random in range (0 <= x < 10)
                                  - `(1..6).pick: 6` random select
                                  - `(1..6).roll: 6` random repeat

                                Use `.pick` for one time, `.roll` is like a dice.
                                END
                                code-note 'uses the MT19937 — Mersenne Twister algorithm';
                            ];
                            article [
                                asciinema '/static/demos/demo-Random.cast';
                            ];
                        ];

                    Memory => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### 7. Memory

                                Use `$` or `@` to denote a named variable.

                                  - `$x=42` set Scalar variable `$x`
                                  - `$x/7` recall variable `$x`
                                  - `$_` (dollar underscore) is the previous result
                                  - `@a` is an array variable (i.e. a list of items)
                                  - `@a[i]` to index an array
                                  - `<>` to quote a wordlist
                                .
                                END
                                code-note 'hashes (dictionaries) too e.g. %h{}';
                            ];
                            article [
                                asciinema '/static/demos/demo-Memory.cast';
                            ];
                        ];

                    Types => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### 8. Types

                                A comprehensive set of number types is included.

                                  - `42` Int (big integer)
                                  - `<2/3>` Rat (rational fraction)
                                  - `1.424e-2` Num (IEEE P754 float 64)
                                  - `3+4i` Complex
                                  - `Inf` infinity and `NaN` not a number
                                  - `<2/3> * <3/4>` exact fractions
                                  - `1.424e-2 * <270/7>` type mixing

                                Unlimited precision & range.
                                END
                                code-note 'calculate with googol range';
                            ];
                            article [
                                asciinema '/static/demos/demo-Types.cast';
                            ];
                        ];

                    Rounding => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### 9. Rounding

                                Rounding precision is controlled by the `r()` function.

                                  - `floor`, `ceiling` and `abs` functions
                                  - default rounding is `0.001` (3 digits)
                                  - `r 0.1` is 1 digit, `r 0.00001` is 5 digits
                                  - `r Nil` turns off rounding

                                END
                                code-note 'intermediate values keep full precision';
                            ];
                            article [
                                asciinema '/static/demos/demo-Rounding.cast';
                            ];
                        ];
                ];
            ];

            div [
                p :style('margin-bottom: unset;'), b em 'the cool stuff: ';
                tabs [
                    LLM => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### 10. LLM

                                Grab AI info directly into your calculations.

                                  - get text ... `?<query>`
                                  - get amount ... `?^<query in units>`

                                Use amounts in calculations, store them in memory.
                                END
                                code-note 'all popular LLM platforms';
                            ];
                            article [
                                asciinema '/static/demos/demo-LLM.cast';
                            ];
                        ];

                    SIUnits => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### 11. SI Units

                                  - `42m` metres
                                  - `10s` seconds
                                  - `42cm` SI prefixes
                                  - `80kg` kilograms
                                  - `42m / 10s` speed in m/s (s=d/t)
                                  - `20kg * g` weight in N (F=ma)
                                  - `$_ .in: 'lb'` conversion
                                  - `$_ * 4m` energy in J (E=Fd)
                                  - `(10m~10%)+(5m~0.2)` error handling

                                Both relative `%` and absolute error values can be specified with `~`.
                                END
                                code-note 'dimensional analysis checks';
                            ];
                            article [
                                asciinema '/static/demos/demo-SIUnits.cast';
                            ];
                        ];

                    Units => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### 12. Units (General)

                                General syntax is `^<value units [~error]>`.

                                  - `^<4 in ~10%>` general
                                  - `^<4 ins>` plural
                                  - `^<4 inch>` synonyms
                                  - `^<23:59:59>` time
                                  - `^<30º10'5">` angle (degrees)
                                  - `^<pi rad>` angle (radians)
                                  - `64Mib` data
                                  - `US$ 25` currency

                                Special variants are provided for time, angle, data and currency.
                                END
                                code-note 'strong unit type checks';
                            ];
                            article [
                                asciinema '/static/demos/demo-Units.cast';
                            ];
                        ];

                    Conversions => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### 13. Conversions

                                Use the `.in: ''` operation to convert units.

                                  - `£20  .in: 'US$'` currency
                                  - `39ºC .in: 'ºF'` temperature
                                  - `10N  .in: 'lb'` weight
                                  - `^<4 in> .in: 'm'` length

                                END
                                code-note 'a vast set of US, UK and SI units is provided';
                            ];
                            article [
                                asciinema '/static/demos/demo-Conversions.cast';
                            ];
                        ];

                    Bases-Unicode => tab
                        vignette :direction, [
                            article [ markdown q:to/END/;
                                #### 10. Bases & Unicode

                                  - `0b101010` binary
                                  - `0o52` octal
                                  - `0x2A` hex
                                  - `0d42` decimal
                                  - `0rXXXXII` roman
                                  - `c<red>` CSS colors
                                  - `42.base(23)` any base
                                  - `0xFF + 0b1` mixed-base math
                                  - `0b1010 +< 2` bit shift
                                  - `0b1010 +& 0b0110` bitwise AND, OR, XOR, NOT
                                  - `'π'.ord` codepoint value
                                  - `'π'.uniname` unicode name
                                  - `'π'.uniprops` unicode properties

                                Wide range of microprocessor instructions.
                                END
                                code-note 'power tools for coders';
                            ];
                            article [
                                asciinema '/static/demos/demo10.cast';
                            ];
                        ];

                    Variables-Strings => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### 4. Variables & Strings

                                Use `$` variables for flexible memory.

                                  - `$x = 42` store, `$x` recall
                                  - `$_` use previous result
                                  - `$s = "hi"` text strings too
                                  - `"ans is $x"` interpolation with `""`
                                  - `~` string concatenation
                                  - `@a = (1,2,3,4)` number list
                                  - `@s = <a b c d>` word list
                                END
                                code-note 'memory for intermediate results';
                            ];
                            article [
                                asciinema '/static/demos/demo4.cast';
                            ];
                        ];

                    Ranges-Sequences => tab
                        vignette :direction<rtl>, [
                            article [ markdown q:to/END/;
                                #### 6. Ranges & Sequences

                                  - `"hi" xx 4` repetition
                                  - `5..12` the range from `5` to `12`
                                  - `|(5..12)` use `|()` to flatten it
                                  - `(5..12)[3]` indexing (from 0)
                                  - `|^12` use `^` as a shorthand for `0..11`
                                  - `3,6...15` arithmetic sequence
                                  - `1,2,4...16` geometric sequence
                                  - `(0,1,*+*...Inf)[^8]` fibonacci sequence (first 8)

                                Use the `*` _whatever_ to define the next-value operation.
                                END
                                code-note 'infinite lazy sequences';
                            ];
                            article [
                                asciinema '/static/demos/demo6.cast';
                            ];
                        ];
                ];
            ];

            markdown q:to/MDEND/;

                ## Get Started

                CragCLI is Free Open Source Software built on the Raku REPL. It provides a unified CLI to several Raku modules. No Ads Ever.

                ---

                ***PROVIDED "AS IS" WITHOUT WARRANTY OR LIABILITY***

                ***NOT INTENDED FOR USE IN MISSION CRITICAL APPLICATIONS***

                ---

                ### Step 1

                Install the Raku compiler:

                  - Linux => `curl https://rakubrew.org/install-on-perl.sh | sh`
                  - macOS => `curl https://rakubrew.org/install-on-macos.sh | sh`

                Then:

                  - `rakubrew download`
                  - `rakubrew switch`

                See [https://raku.org/install](https://raku.org/install) for other platforms and package managers

                ### Step 2

                Install and run App::Crag:

                  - `zef install App::Crag --/test`
                  - `crag '0.1+0.2'`  one-liner
                  - `crag` interactive REPL

                ---

                ## Get Help

                  - `crag --help`
                  - [Get More Examples](https://github.com/librasteve/raku-App-Crag/blob/main/crag-of-the-day.md)
                  - [Get In Touch](https://raku.org/community)

                ---

                ## Notes

                  1. Starts in approx. 1sec (as measured on an M1 MacBook, takes longer on first run).

                  2. For LLM::DWIM features, you will need e.g. a free of charge [Gemini App Key](https://ai.google.dev/gemini-api/docs/api-key) and go `export GEMINI_API_KEY=mykeygoeshere`.

                  3. Currency exchange rates are provided as at the installation date, reinstall crag (`zef install App::Crag --/test --force-install`) to refresh them.

                  4. crag is a full Raku repl - so you can write subroutines, loops, conditionals, comparisons and so on (see [https://docs.raku.org](https://docs.raku.org))

                  5. If your calculations outgrow the crag app, you can use the underlying crag modules in Raku code.
                MDEND
        ];
