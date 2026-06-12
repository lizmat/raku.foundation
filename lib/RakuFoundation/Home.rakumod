unit class RakuFoundation::Home;

use Air::Functional :BASE;
use Air::Base;
use RakuFoundation::MemberForm;

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
                    spacer;
                    p 'Register your interest in membership';
                ];
                div [];
                div [];
                $member;
                div [];
            ];

            spacer;

            dashboard [
                panel [
                    header h3 'Formation & Membership';
                    main markdown q:to/END/;

                    On 1 May 2026, a legal entity for _The Raku Foundation_ was registered in the Netherlands.
                    A _Stichting_ with registration number 42050836.

                    Community feedback shaped the formation; the aim throughout has been a
                    member-driven organisation with annual elections and the `-Ofun` paradigm
                    at its heart.

                    It is going to take a little time for the Executive Board to put in place
                    the registration of Raku community members and procedures
                    consistent with the legal requirements in the Netherlands so that
                    members will be able to democratically participate in the decision-making.

                    _Raku contributors (of all kinds) will shortly be invited to join the membership.
                    You are most welcome and kindly encouraged to register your interest above._

                    END
                    footer a('legal registration →', :href<https://www.kvk.nl/bestellen/#/42050836/>, :target<_blank>);
                ];
                panel [
                    header h3 'Rationale';
                    main markdown q:to/END/;

                    Raku began as Perl6 and inherited its organisational home — Yet Another
                    Society, now The Perl and Raku Foundation. That connection has always
                    felt like a historical remnant: TPRF struggles to raise funding
                    specifically for Raku, and the communities have grown apart.

                    A dedicated Raku Foundation gives the language its own independent
                    representation and fundraising ethos — letting TPRF refocus on Perl
                    while Raku charts its own course.

                    There is also a timely opportunity: the EU Cyber Resilience Act
                    introduces the category of _Open-source software steward_, a role
                    the Foundation is well-placed to fill before the 2027 deadline.

                    The rationale for a separate Raku Foundation was set forward on
                    18 June 2025 by Elizabeth Mattijsen in an article on Dev.to.

                    END
                    footer a('rationale →', :href<https://dev.to/lizmat/towards-a-raku-foundation-3ne2>, :target<_blank>);
                ];
                panel [
                    header h3 'Executive Board';
                    main markdown q:to/END/;

                    The legal incorporation required the registration of an initial Executive
                    Board. The following Raku Community members have agreed to serve:

                     - Patrick Böker (_patrickb_)

                     - Bruce Gray (_Util_)

                     - Richard Hainsworth (_finanalyst_)

                     - Elizabeth Mattijsen (_lizmat_)

                     - Tadeusz Sośnierz (_tadzik_)

                    END
                ];
                panel [
                    header h3 'Cyber Resilience Act';
                    main markdown q:to/END/;

                    A driving motivation for the immediate formation of The Raku Foundation
                    in a country in the European Union is the Cyber Resilience Act, which
                    will make it mandatory for any software that is sold or licensed in the
                    European Union to define its dependencies, to have a mechanism for
                    reporting and fixing faults, and establishes legal responsibility for
                    those who sell software. This has major consequences for FOSS
                    developers, which the EU has taken into account, by creating a new
                    category of entity called _Open-source software steward_.

                    END
                    footer a('CRA white paper →', :href<https://github.com/orcwg/orcwg/blob/main/cyber-resilience-sig/whitepapers/stewards-and-cra.md>, :target<_blank>);
                ];
                panel [
                    header [ h3 'Language' ];
                    p 'Raku is a multi-paradigm, high-level language with a rich type system, native Unicode support, built-in grammars, and first-class concurrency.';
                    footer [ a('raku.org →', :href<https://raku.org>, :target<_blank>) ];
                ];
                panel [
                    header [ h3 'Implementation' ];
                    p 'Rakudo is the reference implementation of Raku, running on the MoarVM virtual machine. It is open source and actively developed.';
                    footer [ a('rakudo.org →', :href<https://rakudo.org>, :target<_blank>) ];
                ];
                panel [
                    header [ h3 'Specification' ];
                    p 'The Raku specification is defined by the roast test suite — a community-maintained set of tests that all conformant implementations must pass.';
                    footer [ a('github.com/Raku/roast →', :href<https://github.com/Raku/roast>, :target<_blank>) ];
                ];
                panel [
                    header [ h3 'Documentation' ];
                    p 'Official language documentation covering the standard library, built-in types, operators, and language features with worked examples.';
                    footer [ a('docs.raku.org →', :href<https://docs.raku.org>, :target<_blank>) ];
                ];
                panel [
                    header [ h3 'Modules' ];
                    p 'A growing ecosystem of community modules available via the zef package manager. Search, install and publish at raku.land.';
                    footer [ a('raku.land →', :href<https://raku.land>, :target<_blank>) ];
                ];
                panel [
                    header [ h3 'Community' ];
                    p 'Chat via IRC (#raku on Libera.Chat), Discord or Reddit (r/rakulang). Please join in if you have any questions or would like to learn more.';
                    footer [ a('raku.org/community →', :href<https://raku.org/community>, :target<_blank>) ];
                ];
            ];
        ];
}

