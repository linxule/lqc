# London⁺ Qualitative Community Website

This is the repository for [londonqualcommunity.com](https://londonqualcommunity.com) — the home of the **London⁺ Qualitative Community (L⁺QC)**, a UK-based network of management scholars championing qualitative research and the methods behind it. The site is maintained by the Steering Committee, and this README is the manual for keeping it up to date.

**No coding experience required.** Everything in this guide can be done from a web browser using GitHub's built-in editor. If you can edit a Google Doc, you can edit this site.

---

## What you can do from this README

| I want to... | Jump to |
|---|---|
| Post a new upcoming event | [Add a new upcoming event](#add-a-new-upcoming-event) |
| Move an event that's finished into Past Events | [Move an event to Past Events](#move-an-event-to-past-events) |
| Add a photo or image to a page | [Add an image](#add-an-image) |
| Add or update a committee member | [Add or update a Committee Members page](#add-or-update-a-committee-members-page) |
| Fix a typo or edit a page | [Edit an existing page](#edit-an-existing-page) |
| Understand the small extras (callouts, embeds) | [Nice-to-know extras](#nice-to-know-extras) |
| Work out why my change is showing a red X | [When something goes wrong](#when-something-goes-wrong) |

---

## Add a new upcoming event

This is the most common task. It takes about five minutes.

### Step 1 — Copy the template below

Here is the full `_templates/upcoming-event.md` file. Select it and copy it. (You don't need to navigate to the templates folder — it's reproduced here so you can copy-paste straight from this page.)

```markdown
---
title: EVENT NAME [LOCATION, DD/MM/YYYY]
nav_order: YYYYx
parent: Upcoming Events
---

# EVENT NAME [LOCATION, DD/MM/YYYY]

Presented by SPEAKER NAME(S)

BRIEF DESCRIPTION of what the event is about and why someone would attend.

📅 Date & Time: DAY, MONTH DD, YYYY | HH:MM-HH:MM (BST)

📍 Location: VENUE NAME, ADDRESS

🔗 Registration: [Register here](REGISTRATION_URL)

Questions? Reach out to the L+QC Steering Committee at [londonqualitativecommunity@gmail.com](mailto:londonqualitativecommunity@gmail.com).
```

That's the whole file. Four lines of front matter (the bit between the `---` fences) and a short body. Everything else — the page layout, the table of contents, the styling — is applied automatically by the site.

### Step 2 — Create the new event file

1. In GitHub, open the `docs/Events/` folder.
2. Click **Add file** → **Create new file**.
3. Name the file using lowercase and hyphens, ending in `.md`. For example:
   - `2026-autumn-writing-workshop.md`
   - `2026-spring-research-day.md`

   The `.md` extension is essential — without it the site will silently skip your page.

4. Paste the template into the editor.

### Step 3 — Fill in the placeholders

Replace the UPPERCASE placeholders with your real event details. Here is a worked example:

```markdown
---
title: Autumn Writing Workshop [LBS, 14/11/2026]
nav_order: 2026d
parent: Upcoming Events
---

# Autumn Writing Workshop [LBS, 14/11/2026]

Presented by Dr Jane Smith (London Business School)

A hands-on workshop on turning qualitative fieldwork into publishable papers.
Bring a draft or an idea — we'll workshop it together.

📅 Date & Time: Saturday, November 14, 2026 | 10:00-16:00 (GMT)

📍 Location: London Business School, Regent's Park, London NW1 4SA

🔗 Registration: [Register here](https://example.com/register)

Questions? Reach out to the L+QC Steering Committee at [londonqualitativecommunity@gmail.com](mailto:londonqualitativecommunity@gmail.com).
```

A few notes on the front matter:

- **`title`** — the sidebar label. The `[VENUE, DD/MM/YYYY]` suffix is what the automatic check uses to notice when an event date has passed, so please keep the date in that format. For multi-date events (like a workshop series that runs over several months), use the format `[LOCATION, Month-Month YYYY]` instead, e.g. `[Online, Jan-March 2026]`. See `docs/Events/2026-writing-tips.md` for a live example.
- **`nav_order`** — controls the order events appear in the list. Use the year plus a letter: `2026a` for the first event of 2026, `2026b` for the second, `2026c` for the third, and so on. Each letter must be unique within the same year.
- **`parent`** — leave this as `Upcoming Events` while the event is still in the future. You'll change it to `Past Events` after the event happens (see next section).

### Step 4 — Commit (publish) your changes

1. Scroll down to **Commit changes**.
2. Write a short message like `Add autumn writing workshop event`.
3. Click **Commit changes**.

The site will rebuild and your event will appear at [londonqualcommunity.com](https://londonqualcommunity.com) within 1–2 minutes.

---

## Move an event to Past Events

When an event has happened, it should be moved into the Past Events section. This is a **one-line change**.

1. Open the event's `.md` file in `docs/Events/`.
2. Click the **pencil icon** to edit.
3. In the front matter at the top, change:

   ```yaml
   parent: Upcoming Events
   ```

   to:

   ```yaml
   parent: Past Events
   ```

4. While you're there, feel free to tidy the description into past tense, or remove the `🔗 Registration:` line if it's no longer relevant.
5. Scroll down, write a commit message like `Move writing workshop to past events`, and click **Commit changes**.

The file stays exactly where it is — only the `parent:` line changes.

**If you forget:** the site's automatic check runs on every change and will warn you if an event's title date is in the past but the page is still marked `Upcoming Events`. You'll see it as a note on your pull request.

### Optional: add a post-event recap

Past events look much nicer with a few photos and a sentence or two about how the day went. This is worth doing once the event has taken place, you have photos to hand, and you can say something about attendance or highlights.

1. Upload the photos to the `assets/` folder (see [Add an image](#add-an-image) for the exact steps).
2. Open the event's `.md` file and add a `## Photos` heading near the bottom.
3. Underneath, include each photo with the same `<img>` pattern shown in the "Add an image" section.
4. Optionally change the description at the top into past tense and add a short recap paragraph — who attended, what was discussed, any standout moments.
5. Remove the `🔗 Registration:` line, since it's no longer relevant.

For a worked example of what a tidied-up past event looks like, see `docs/Events/2025-2026-feb-research-day.md` — it has a short recap paragraph and an acknowledgements list for the organising committee.

---

## Add an image

### Step 1 — Upload the image

1. Open the `assets/` folder in GitHub.
2. Click **Add file** → **Upload files**.
3. Drag your image in, or click to browse.
4. Use a descriptive filename like `2026-autumn-workshop-group-photo.jpg`. Stick to lowercase and hyphens — no spaces.
5. Click **Commit changes**.

### Step 2 — Reference the image from a page

Add this line where you'd like the image to appear in your event file:

```html
<img src="/assets/2026-autumn-workshop-group-photo.jpg" style="max-width: 100%; height: auto;">
```

The leading slash (`/assets/...`) is important — it tells the site to look for the image from the root of the site.

---

## Add or update a Committee Members page

There are two pages under `docs/Committee Members/`:

- **`Steering Committee.md`** — the core committee that runs L⁺QC. Each entry has a name, email, profile link, and headshot photo.
- **`School Representatives.md`** — one section per institution, listing that school's Faculty and Student Representatives as a simple bulleted list (no photos).

The two files use different formats, so pick the right one before you start.

### Adding a new Steering Committee member

1. In GitHub, open `docs/Committee Members/Steering Committee.md` and click the pencil icon to edit.
2. Upload the person's headshot to the `assets/` folder first if you haven't already (see [Add an image](#add-an-image)).
3. Inside the `<div class="container">` block, add a new `<div class="person">...</div>` entry in alphabetical order alongside the others. Use this exact pattern:

   ```html
   <div class="person">
   <p><a href="https://example.ac.uk/people/firstname-lastname"><b>Firstname Lastname</b></a> (<a href="mailto:firstname.lastname@example.ac.uk">Email</a>)</p>
   <img src="/assets/firstname.jpg" alt="Firstname Lastname" class="committee-member-photo">
   </div>
   ```

   Replace the four placeholders: the profile URL, the display name, the email address, and the photo filename. Leave `class="committee-member-photo"` exactly as it is — it's what gives every headshot the same size and styling.

4. Scroll down, write a commit message like `Add Firstname Lastname to Steering Committee`, and click **Commit changes**.

### Adding a new School Representative

1. Open `docs/Committee Members/School Representatives.md`.
2. Find the `## School Name` heading for the right institution. Schools are in alphabetical order; if the school isn't listed yet, add a new `## School Name` heading in the right place.
3. Add the person as a bullet underneath, matching the style already in the file:

   ```markdown
   - [Firstname Lastname](https://example.ac.uk/people/firstname-lastname) (Faculty Representative)
   - Firstname Lastname (Student Representative)
   ```

   The profile link is optional — plenty of existing entries are plain text.
4. Commit with a short message like `Add Firstname Lastname as School Rep for Example University`.

### Updating or removing an existing person

To update someone, just edit the relevant text in place (name, email, link, or photo filename) — it's the same as editing any other page.

To remove a Steering Committee member, delete the entire `<div class="person">...</div>` block for that person. To remove a School Representative, delete their bullet line. If a school ends up with no representatives at all, delete the `## School Name` heading too.

---

## Edit an existing page

For typos, small updates, or any other content change:

1. Navigate to the file you want to edit.
2. Click the **pencil icon** (Edit this file).
3. Make your changes.
   - Before committing, click the **Preview** tab at the top of the editor to see how your change will render. It's not a perfect match for the live site but it'll catch most typos and broken markdown.
4. Scroll down, add a short commit message, and click **Commit changes**.

### Swapping out the Research Seminars document

If the Google Doc behind the Research Seminars page changes (for example, a new academic year gets its own document), open `docs/Events/ResearchSeminars.md` and update **two** links — both point to the same doc but use different suffixes.

1. Inside the `<iframe src="...">` tag, replace the URL. This one ends in `/preview`:

   ```html
   <iframe src="https://docs.google.com/document/d/NEW_DOC_ID/preview" ...></iframe>
   ```

2. In the `[Open in Google Docs](...)` button just below the iframe, replace the URL. This one ends in `/edit?usp=sharing`:

   ```markdown
   [Open in Google Docs](https://docs.google.com/document/d/NEW_DOC_ID/edit?usp=sharing){: .btn .btn-outline }
   ```

Before committing, make sure the new document is shared with **Anyone with the link can view** in Google Docs. If it isn't, the embedded iframe will show a "you need permission" error to visitors.

---

## Nice-to-know extras

These are small touches you can sprinkle in if they're useful. None of them are required.

### Callouts

You can highlight a line or paragraph with a coloured callout by adding a special tag below it. The available styles are `.new`, `.deadline`, `.archive`, and `.highlight`. For example, to draw attention to a registration deadline:

```markdown
> Registration closes on Friday, 1 November 2026.
{: .deadline }
```

That renders as a red "Deadline" callout on the page.

### Embedding a calendar or Google Doc

To embed a responsive iframe (for example, a Google Calendar or a public Google Doc), wrap it in one of these `div` classes:

```html
<div class="responsive-embed responsive-embed--calendar">
  <iframe src="YOUR_CALENDAR_URL"></iframe>
</div>
```

Use `responsive-embed--doc` for Google Docs. The Upcoming Events page already uses this for the community calendar.

---

## When something goes wrong

When you commit a change, GitHub runs an **automatic content check** on it. If everything is fine you'll see a green tick. If something looks off you'll see a **red X** next to your commit or pull request.

Click the red X (or the **Details** link beside it) to see what the check is complaining about. The check is designed to catch the mistakes that have caused real problems in the past:

- A new event file is missing the `.md` extension (Jekyll will silently skip it).
- An event file has ended up outside `docs/Events/`.
- Two events in the same year are using the same `nav_order` letter.
- A page still has a `TBD` or `TBC` placeholder left in it.
- An event's title date has passed but it's still marked `Upcoming Events`.

The message will tell you which file and which line. Fix it, commit again, and the check will re-run.

If you're stuck, commit what you have and email the committee — someone will jump in.

---

## Need help?

Email the Steering Committee at **[londonqualitativecommunity@gmail.com](mailto:londonqualitativecommunity@gmail.com)**. Whether it's a content question, a technical hiccup, or just a sanity check before you hit commit, we're happy to help.

---

## File layout at a glance

```
docs/
  Events/
    upcoming-events.md      ← section page, don't edit
    past-events.md          ← section page, don't edit
    2026-your-event.md      ← individual events live here
  Committee Members/        ← steering committee info
  Resources/                ← resources page

assets/                     ← images and photos

_templates/
  upcoming-event.md         ← copy-paste starting points
  past-event.md
```

### Files to leave alone

Most of the other files in the repository are part of the site's underlying machinery — the templates, styles, and automated checks that make everything work. They don't usually need to be touched, and editing them can break the site in ways that aren't always obvious straight away. If you're not sure, it's safer to leave them be.

In particular, please don't edit the following unless you know what you're doing:

- `_config.yml` — the site's main settings.
- `.github/` — the automated checks and workflows that run on every commit.
- `_layouts/`, `_includes/`, `_sass/` — the site's templates and styling.
- `Gemfile` and `Gemfile.lock` — software versions the site is built against.
- `.ruby-version` — which version of Ruby the site uses.
- `_templates/upcoming-event.md` and `_templates/past-event.md` — you **should** copy from these when adding a new event, but don't edit the originals themselves. Changing a template affects every future event.

If you think one of these needs updating, email the committee first — someone with technical background can take care of it.

---

## Technical details

This site is built with [Jekyll](https://jekyllrb.com) using the [Just the Docs](https://just-the-docs.github.io/just-the-docs/) theme and hosted on [GitHub Pages](https://pages.github.com). Changes pushed to the `main` branch are automatically published within 1–2 minutes.

Developers and AI assistants working on the site's structure, build, or CI should consult `CLAUDE.md` in the repository root for architecture notes and local development instructions.
