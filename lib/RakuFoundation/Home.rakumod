unit class RakuFoundation::Home;

use Air::Functional :BASE;
use Air::Base;

sub home-page(&basepage, $shadow) is export {
    basepage
        main [
            $shadow;
            grid :grid-template-columns("1fr 2fr 1fr"), [
                div [];
                div :align<center>, [
                    h1 'The Raku Foundation';
                    h3 'The oversight body of the Raku programming language.';
                    p 'The Raku Foundation coordinates the Raku language specification, supports the Rakudo implementation team, and stewards the broader community and ecosystem.';
                ];
                div [];
            ];

            spacer;

            grid :cols(2), :gap(2), [
                article [
                    markdown q:to/END/;
                    ## Formation & Membership

                    On 1 May 2026, a legal entity for _The Raku Foundation_ was registered in the Netherlands.

                    It is going to take a little time for the Executive Board to put in place
                    the registration of Raku community members and democratic procedures
                    consistent with the legal requirements in the Netherlands so that
                    members will be able to democratically participate in the decision-making.

                    _Raku contributors (of all kinds) interested in membership please register above._

                    END
                    footer [ a('legal registration →', :href<https://www.kvk.nl/bestellen/#/42050836g>, :target<_blank>) ];
                ];
                article [
                    markdown q:to/END/;
                    ## Rationale

                    The rationale for a separate Raku Foundation was set forward on 18 June 2025 by Elizabeth Mattijsen in an article on Dev.to.

                    There have been detailed discussions with all those who responded to the
                    original post, and anyone who wanted to get involved. This also means
                    that members of the Raku Steering Council and The Perl and Raku
                    Foundation have been consulted with. A draft set of Articles of
                    Association, Regulations, and Code of Conduct have been written and were
                    linked to in various places. The aim was to create a community-driven
                    organisation with annual elections, and to be true to the -oFun paradigm.

                    END
                    footer [ a('rationale →', :href<https://dev.to/lizmat/towards-a-raku-foundation-3ne2>, :target<_blank>) ];
                ];
                article [
                    markdown q:to/END/;
                    ## Executive Board

                    The legal incorporation required the registration of an initial Executive
                    Board. The following Raku Community members have agreed to serve:

                    - Elizabeth Mattijsen (_lizmat_)

                    - Bruce Gray (_Util_)

                    - Patrick Boeker (_patrickb_)

                    - Richard Hainsworth (_finanalyst_)

                    - Tadeusz Sośnierz (_tadzik_)

                    END
                ];
                article [
                    markdown q:to/END/;
                    ## Cyber Resiliance Act

                    A driving motivation for the immediate formation of The Raku Foundation
                    in a country in the European Union is the Cyber Resiliance Act, which
                    will make it mandatory for any software that is sold or licensed in the
                    European Union to define its dependencies, to have a mechanism for
                    reporting and fixing faults, and establishes legal responsibility for
                    those who sell software. This has major consequences for FOSS
                    developers, which the EU has taken into account, by creating a new
                    category of entity called _Open-source software steward_.

                    END
                    footer [ a('cra white paper →', :href<https://github.com/orcwg/orcwg/blob/main/cyber-resilience-sig/whitepapers/stewards-and-cra.md>, :target<_blank>) ];
                ];
                article [
                    header [ h3 'Language' ];
                    p 'Raku is a multi-paradigm, high-level language with a rich type system, native Unicode support, built-in grammars, and first-class concurrency.';
                    footer [ a('raku.org →', :href<https://raku.org>, :target<_blank>) ];
                ];
                article [
                    header [ h3 'Implementation' ];
                    p 'Rakudo is the reference implementation of Raku, running on the MoarVM virtual machine. It is open source and actively developed.';
                    footer [ a('rakudo.org →', :href<https://rakudo.org>, :target<_blank>) ];
                ];
                article [
                    header [ h3 'Specification' ];
                    p 'The Raku specification is defined by the roast test suite — a community-maintained set of tests that all conformant implementations must pass.';
                    footer [ a('github.com/Raku/roast →', :href<https://github.com/Raku/roast>, :target<_blank>) ];
                ];
                article [
                    header [ h3 'Documentation' ];
                    p 'Official language documentation covering the standard library, built-in types, operators, and language features with worked examples.';
                    footer [ a('docs.raku.org →', :href<https://docs.raku.org>, :target<_blank>) ];
                ];
                article [
                    header [ h3 'Modules' ];
                    p 'A growing ecosystem of community modules available via the zef package manager. Search, install and publish at raku.land.';
                    footer [ a('raku.land →', :href<https://raku.land>, :target<_blank>) ];
                ];
                article [
                    header [ h3 'Community' ];
                    p 'Chat via IRC (#raku on Libera.Chat), Discord or Reddit (r/rakulang). Please join in if you have any questions or would like to learn more.';
                    footer [ a('raku.org/community →', :href<https://raku.org/community>, :target<_blank>) ];
                ];
            ];
        ];
}
