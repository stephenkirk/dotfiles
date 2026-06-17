# HN Search API

This API is built on top of [Algolia Search's API](https://www.algolia.com/doc/). It enables developers to access Hacker News data programmatically via a REST API. This document describes how to request data and how to interpret the responses.

## Items

```
GET https://hn.algolia.com/api/v1/items/:id
```

```json
{
  "id": 1,
  "created_at": "2006-10-09T18:21:51.000Z",
  "author": "pg",
  "title": "Y Combinator",
  "url": "http://ycombinator.com",
  "text": null,
  "points": 57,
  "parent_id": null,
  "children": [
    {
      "id": 15,
      "created_at": "2006-10-09T19:51:01.000Z",
      "author": "sama",
      "text": "&#34;the rising star of venture capital&#34; -unknown VC eating lunch on SHR",
      "points": 5,
      "parent_id": 1,
      "children": [
        {
          "id": 17,
          "created_at": "2006-10-09T19:52:45.000Z",
          "author": "pg",
          "text": "Is there anywhere to eat on Sandhill Road?",
          "points": 5,
          "parent_id": 15,
          "children": []
        }
      ]
    }
  ]
}
```

## Users

```
GET https://hn.algolia.com/api/v1/users/:username
```

```json
{
  "username": "pg",
  "about": "PG's bio",
  "karma": 99999
}
```

## Search

Sorted by relevance, then points, then number of comments:

```
GET https://hn.algolia.com/api/v1/search?query=...
```

Sorted by date, most recent first:

```
GET https://hn.algolia.com/api/v1/search_by_date?query=...
```

### Common query parameters

| Parameter        | Description                                              | Type    |
| ---------------- | ------------------------------------------------------- | ------- |
| `query`          | Full-text query                                         | String  |
| `tags`           | Filter on a specific tag (see below)                    | String  |
| `numericFilters` | Filter on a numerical condition (see below)             | String  |
| `page`           | Page number                                             | Integer |

**Available tags:** `story`, `comment`, `poll`, `pollopt`, `show_hn`, `ask_hn`, `front_page`, `author_:USERNAME`, `story_:ID`

Tags are ANDed by default, and can be ORed if placed between parentheses. For example, `author_pg,(story,poll)` filters on `author=pg AND (type=story OR type=poll)`.

**`numericFilters`** supports the operators `<`, `<=`, `=`, `>`, and `>=` on these fields: `created_at_i`, `points`, `num_comments`.

### Pagination

By default a limited number of results are returned per page, so a given query may span dozens of pages. The total number of pages and results per page are returned as `nbPages` and `hitsPerPage`. You can also pass them as arguments to request more results or iterate over pages, e.g. `&page=2` or `&hitsPerPage=50`.

The complete list of search parameters is available in the [Algolia Search REST API reference](https://www.algolia.com/doc/rest-api/search#QueryIndex).

### Examples

| Query                                          | URL                                                                                                  |
| ---------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| All stories matching `foo`                     | `search?query=foo&tags=story`                                                                         |
| All comments matching `bar`                    | `search?query=bar&tags=comment`                                                                       |
| All URLs matching `bar`                        | `search?query=bar&restrictSearchableAttributes=url`                                                   |
| Stories on the front/home page right now       | `search?tags=front_page`                                                                              |
| Latest stories                                 | `search_by_date?tags=story`                                                                           |
| Latest stories OR polls                        | `search_by_date?tags=(story,poll)`                                                                    |
| Comments since timestamp X (seconds)           | `search_by_date?tags=comment&numericFilters=created_at_i>X`                                           |
| Stories between timestamps X and Y (seconds)   | `search_by_date?tags=story&numericFilters=created_at_i>X,created_at_i<Y`                              |
| Stories by pg                                  | `search?tags=story,author_pg`                                                                         |
| Comments of story X                            | `search?tags=comment,story_X`                                                                         |

All URLs are relative to `https://hn.algolia.com/api/v1/`.

### Response

```json
{
  "hits": [
    {
      "title": "Y Combinator",
      "url": "http://ycombinator.com",
      "author": "pg",
      "points": 57,
      "story_text": null,
      "comment_text": null,
      "_tags": ["story"],
      "num_comments": 2,
      "objectID": "1",
      "_highlightResult": {
        "title": {
          "value": "Y Combinator",
          "matchLevel": "none",
          "matchedWords": []
        },
        "url": {
          "value": "http://ycombinator.com",
          "matchLevel": "none",
          "matchedWords": []
        },
        "author": {
          "value": "<em>pg</em>",
          "matchLevel": "full",
          "matchedWords": ["pg"]
        }
      }
    }
  ],
  "page": 0,
  "nbHits": 11,
  "nbPages": 1,
  "hitsPerPage": 20,
  "processingTimeMS": 1,
  "query": "pg",
  "params": "query=pg"
}
```

## Rate limits

API requests from a single IP are limited to 10,000 per hour.
