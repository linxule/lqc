# London+ Qualitative Community Website

This is the repository for [londonqualcommunity.com](https://londonqualcommunity.com).

We are a vibrant community of management scholars from across the United Kingdom who champion research using qualitative data and help advance the tools, techniques, and methods for qualitative research.

---

## For Contributors: How to Update the Website

This guide is for community members who need to add or edit content. No coding experience required!

### Quick Links

| I want to... | Go to... |
|--------------|----------|
| Add a new upcoming event | [Adding a New Event](#adding-a-new-event) |
| Move an event to "Past Events" | [Moving an Event to Past Events](#moving-an-event-to-past-events) |
| Add images or photos | [Adding Images](#adding-images) |
| Edit existing content | [Editing Existing Pages](#editing-existing-pages) |

---

## Adding a New Event

### Step 1: Copy the template

1. Go to the `_templates` folder in this repository
2. Open `upcoming-event.md`
3. Click the **Copy raw file** button (or select all and copy the text)

### Step 2: Create your new file

1. Go to the `docs/Events` folder
2. Click **Add file** > **Create new file**
3. Name your file using this format: `your-event-name.md`
   - Use lowercase letters
   - Use hyphens instead of spaces
   - Example: `spring-research-day.md`

### Step 3: Paste and edit the template

Paste the template content and replace the UPPERCASE placeholders with your event details:

```
---
layout: default
title: EVENT NAME [LOCATION, DD/MM/YYYY]    <-- Change this line
nav_order: YYYYx                             <-- Change this (see below)
parent: Upcoming Events
grand_parent: Events
has_children: false
has_toc: true
---
```

**About `nav_order`:** This controls where your event appears in the list. Use the year plus a letter:
- `2025a` for the first event of 2025
- `2025b` for the second event of 2025
- `2025c` for the third, and so on

### Step 4: Save your changes

1. Scroll down to "Commit changes"
2. Write a brief description like "Add spring research day event"
3. Click **Commit changes**

Your event will appear on the website within 1-2 minutes!

---

## Moving an Event to Past Events

When an event has concluded, move it from "Upcoming" to "Past":

### Step 1: Open the event file

1. Go to `docs/Events`
2. Find and open the event file you want to move

### Step 2: Edit the file

1. Click the **pencil icon** (Edit this file)
2. Find this line near the top:
   ```
   parent: Upcoming Events
   ```
3. Change it to:
   ```
   parent: Past Events
   ```

### Step 3: (Optional) Add photos or materials

If you have photos from the event, add them below the event description:

```markdown
## Photos

<img src="/assets/your-photo-name.jpg" style="max-width: 100%; height: auto;">
```

### Step 4: Save your changes

1. Scroll down and click **Commit changes**
2. Write a description like "Move research day to past events"

---

## Adding Images

### Step 1: Upload your image

1. Go to the `assets` folder
2. Click **Add file** > **Upload files**
3. Drag your image file or click to browse
4. Click **Commit changes**

**Tip:** Use descriptive filenames like `2025-research-day-group-photo.jpg`

### Step 2: Add the image to your page

In your event file, add this line where you want the image to appear:

```html
<img src="/assets/your-image-filename.jpg" style="max-width: 100%; height: auto;">
```

Replace `your-image-filename.jpg` with your actual filename.

---

## Editing Existing Pages

1. Navigate to the file you want to edit in GitHub
2. Click the **pencil icon** (Edit this file)
3. Make your changes
4. Click **Commit changes**

---

## File Structure Overview

```
docs/
  Events/
    upcoming-events.md      <-- Parent page (don't edit)
    past-events.md          <-- Parent page (don't edit)
    your-event.md           <-- Individual event pages go here
  Committee Members/        <-- Steering committee info
  Resources/                <-- Resources page

assets/                     <-- Images and photos go here

_templates/                 <-- Copy templates from here
  upcoming-event.md
  past-event.md
```

---

## Need Help?

- For website issues, contact the Steering Committee: londonqualitativecommunity@gmail.com
- For technical problems with the site building, check the Actions tab to see if there are any errors

---

## Technical Details

This site is built with [Jekyll](https://jekyllrb.com) using the [Just the Docs](https://just-the-docs.github.io/just-the-docs/) theme and hosted on [GitHub Pages](https://pages.github.com).

Changes pushed to the `main` branch are automatically published within 1-2 minutes.
