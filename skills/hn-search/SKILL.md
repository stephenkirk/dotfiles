---
name: hn-search
description: Research a question by mining Hacker News stories and comments via the HN Algolia API. Use when the user wants to know "what does HN think about X", "what should I use for Y in $YEAR", or wants to find the deep takes / dissent on a tool, library, or approach by looking around HN.
---

# hn-search

Mine Hacker News for the deep takes on a question — "starting a blog in 2026, what's
the actual way now?", "vim vs emacs?", "is X worth it?". The kind of thing where HN
comments are the answer.

This skill is **plumbing + search craft**, not a verdict machine. Drive the API well,
hand back clean, well-chosen, faithfully-cited evidence, and let the caller (usually an
agent that's already editorialising — or you, the human) draw the conclusion. The
value you add over raw `curl` is in *how you search* and *what you bring back*, not in
opinions.

## The helper

`./hn-search` (in this skill dir) is a thin fetch wrapper — URL-encoding, the right
endpoint, HTML-entity decoding, field-trimming. That's all.

```
hn-search stories  "<query>"   [opts]   # canonical discussions (the big Ask/Show HN threads)
hn-search comments "<query>"   [opts]   # scattered deep takes that never had their own thread
hn-search thread   <story-id>           # flatten one discussion's full comment tree, indented

opts:  --recent        sort by date instead of relevance (for time-sensitive questions)
       --min-points N   drop hits below N points  (STORIES ONLY — comment points are always 0)
       -n N             number of hits (default: stories 10, comments 20)
       --json           raw API JSON, for piping to jq
```

For anything the helper doesn't cover, go straight to the API — see `reference.md`.
The one numeric field that's server-filterable is `created_at_i` (epoch seconds), e.g.
a tight date window:
```
curl -sG https://hn.algolia.com/api/v1/search --data-urlencode "query=astro blog" \
  --data-urlencode "tags=story" --data-urlencode "numericFilters=created_at_i>1735689600" | jq ...
```

## How to search HN (the craft)

Don't overthink it, but do this much:

1. **Strip the prose to keywords.** "I used jekyll and hugo, what's the way now?" →
   queries like `static site generator`, `blog markdown`, `hugo`, `jekyll`. Algolia is
   keyword full-text; feeding it a whole sentence returns garbage.
2. **Run a few narrow queries, not one fat one.** Union the hits, dedupe by `objectID`.
3. **Search the pain, not just the topic.** `hugo too complex`, `jekyll alternative`
   finds the people who felt what the user feels — usually higher signal.
4. **Use the two searches as different instruments.** `stories` finds the canonical
   threads; `comments` finds the deep takes scattered across unrelated stories. Run both.
5. **Iterate once if thin.** Sparse or low-point hits → reformulate (synonyms,
   broader/narrower) before reporting back, rather than "not much on HN".

## Relevance vs. recency

Relevance is the spine; recency is a corrective lens, applied deliberately:

- **Default to relevance** (the deep threads), but always surface each hit's date and
  **flag old takes** — "this 2021 thread loved X; check it still holds."
- **For time-sensitive questions** ("now / today / 2026 / still?"), do a second
  `--recent` pass and reconcile: does current chatter confirm or contradict the
  canonical advice?
- **`--min-points` cuts noise on stories** — a 200-pt thread from last year beats a
  3-pt one from last week. (No effect on comments; rank those by relevance + judgement.)

## What to hand back

Curated evidence, not a verdict (the caller editorialises). Default shape:

- **Grouped by source thread** — keep each discussion intact, replies under their
  parent, so disagreement-in-context survives. This is the default: clustering by
  stance is itself an editorial act that belongs to the caller.
- **Decoded, trimmed text** — the actual takes, not your summary of them.
- **Receipts on everything** — `news.ycombinator.com/item?id=…`, date, and points
  (stories), so the caller can weigh staleness/signal itself.
- **Show the queries you ran**, so they can be redone or refined by hand.

On request (or when a human is clearly driving and wants a quick read), regroup
**by position/stance** ("pro-Astro", "stay-with-Hugo", "just-a-folder-of-markdown") —
nicer for decision-making, but it discards reply structure, so it's opt-in. Only
synthesise an actual verdict if asked.

## Gotchas

- **Comment points are always `0`** — HN no longer exposes them. Don't rank or filter
  comments by points; use relevance/recency and read judgement.
- **Only `created_at_i` is server-filterable.** `points` and `num_comments` return
  HTTP 400 via `numericFilters`, despite what `reference.md` lists. `--min-points` is
  done client-side in the helper.
- **HTML entities/tags** in text (`&#x2F;`, `&gt;`, `<p>`) are decoded by the helper.
  If you hit the API raw, you'll need to decode them yourself.
- **Rate limit:** 10,000 requests/hour per IP. A normal research session is nowhere near.
