# battery-guard

`battery-guard` checks a laptop's system battery once a minute on Ubuntu GNOME. When the battery is discharging at 10% or below, it opens a terminal window with a 30-second warning. Press any key in that window or close it to cancel. If the countdown expires, it checks the battery again before suspending the computer.

The warning appears only once per low-battery episode, even if you cancel it or wake the computer from suspend. Monitoring resets after the battery rises above 10%. If the battery cannot be read, or the graphical session or terminal is unavailable, the tool does not suspend the computer.

## Requirements

- Ubuntu GNOME, Bash, `systemd --user`, and `gnome-terminal`
- A system battery exposed at `/sys/class/power_supply/BAT*`
- Permission to run `systemctl suspend` from your user session

## Install

Run this from the cloned repository. `sudo` is not required.

```bash
./install.sh
```

The installer copies files into `~/.local/bin/battery-guard`, `~/.local/libexec/battery-guard/`, and `~/.config/systemd/user/`, then enables the monitoring timer. If `~/.local/bin` is not in your `PATH`, open a new terminal or run `~/.local/bin/battery-guard` directly.

## Use

```bash
battery-guard start
battery-guard stop
battery-guard status
```

`stop` disables the timer and stops an active check. If a warning window is already open, close it or press any key to dismiss it.

To remove the tool, run `./uninstall.sh` from the repository.

## Important limitation

This tool uses **suspend**, not hibernation. Open work stays in memory, so a full battery discharge during suspend can cause unsaved work to be lost. The 10% threshold does not guarantee protection from a full discharge; power use during suspend varies by laptop.

The installer does not run a low-battery or suspend test.
