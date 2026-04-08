# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Jekyll site for the London⁺ Qualitative Community (L⁺QC), published at [londonqualcommunity.com](https://londonqualcommunity.com) via GitHub Pages. Built with the [Just the Docs](https://just-the-docs.github.io/just-the-docs/) theme. Pushes to `main` build and deploy automatically through `.github/workflows/pages.yml`; PRs run a build-only check via `.github/workflows/ci.yml`.

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

- **Events lifecycle** is a front-matter flip, not a file move. To retire an event, change `parent: Upcoming Events` → `parent: Past Events` in the event's `.md` file. The file stays in `docs/Events/`.
- **`nav_order` for events** uses the `YYYYx` pattern (`2025a`, `2025b`, ...) so chronologically related events sort together. `upcoming-events.md` sets `child_nav_order: reversed` so newer events appear on top.
- **Templates** in `_templates/` (`upcoming-event.md`, `past-event.md`) are the canonical starting point for new event pages. The `_templates/` directory is a convention of this repo, not a Jekyll feature — files there are not collections, just copy-paste sources. README.md walks contributors through the copy flow.
- **`discussions/`** is excluded from the build via `_config.yml` `exclude:`. The custom `_layouts/discussion.html` exists for that excluded content; do not assume it's in use on the live site.
- **Assets** live flat under `assets/` (with `assets/logos/` for branding). Event pages reference them as `/assets/filename.ext` — root-relative paths, which work because the site is served from the apex domain (`CNAME` → londonqualcommunity.com), not a subpath.

## Editing guidance

- **README.md is the contributor-facing manual** for non-technical committee members editing via the GitHub web UI. If you change the events workflow, the templates, or the directory layout, update README.md to match — its step-by-step screenshots-of-words instructions are load-bearing for the community.
- **Don't bypass the templates.** New events should start from `_templates/upcoming-event.md` so required front matter (`layout`, `parent`, `grand_parent`, `nav_order`) stays consistent.
- **Dependency pins in `Gemfile`** include explicit security overrides (`rexml`, `google-protobuf`, `webrick`, `addressable`) tied to CVEs. Don't remove these when bumping Jekyll or just-the-docs; check whether the transitive dep still needs the floor.

## Tooling note

Per user global preferences, this repo uses Ruby/Bundler (not bun/uv) — it's a Jekyll site. The `bun`/`uv` defaults from `~/.claude/CLAUDE.md` do not apply here.
