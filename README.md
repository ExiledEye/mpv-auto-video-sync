# mpv-auto-video-sync

![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat&logo=lua&logoColor=white)
![MPV](https://img.shields.io/badge/MPV-703e79?style=flat&logo=data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPCEtLSBMaWNlbnNlOiBBcGFjaGUuIE1hZGUgYnkgbGF3bmNoYWlybGF1bmNoZXI6IGh0dHBzOi8vZ2l0aHViLmNvbS9sYXduY2hhaXJsYXVuY2hlci9sYXduaWNvbnMgLS0+Cjxzdmcgd2lkdGg9IjgwMHB4IiBoZWlnaHQ9IjgwMHB4IiB2aWV3Qm94PSIwIDAgMTkyIDE5MiIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWw6c3BhY2U9InByZXNlcnZlIiBpZD0iTGF5ZXJfMSIgeD0iMCIgeT0iMCIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgMTkyIDE5MiIgdmVyc2lvbj0iMS4xIj48c3R5bGU+LnN0MCwuc3Qxe2ZpbGw6bm9uZTtzdHJva2U6IzAwMDAwMDtzdHJva2Utd2lkdGg6MTI7c3Ryb2tlLW1pdGVybGltaXQ6MTB9LnN0MXtzdHJva2Utd2lkdGg6Nn08L3N0eWxlPjxjaXJjbGUgY3g9Ijk2IiBjeT0iOTYiIHI9Ijc0IiBjbGFzcz0ic3QwIi8+PHBhdGggZD0iTTExMi44IDk0LjEgODUuNSA3OC40Yy0xLjQtLjktMy40LjItMy40IDEuOXYzMS41YzAgMS42IDEuOSAyLjggMy40IDEuOUwxMTIuNyA5OGMxLjUtMSAxLjUtMy4xLjEtMy45eiIgY2xhc3M9InN0MCIvPjxjaXJjbGUgY3g9Ijk2IiBjeT0iOTYiIHI9IjM5IiBjbGFzcz0ic3QxIi8+PGNpcmNsZSBjeD0iOTgiIGN5PSI5Mi40IiByPSI1Mi41IiBjbGFzcz0ic3QxIi8+PC9zdmc+)

A simple MPV configuration and script to efficiently handle video-sync in both widowed and fullscreen without scarifying anything

I made this configuration and script to aid a specific problem I've been experiencing:

* Huge audio and video desync in windowed mode but perfect sync in fullscreen
* Speed up fullscreen video but correct pacing in windowed mode with 'display-fps-override=60'

The cause of this problem is correlated to the known problems regarding playing 23.98/24/29.97 fps media or similar on a high refresh rate display and display-resample.  
Also something happened in recent MPV updates (at least on the Windows build) and probably G-Sync is also doing something.  
So I came up with this to solve these issues cleanly for both windowed and fullscreen modes without giving up display-resample or windowed mode.

## Configuration

Add this in your mpv.conf:

```conf
correct-pts=yes
interpolation=yes
interpolation-preserve=yes
display-fps-override=0 # 0 -> automatically set to your display's refresh rate
```

Optionally I also recommend testing on your end:

```conf
framedrop=no
```

Also I recommend to disable vrr and freesync/gsync for MPV and set "Prefered refresh rate" to "Application-controlled" in your video card control panel (for example Nvcp or Adrenaline).

---

Now based on your display's refresh rate:

Greater than 60Hz but not 120Hz:

```conf
video-sync-max-video-change=1.5
```

120Hz or 144Hz:

```conf
video-sync-max-video-change=2
```

Greater than 144Hz but not 240Hz:

```conf
video-sync-max-video-change=3.5
```

240Hz:

```conf
video-sync-max-video-change=5
```

**Note**: For refresh rates greater than 240Hz, 5 is probably still a good value but you have to test it out.

---

And finally add the two profiles:

```conf
# Windowed mode
[windowed-sync-audio]
video-sync=audio
tscale=oversample

# Fullscreen mode
[fullscreen-sync-display]
video-sync=display-resample
tscale=sphinx
```

Of course you can add other configs you want to the profile and maybe also change the tscale, the main thing here is the video-sync option.  
The script will simply switch between them according to MPV screen mode.

## Script installation

Simply download and put `auto-video-sync.lua` in your `scripts` directory.

## Notes

* If you have a 60Hz display you probably don't need this.
* I am not sure why this problem is a thing, but if you experience this too and don't wanna sacrifice display-resample or windowed mode, I hope this will help.
* `video-sync=audio` in theory falls back to `video-sync=desync` if there is no audio track.

## Support

If you encounter any problems or have suggestions, please [open an issue](https://github.com/ExiledEye/mpv-auto-video-sync/issues).

## License

Copyright (c) 2025 Exiled Eye  
This project is licensed under the MIT License.  
Refer to the [LICENSE](LICENSE) file for details.

