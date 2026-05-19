# mpv-auto-video-sync

![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg)
![Lua](https://img.shields.io/badge/Language-Lua-blue.svg)
![MPV](https://img.shields.io/badge/Player-MPV-purple.svg)

A simple MPV configuration and script to efficiently handle video-sync in both widowed and fullscreen without scarifying anything

I made this configuration and script to aid a specific problem I've been experiencing:

* Huge audio and video desync in windowed mode but perfect sync in fullscreen
* Speed up fullscreen video but correct pacing in windowed mode with 'display-fps-override=60'

The cause of this problem is correlated to the known problems regarding playing 23.98/24/29.97 fps media or similar on a high refresh rate display and display-resample.  
Also something happened in recent MPV updates (at least on the Windows build) and probably G-Sync is also doing something.  
So I came up with this to solve these issues cleanly for both windowed and fullscreen modes without giving up display-resample or windowed mode.

## Table of Contents

* [Configuration](#configuration)
* [Script installation](#script-installation)
* [Notes](#notes)
* [Support](#support)
* [License](#license)

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

