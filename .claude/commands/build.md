Build the Garmin Connect IQ app for fr970, then restart the simulator fresh and load the app.

```bash
SDK="$HOME/Library/Application Support/Garmin/ConnectIQ/Sdks/connectiq-sdk-mac-9.1.0-2026-03-09-6a872a80b"
"$SDK/bin/monkeyc" -d fr970 -f monkey.jungle -o ControlHome.prg -y developer_key
```

Run the build command above from the project root. If it fails, print the error and stop.

If the build succeeds, restart the simulator and load the app:

```bash
pkill -f "connectiq" || true
sleep 2
open "$SDK/bin/connectiq"
sleep 4
"$SDK/bin/monkeydo" ControlHome.prg fr970
```

Report whether the build and launch succeeded, or print any error output.
