unit class RakuFoundation;

use Air::Functional :BASE;
use Air::Base;

use RakuFoundation::Home;
use RakuFoundation::HTML404;
use RakuFoundation::MemberForm;

my &basepage = &page.assuming(
    title       => 'Raku Foundation',
    description => 'raku.foundation — the oversight body of the Raku programming language',
    favicon     => '/img/favicon.ico',

    footer      =>  footer [
        hr;
        p safe Q|
            Hypered with <a href="https://htmx.org" target="_blank">htmx</a>.
            Aloft on <a href="https://harcstack.org" target="_blank"><b>&Aring;ir</b></a>.
            Constructed in <a href="https://cro.raku.org" target="_blank">cro</a>.
            Written in <a href="https://raku.org" target="_blank">Raku</a>.
            &nbsp;&amp;&nbsp;
            Styled by <a href="https://picocss.com" target="_blank">picocss</a>.
        |;
        p safe 'Please report any issues with this site at <a href="https://github.com/Raku/raku.org" target="_blank">Raku/raku.org</a>.';
        p safe 'The Raku® Programming Language';
    ],
);

my $shadow = background(
    :src</img/caterpillar-worm-psf-f0a4ab-small.png>,
    :top<160px>, :left<20vw>, :width<60vw>, :height<100vh>, :size<auto>,
    :opacity(0.05), :filter('invert(1) blur(1.5px)'),
);

my Page $home   = home-page   &basepage, $shadow;
my Page $html404 = html404-page &basepage, $shadow;

my Nav $nav =
    nav(
        logo => (
            span a :href<https://raku.org>, :target<_self>, :style("display: flex; align-items: center; gap: 0.5rem; text-decoration: none;"),
                [
                    img :src</img/camelia-logo.png>, :width<60px>,
                        :title('Hi, my name is Camelia. I\'m the spokesbug for the Raku Programming Language. Raku has been developed by a team of dedicated and enthusiastic open source volunteers, and continues to be developed. You can help too. The only requirement is that you know how to be nice to all kinds of people (and butterflies).');
                    p :style("margin:0"),"Raku®";
                ]
            ),
        :widgets[lightdark],
    );

$home.nav = $nav;

our $site =
    site :register[Background.new, LightDark.new, Dashboard.new, Panel.new, $member],
         :theme-color<green>, :bold-color<#0000F3>,
         :$html404,
         :pages[$home];
