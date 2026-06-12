use Air::Functional :BASE;
use Air::Base;

# unit sub policyplan2026(&basepage, $shadow) is export;
my sub policyplan2026(&basepage, $shadow) is export {

basepage :stub<PolicyPlan2026>,
  main [
    $shadow;
    grid :grid-template-columns("1fr 2fr 1fr"), [
      div [];
      div :align<center>, [ h1 'Policy Plan 2026' ];
    ];

    spacer;

    dashboard [
      panel [
        header h3 'Bootstrapping is hard';
        main markdown q:to/END/;

Creating a Policy Plan for a new foundation means expressing ideas and goals without having much of an idea whether they will be achievable in 2026.  Especially being half-way through 2026 already.

This Policy Plan should therefore be seen as a blue-print for further developments in the coming years, with long-term, medium-term and short-term goals.
END
      ];

      panel [
        header h3 'Establishing the Foundation';
        main markdown q:to/END/;

The relationships between The Raku Foundation and the pre-existing Raku community, language development group, the Perl and Raku Foundation in the USA, and the transfer of the Raku  assets, such as logo, repository registrations, websites, need to be regularised and developed.

The Foundation also needs to establish institutional arrangements and registrations to take advantage of and to be consistent with the EU's new Cyber Resilience Act, as set out separately below.

Currently the copyright of the Raku Programming Language is owned by TPRF.  The TPRF board as already indicated willingness of transferring the copyright to The Raku Foundation.  But this will need some details to be worked out.
END
      ];

      panel [
        header h3 'Long-term goals';
        main markdown q:to/END/;

For a programming language that has been designed / designated to being a 100-year programming language, the long term goal of it could be considered quite long term indeed!

##### World Wide Fun!

Well, not really: but a long-term goal of the Raku Foundation *is* to make *more* people use the Raku Programming Language.  And one of mottos of the Raku Programming Language is "Optimized for Fun (-Ofun)".  A short overview of reasons why can be found on https://raku.org/.

##### Supporting the Raku Community

The resources of The Raku Foundation will be used to support the Raku Community in whatever way it can.  Examples of this support are:

 - financial support for organizing Raku related events (workshops / conferences / summits)
 - financial support for individuals attending Open Source events where the Raku Programming Language is promoted by them
 - grants for the development of aspects of the Raku Programming Language that stretch beyond the financial capabilities of developers
 - maintaining technical infrastructure needed for use / development of the Raku Programming Language
 - reimbursing costs made by volunteers for the Raku Programming Language
 - providing financial resources for running costs, such as service subscriptions
 - financial compensation of Executive Board members as indicated by Dutch law, should the financial situation of The Raku Foundation allow this
END
      ];

      panel [
        header h3 'Medium-term goals (before 1 January 2027)';
        main markdown q:to/END/;

##### Funding goal of 10,000€

A funding goal for 2026 of 10.000€ has been set, and is felt to be a realistic possibility of being reached.

##### Setting up a CVE number authority for the Raku Programming Language

This would most likely also include either a separate CVE number authority for MoarVM and NQP, or a single CVE number authority handling all Security related events for *anything* Raku related.

##### Register with the Dutch Cyber Security authorities

This will require registration with E-Herkenning, the company equivalent of DigiD in the Netherlands.  This involves a paid subscription, so can only be achieved when funding is available.

##### Achieve "Open Source Steward" status with the EU / Dutch Cyber Security authorities

A new type of body, as described in article 25 of the European Cyber Resilience Act.  It is yet unclear what would need to be done for this, but it appears to be required to be allowed to provide authorised security attestations.
END
      ];

      panel [
        header h3 'Short-term goals (before 1 August 2026)';
        main markdown q:to/END/;

These goals are short-term and really related to bootstrapping the Raku Foundation and making it independent from The Perl And Raku Foundation.

##### Ensure not-for-profit status

In the Netherlands a foundation needs to prove that they're really worth of being considered not-for-profit.  This approval needs to be gained as soon as possible.  With one of the prerequisites being having a publicly visible Policy Plan.

##### Secure funding

An organization such as The Raku Foundation can only exist thanks to the funding it receives.  To that end, the website will contain a sponsoring button as soon as possible, so that supporters of the Raku Programming Language will be able to show their support in a financial way.

The Raku Community Modules organization on Github will also allow sponsoring that will directly benefit The Raku Foundation.

Obtaining funding is of course a constant process.

##### Setting up an initial set of Regulations, Code of Conduct, Community Affairs Incident Response Guid

An initial set of Regulations was already agreed upon by the Executive Board members to be.

 - [Foundation Regulations](https://lizmat.github.io/Raku-Foundation-Documents/RakuFoundationRegulations.html)
 - [Code Of Conduct](https://lizmat.github.io/Raku-Foundation-Documents/RakuCodeOfConduct.html)
 - [Incident Response Guide](https://lizmat.github.io/Raku-Foundation-Documents/RakuCATGuide.html)

However, because the Articles of Association needed to be adapted to be acceptable by Dutch law, the Regulations will probably need tweaking before becoming accepted by the current Executive Board.

##### Setting up an Advisory Board

The Advisory Board will check on the functioning of The Raku Foundation in general, and the Executive Board in particular.

##### Hosting costs

Quite a few web sites are currently hosted on hardware paid for by TPRF.  The Raku Foundation will take over this tab as soon as it is able to do so.  This currently applies to:

 - [raku.org](https://raku.org)
 - [docs.raku.org](https://docs.raku.org)
 - [planet.raku.org](https://planet.raku.org)
 - [cro.raku.org](https://cro.raku.org)
 - [rakudo.org](https://rakudo.org)
 - [moarvm.org](https://moarvm.org)

Furthermore, quite a few Raku related websites are currently hosted or paid for by individuals and small companies.  The Raku Foundation thanks these individuals and companies for their support and extends the invitation to have their websites hosted at the cost of The Raku Foundation should they so wish to.  This currently at least applies to:

 - [raku.land](https://raku.land)
 - [360.zef.pm](https://360.zef.pm)
 - [raku.guide](https://raku.guide)
 - [irclogs.raku.org](https://irclogs.raku.org)
 - [slangify.org](https://slangify.org)
 - [rakudoweekly.blog](https://rakudoweekly.blog)
 - [raku-advent.blog](https://raku-advent.blog)

Furthermore it should be noted that all these websites are maintained and administered by volunteers.  The Raku Foundation thanks these individuals for their mostly invisible work!

##### Domain registration costs

Hosting a website can sometimes be done without incurring any additional costs.  But domain registrations typically need to be renewed once a year, and these are *real* costs.  The Raku Foundation will take over these costs whenever it is asked to do so for any recognized Raku Programming Language related website.
END
      ];

      panel [
        header h3 'Impressum';
        main markdown q:to/END/;

```
Stichting Raku Foundation
Bosstraat 15
6101 NV Echt
The Netherlands
Email: secretary@raku.foundation
CoC: 42050836
Tax: 869481277B01
ANBI: (application soon)
CBF: (application in 2027)
```

### Executive Board

In alphabetical order by last name:

 - Patrick Böker, Germany (patrickb)
 - Bruce Gray, USA (Util)⁺
 - Richard Hainsworth, UK (finanalyst)
 - Elizabeth Mattijsen, The Netherlands (lizmat)
 - Tadeusz Sośnierz, Poland (tadzik)⁺

⁺Still being processed for official registration as board member of The Raku Foundation
END
      ];
    ];
  ]
}
