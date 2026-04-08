# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Jekyll site for the London⁺ Qualitative Community (L⁺QC), published at [londonqualcommunity.com](https://londonqualcommunity.com) via GitHub Pages. Built with Jekyll 4.4.1 + [Just the Docs](https://just-the-docs.github.io/just-the-docs/) 0.12.0. Pushes to `main` build and deploy automatically through `.github/workflows/pages.yml`; PRs run a build check via `.github/workflows/ci.yml` and a content lint via `.github/workflows/content-lint.yml`.

## Local development

```bash
bundle install              # first-time setup (Ruby pinned via .ruby-version)
bundle exec jekyll serve    # local preview at http://localhost:4000
bundle exec jekyll build    # what CI runs; output in _site/
```

Ruby version is pinned in `.ruby-version` (read by rbenv/asdf/chruby and by the `ruby/setup-ruby` GitHub Action). Workflows do not hardcode a version — update `.ruby-version` to bump everywhere in one place.

The deploy workflow builds with `JEKYLL_ENV=production` and `--baseurl`, so theme/asset behavior may differ from local serve. If something only breaks in production, reproduce with `JEKYLL_ENV=production bundle exec jekyll build`.

## Content architecture

The site is **navigation-driven by front matter**, not by directory layout. Just the Docs assembles the sidebar from `parent` / `grand_parent` / `nav_order` fields, so moving a file does not move it in the menu — editing front matter does.

Key conventions:

