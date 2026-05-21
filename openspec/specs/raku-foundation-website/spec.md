## Purpose

Define the structure, content, and behavior of the raku.foundation website — the oversight body of the Raku programming language.

## Requirements

### Requirement: Page shell

The site SHALL be constructed using `site` (Air::Base) with:
- `@tools` containing an `Analytics` instance using the Umami provider
- `:register` listing `Background.new`, `Dashboard.new`, `Panel.new`, and `$member` (MemberForm)
- `:theme-color<green>`
- `:bold-color<#0000F3>`
- `:$html404` for a custom 404 page

The single page SHALL be constructed via `page.assuming(...)` with:
- `title => 'Raku Foundation'`
- `description => 'raku.foundation — the oversight body of the Raku programming language'`
- `favicon => '/img/favicon.ico'`

#### Scenario: Page renders with correct title and favicon

- **WHEN** the page is served
- **THEN** the HTML `<title>` is `Raku Foundation`
- **AND** the favicon link points to `/img/favicon.ico`

### Requirement: Navigation bar

The nav bar SHALL be constructed using `nav` (Air::Base) with:
- `logo` — a `span` wrapping an `a` (`:href<https://raku.org>`, `:target<_self>`) containing an `img` (`:src</img/camelia-logo.png>`, `:width<60px>`) and a `p "Raku®"`
- No nav items (logo-only nav)

#### Scenario: Nav renders Camelia logo

- **WHEN** the page loads
- **THEN** the nav shows the Camelia butterfly logo
- **AND** clicking it navigates to `https://raku.org`

### Requirement: Footer

The footer SHALL contain a `p safe Q|...|` crediting:
- htmx linking to `https://htmx.org` (target `_blank`)
- Åir linking to `https://harcstack.org` (target `_blank`)
- Cro linking to `https://cro.raku.org` (target `_blank`)
- Raku linking to `https://raku.org` (target `_blank`)
- picocss linking to `https://picocss.com` (target `_blank`)

And a second paragraph linking issue reports to `https://github.com/Raku/raku.org`.

#### Scenario: Footer renders all credits

- **WHEN** the page loads
- **THEN** the footer contains links to htmx, Åir, Cro, Raku, and picocss

### Requirement: Hero section

The `main` area SHALL open with a `grid :grid-template-columns("1fr 2fr 1fr")` centering:
- `h1 'The Raku Foundation'`
- `h3 'The oversight body of the Raku programming language.'`
- A `p` describing the Foundation's coordinating role

A Camelia watermark `background(...)` SHALL be positioned behind the hero at low opacity with blur.

#### Scenario: Hero text is rendered centred

- **WHEN** the page loads
- **THEN** `The Raku Foundation` appears as an `h1` centred on the page

### Requirement: Member registration form

A `Member` form (Air::Form, `lib/RakuFoundation/MemberForm.rakumod`) SHALL appear between the hero and the dashboard, accepting:
- `$.name` (required, name validation)
- `$.nick` (optional, name validation)
- `$.email` (required, email input, email validation)

The submit button SHALL read `Register Interest`.

On valid submission the server SHALL log the form data and return `Thank you — we will be in touch!`.
On invalid submission the server SHALL retry with the partially-filled form and validation errors.

#### Scenario: Form submits successfully

- **WHEN** a user fills in name and email and clicks Register Interest
- **THEN** the form swaps via HTMX to a thank-you message

### Requirement: Dashboard

A `dashboard` containing ten `panel` elements SHALL follow the form.

**Foundation panels:**
1. Formation & Membership — legal registration, Stichting 42050836, link to KvK
2. Rationale — independence from TPRF, EU CRA steward opportunity, link to lizmat's dev.to article
3. Executive Board — lizmat, Util, patrickb, finanalyst, tadzik
4. Cyber Resilience Act — CRA motivation, open-source steward category, link to ORC white paper

**Ecosystem panels:**
5. Language — raku.org
6. Implementation — rakudo.org
7. Specification — github.com/Raku/roast
8. Documentation — docs.raku.org
9. Modules — raku.land
10. Community — IRC, Discord, Reddit, raku.org/community

Each panel SHALL have a `header`, body content via `markdown q:to/END/`, and where appropriate a `footer` with a linked call-to-action.

#### Scenario: Dashboard renders in flex-wrap layout

- **WHEN** the page loads on a wide viewport
- **THEN** panels are displayed in a two-column flex-wrap layout via the `dashboard` CSS

### Requirement: Analytics

The site SHALL include Umami analytics via `Analytics.new :provider(Umami) :key<4464d54a-3dbe-4f79-8d45-1ef4f22cd677>` in `@tools`.

#### Scenario: Analytics script is included

- **WHEN** the page HTML is rendered
- **THEN** the Umami analytics script tag is present in the document
