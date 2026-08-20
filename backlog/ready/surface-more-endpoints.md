<!-- Status: ready | Tier: 2 | Created: 2026-08-20 | Picked: - | Branch: - | Verify: monkeyc compile -->

# Surface the endpoints that are configured but unreachable

## Why

`Config.ENDPOINT_URLS` in the gitignored `source/config.mc` defines **12 endpoints** — sleep
start/stop, living room, home off, two lamps on/off, wall on/off, wallflower on/off — but the menu
in `App.mc` only offers **2** of them (`:sleepStart`, `:sleepStop`). Ten configured actions cannot be
reached from the watch.

## What's already known

`MenuDelegate` is already generic over the map, so no delegate change is needed: adding a `MenuItem`
in `App.mc` with the matching symbol is the whole code change.

Tier 2 because the open question is UX, not code: **a flat 12-item list on a watch face is bad.**
Options are a submenu per room, a shorter curated set, or dropping the unused entries from config.
Worth deciding before adding items one at a time.

Note the app also exits after 15 seconds of inactivity (`INACTIVITY_TIMEOUT_MS` in `App.mc`), which
argues for a shallow menu rather than deep nesting.

## Notes
