---
layout: default
title: Upcoming Events
nav_order: 1
parent: Events
has_children: true
has_toc: true
search_exclude: true
---

# Upcoming Events

Check the calendar below for upcoming L⁺QC community events. New event announcements will appear on this page when published.

<div class="responsive-embed responsive-embed--calendar">
  <iframe src="https://calendar.google.com/calendar/embed?wkst=2&ctz=Europe%2FLondon&mode=AGENDA&src=bG9uZG9ucXVhbGl0YXRpdmVjb21tdW5pdHlAZ21haWwuY29t&color=%23039be5" title="L⁺QC events calendar" loading="lazy"></iframe>
</div>

[Add to Google Calendar](https://calendar.google.com/calendar/u/0/r?cid=londonqualitativecommunity@gmail.com){: .btn .btn-outline .mr-2 }
[Open in new tab](https://calendar.google.com/calendar/embed?src=bG9uZG9ucXVhbGl0YXRpdmVjb21tdW5pdHlAZ21haWwuY29t){: .btn .btn-outline }

{% assign announcements = site.pages | where: "parent", "Upcoming Events" %}
{% if announcements.size == 0 %}
> There are currently no upcoming event announcements published on this site. Browse [Past Events](/docs/Events/past-events) for earlier announcements.
{: .note }
{% endif %}