- **Events lifecycle** is a front-matter flip, not a file move. To retire an event, change `parent: Upcoming Events` → `parent: Past Events` in the event's `.md` file. The file stays in `docs/Events/`. `content-lint.sh` warns if an event's title date is in the past and `parent:` is still `Upcoming Events`.
- **`nav_order` for events** uses the `YYYYx` pattern (`2025a`, `2025b`, ...) so chronologically related events sort together. `past-events.md` sets `child_nav_order: reversed` so the newest past events appear first; `upcoming-events.md` uses the default ascending order so upcoming events read chronologically.
- **Templates** in `_templates/` (`upcoming-event.md`, `past-event.md`) are the canonical starting point for new event pages. They carry minimal front matter — only `title`, `nav_order`, and `parent` — because `layout` and `has_toc` come from the `defaults:` block in `_config.yml` automatically (see [Configuration](#configuration)). Body uses the emoji-style layout (📅 Date & Time, 📍 Location, 🔗 Registration) which is the canonical format for 2026+ events. The `_templates/` directory is a repo convention, not a Jekyll feature — files there are copy-paste sources, not a Jekyll collection. README.md walks non-technical contributors through the copy flow.
- **`discussions/`** is excluded from the build via `_config.yml` `exclude:`. The custom `_layouts/discussion.html` exists for that excluded content; do not assume it's in use on the live site.
- **Assets** live flat under `assets/` (with `assets/logos/` for branding). Event pages reference them as `/assets/filename.ext` — root-relative paths, which work because the site is served from the apex domain (`CNAME` → londonqualcommunity.com), not a subpath.
- **CSS helpers** in `_sass/custom/custom.scss`: `.responsive-embed` with `--calendar` (4:3) and `--doc` (A4 portrait) modifiers for scaling iframes (Google Calendar / Google Docs previews); `.committee-member-photo` for the Steering Committee photo grid. The file also honors `prefers-reduced-motion`.

## Configuration

`_config.yml` has two `defaults:` blocks that are load-bearing and mis-scoping either one has broken the site before:

1. **Sitewide `scope: ""`** sets `image: /assets/LQC.jpg` on every page. jekyll-seo-tag only reads `page.image` (a site-level `image:` key is ignored), so without this block no page emits `og:image` and social previews are broken. Do NOT move `image:` to the top level expecting it to work.
2. **`scope: "docs/Events"`** sets `layout: default` and `has_toc: true` for event pages. Do NOT add `grand_parent: Events` to this block — see Known gotchas.

Other notable config:

- **Custom callouts** (`callouts:` block): `new` (green), `deadline` (red), `archive` (grey-dk), `highlight` (yellow). Used via Kramdown attribute syntax: `> text\n{: .deadline }`.
- **Search tuning**: scoped to `heading_level: 2`, previews enabled, index pages set `search_exclude: true` (Events.md, upcoming-events.md, past-events.md, Committee Members.md) to keep search results content-focused.
- **Twitter/X tags deliberately not set** — L⁺QC has no handle. jekyll-seo-tag auto-emits `twitter:card: summary_large_image` when `og:image` is present, which covers LinkedIn/Slack/iMessage unfurlers. Setting a `twitter:` block without a real handle produces broken `twitter:site: @` and `twitter:creator: @<name>` tags.

## Known gotchas

All of these have shipped bugs before; the rules exist for a reason.

- **`parent == grand_parent` breaks the nav tree.** JTD silently drops any page whose `parent` equals its `grand_parent`, along with every descendant. PR #41 injected `grand_parent: Events` into a `docs/Events` defaults block, contaminating section shells that already had `parent: Events`, and the live site lost its entire events menu. Fixed in PR #43. The `content-lint.sh` `parent == grand_parent` check catches this in explicit front matter; it does NOT catch the case where a `defaults:` block injects the conflict post-hoc — when touching `_config.yml` defaults, manually verify each scoped path does not contain section-shell pages.
- **jekyll-seo-tag ignores site-level `image:`.** It only reads `page.image`. Set image via a sitewide `defaults:` block (scope: `""`), not at the top level of `_config.yml`.
- **`social.name` leaks into `twitter:creator`.** If set without a real `twitter.username`, jekyll-seo-tag emits `twitter:creator: @<social.name>`. Keep `social.links` for schema.org `sameAs`, but drop `social.name`.
- **Extensionless files in `docs/Events/` are invisible.** Jekyll silently skips files without `.md`. Three stale drafts accumulated this way before PR #40 cleaned them up; `content-lint.sh` now fails on any extensionless file under `docs/Events/`.
- **Event pages outside `docs/Events/` have wrong URLs.** Nav still resolves via front matter, but URLs become `/docs/foo` instead of `/docs/Events/foo`. `content-lint.sh` fails on any `.md` with `parent: Upcoming Events` / `Past Events` located outside `docs/Events/`.
- **Jekyll `defaults` are load-order sensitive.** Broader scopes first, narrower scopes after. Explicit front matter in a file always wins over defaults.
- **`has_children: true` without real children** renders an empty expander arrow. Set `has_children: false` on leaf pages even if they have sub-sections in the body.

## CI guardrails

- **`.github/workflows/ci.yml`** — `bundle exec jekyll build` on PRs. Catches Jekyll/Liquid errors.
- **`.github/workflows/pages.yml`** — build + deploy on push to `main`.
- **`.github/workflows/content-lint.yml`** — runs `.github/scripts/content-lint.sh` on PRs and `main`. The lint is a ~100-line bash script; the header comment enumerates its six checks (ERROR: extensionless files, wrong-directory events, `parent == grand_parent`; WARN: duplicate nav_order, TBD/TBC placeholders, past-dated upcoming events). Extend this script when new content patterns start recurring.

## Editing guidance

- **README.md is the contributor-facing manual** for non-technical committee members editing via the GitHub web UI. If you change the events workflow, the templates, or the directory layout, update README.md to match — its step-by-step instructions are load-bearing for the community.
- **Don't bypass the templates.** New events should start from `_templates/upcoming-event.md`. The template's minimal front matter (only `title`, `nav_order`, `parent`) relies on the `defaults:` block; see Configuration.
- **Dependency pins in `Gemfile`** include explicit security floor overrides (`rexml`, `google-protobuf`, `webrick`, `addressable`) tied to CVEs. Don't remove them when bumping Jekyll or just-the-docs — they're regression guardrails, and leaving them in place costs nothing when the installed version is already above the floor.
- **Dependabot is configured to track both direct and transitive deps** (no `dependency-type: direct` filter). Transitive security advisories auto-PR — don't re-add the filter.

## Tooling note

Per user global preferences, this repo uses Ruby/Bundler (not bun/uv) — it's a Jekyll site. The `bun`/`uv` defaults from `~/.claude/CLAUDE.md` do not apply here.
