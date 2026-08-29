# CLAUDE.md — ControlHome

## What this is

A Garmin Connect IQ watch app for the **Forerunner 970** (`fr970`), written in Monkey C. It presents
a "Sleep Control" menu and fires HTTP GET requests to Virtual Smart Home routine-trigger URLs when
items are selected, so the watch can drive home automation without the phone.

## Layout

Two source files carry the whole app:

- **[source/App.mc](source/App.mc)** — entry point. `getInitialView()` builds the "Sleep Control"
  `Menu2` with `:sleepStart` and `:sleepStop`, and starts a 15-second inactivity timer
  (`INACTIVITY_TIMEOUT_MS`) that exits the app so it does not sit open on the wrist.
- **[source/MenuDelegate.mc](source/MenuDelegate.mc)** — `onSelect()` looks up the item's symbol in
  `Config.ENDPOINT_URLS` and calls `Communications.makeWebRequest()`. `onResponse()` shows a toast
  with the HTTP status code.
- **`source/config.mc`** — `Config.ENDPOINT_URLS`, the `Symbol → URL` map. **Gitignored**, because
  those URLs carry live trigger tokens. It defines 12 endpoints; only 2 are currently on the menu.

String resources live in [resources/strings/strings.xml](resources/strings/strings.xml). `gen/` is
auto-generated. Work items live in Linear (project `ControlHome`); use `/backlog`.

## Commands

SDK path: `~/Library/Application Support/Garmin/ConnectIQ/Sdks/connectiq-sdk-mac-9.1.0-2026-03-09-6a872a80b`

```bash
SDK="$HOME/Library/Application Support/Garmin/ConnectIQ/Sdks/connectiq-sdk-mac-9.1.0-2026-03-09-6a872a80b"
"$SDK/bin/monkeyc" -d fr970 -m manifest.xml -j monkey.jungle -o ControlHome.prg -k developer_key
```

Run in the simulator, after building:

```bash
"$SDK/bin/connectiq" &        # start simulator
"$SDK/bin/monkeydo" ControlHome.prg fr970
```

Debug via VSCode with the MonkeyC extension and [.vscode/launch.json](.vscode/launch.json), which
targets `fr970` automatically.

## Verify

A clean `monkeyc` compile is the gate — there is no test suite.

```bash
SDK="$HOME/Library/Application Support/Garmin/ConnectIQ/Sdks/connectiq-sdk-mac-9.1.0-2026-03-09-6a872a80b" \
  && "$SDK/bin/monkeyc" -d fr970 -m manifest.xml -j monkey.jungle -o ControlHome.prg -k developer_key
```

## Architecture

To add or rename actions: add the `MenuItem` in `App.mc` with a symbol, then add that symbol to
`Config.ENDPOINT_URLS` in `config.mc`. `MenuDelegate` needs no change — it is generic over the map.

- **Device target** is hardcoded to `fr970` in `manifest.xml` and `monkey.jungle`. Changing devices
  requires updating both and regenerating `gen/`.
- **Permissions**: the `Communications` permission is declared in `manifest.xml` and is required for
  any HTTP call.

## External services

**Virtual Smart Home** routine triggers (`virtualsmarthome.xyz/url_routine_trigger/`). Each URL
carries a `trigger` and `token` pair that is effectively a credential — anyone holding the URL can
fire that routine. They live in `source/config.mc`, which is gitignored for exactly that reason.

## Standards

Monkey C is Garmin's proprietary language — similar to Java/JavaScript, running on a constrained VM.

- `WatchUi.showToast()` only exists on devices that support it; the `fr970` does.
- `Communications.makeWebRequest()` is always asynchronous — the response arrives in the callback.

## Never

- **Never commit `source/config.mc` or paste its URLs anywhere.** Each one embeds a live trigger
  token; the URL *is* the credential.
- **Never edit `Rez.*` or anything else in `gen/`** — it is auto-generated and regenerated on every build.
- **Never delete `developer_key`.** It is the signing certificate; losing it means the app can no
  longer be updated under the same ID.
