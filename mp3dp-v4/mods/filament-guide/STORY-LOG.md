# Story log — MP3DP v4 PTFE filament guide

Significant events, findings and **reversals**, newest first. Raw material for
downstream content (YouTube [@azab2c](https://www.youtube.com/@azab2c),
[V1E forum topic](https://forum.v1e.com/t/ptfe-guide-ideas-for-enclosed-mp3dp-or-other-corexys-even/38680))
and the working memory for any human or agent extending this project.

<!-- machine-readable header for content tooling; keep keys, edit values -->
```yaml
project: filament-guide
repo: aaronse/v1engineering-mods/mp3dp-v4/mods/filament-guide
status: active
content_status: logging
channels: [youtube, forum]
license: <TODO>
spec: none
```

---

## 2026-10-06

### v5 — An unsupported 90° bend kinked and cut the PTFE tube, causing TPU feed failures

Recent TPU prints failed, and the failures looked feed-related. On inspection,
the v4 mount's PTFE tube was kinked and cut at the overhead smooth 90° bend,
where the bend was not supported well enough. The cause is inferred from the
damaged tube and was not measured. n=1 printer; the TPU failures were not
re-tested on v4 with a fresh tube.

v5 splits the v4 mount into two parts:

| Part | Role |
|---|---|
| `aza-ptfe-guide-mount-can-ptfe-v5` | PTFE guide, with better support for the overhead 90° bend |
| `aza-ptfe-guide-mount-sensor-v5` | BTT runout sensor mount, now separate |

**Why it matters:** the sensor mount can now be swapped or changed without
reprinting the guide, and the bend that damaged the tube is supported.

**For makers:** check the PTFE tube at the top bend for kinks or cuts if
flexible filament starts failing to feed. Replace the tube when moving to v5.
**Shot:** photo of the kinked/cut v4 tube — TODO, not yet in `img/`.

`#incident`
