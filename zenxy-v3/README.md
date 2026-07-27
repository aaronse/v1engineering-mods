Sharing notes for a ZenXY **v3** build.  v3 is not released yet — this is a *pre-release* BOM assembled from what Ryan has shared publicly, so treat it as a shopping *plan*, not a shopping *list*.  Will keep updating as info lands.  Latest is always on [github](https://github.com/aaronse/v1engineering-mods/blob/main/zenxy-v3).

# <big>ZenXY v3</big> <small>— CoreXY Sand Table</small>

**Do not buy the "maybe" parts yet.**  Ryan is [sourcing parts for an initial round of kits](https://forum.v1e.com/t/zenxy-build/54481/9), and design/BOM is still subject to change.  Buying early is how you end up with a drawer of 10mm idlers you can't use.

Follow along / ask in the [ZenXY Build forum topic](https://forum.v1e.com/t/zenxy-build/54481?u=azab2c).

<mark style=opacity:0.4>&nbsp;**Note:** Until official v3 docs exist, the [ZenXY v2 docs](https://docs.v1e.com/zenxy/) are the best reference.  Most of v2 (belt routing concept, magnet/ball, sand, pattern software, firmware, starting gcode) carries straight over.  The motion hardware is what changed.</mark>

## What we know so far

From [Ryan / @vicious1, post #9](https://forum.v1e.com/t/zenxy-build/54481/9?u=azab2c) (2026-07):

- Design is **"98% done"**, tested for more than short runs.  No beta round planned.
- Goals were: **easier to build, easier to drop into a table, and easier to set the endstops**.
- **20mm smaller footprint** than v2.  Ryan plans **v2→v3 spacers** so existing v2 tables can be reused.
- Hardware called out: *"6mm belts, 6 smooth idlers, 2 toothed, ~20- m3x20 screws, 6- M5x20 or 25mm screws, 2 of the smaller 50x50 vwheel blocks, and vwheel extrusion, same optical endstops as the previous zen."*
- Kits and files expected "soon"; initial production parts already being sourced.

### The big change vs v2

| | ZenXY v2 | ZenXY v3 |
|---|---|---|
| Belt | GT2 **10mm** | GT2 **6mm** |
| Idlers | 8 × 20T | **6 smooth + 2 toothed** (still 8) |
| Rails | 2 × large OD + 2 × small OD round tube | **V-wheel extrusion** |
| Trucks / carriage | Printed trucks + 19 loose Mini V wheels | **2 × off-the-shelf 50×50 V-wheel blocks** |
| Fasteners | 34 × M5x30, 9 × M5 locknut, M3, M2.5 | **~20 × M3x20, 6 × M5x20/25** |
| Endstops | 2 × optical | 2 × optical (unchanged) |
| Footprint | — | 20mm smaller |

Fastener count dropping from ~46 to ~26, and 19 loose V wheels becoming 2 pre-assembled blocks, is most of the "easier to build" story.

### What we *don't* know yet

- Printed parts list and count.
- Extrusion profile/series and **cut lengths** — no v3 calculator yet.  ([v2 calculator](https://docs.v1e.com/zenxy/zen2calculator/) for reference only, the numbers do **not** transfer.)
- Belt length formula, pulley count/tooth count (2 × 16T assumed, one per stepper).
- Whether the 50×50 blocks ship in the kit or are sourced separately.
- Glass / sand tray sizing rules, magnet spacer situation.
- Whether Jackpot/other V1E boards get a recommended config.

## Design files & references

| What | Where |
|---|---|
| Official design files | <mark>Not released yet</mark> — watch [forum topic](https://forum.v1e.com/t/zenxy-build/54481?u=azab2c) and [V1E ZenXY shop collection](https://www.v1e.com/collections/zenxy) |
| ZenXY v2 docs (best current reference) | [docs.v1e.com/zenxy](https://docs.v1e.com/zenxy/) · [v2 assembly](https://docs.v1e.com/zenxy/zen2assm1/) · [v2 calculator](https://docs.v1e.com/zenxy/zen2calculator/) |
| ZenXY v2 source | [GitHub + STEP files](https://github.com/V1EngineeringInc/ZenXY-v2) |
| Unofficial v3 CAD explorer (fan art, *not* a build reference) | [v1e.makergalaxy.com/zenxy/design](https://v1e.makergalaxy.com/zenxy/design) |
| Jamie's belt-routing exploration | [post #12](https://forum.v1e.com/t/zenxy-build/54481/12?u=azab2c), built on [big_arm](https://vector76.github.io/big_arm/twin.html) |
| Pattern software | [Sandify](https://sandify.org/) ([source](https://github.com/jeffeb3/sandify), [tip the author](https://liberapay.com/jeffeb3/)) |
| Vector-art patterns | [Inkscape + EggBot + Estlcam](https://forum.v1e.com/t/artistic-designs-with-inkscape-eggbot-tools-and-estlcam/6302) |

---

# <big>BOM / PARTS</big>

Confidence legend — please don't skip this:

| Mark | Meaning |
|---|---|
| ✅ | Stated by Ryan for v3 |
| 🟡 | Inferred from v2 + v3 statements, high confidence, **unconfirmed** |
| ❓ | Unknown / waiting on release |

Links: **[Shop]** = [V1 Engineering shop](https://www.v1e.com/collections/zenxy) (buying here funds the design work).  **[Amazon]** = Ryan's affiliate link where one already exists for that exact part.  Where the v3 part is new and no V1E link exists yet, the Amazon column is a plain generic search marked with `†` — swap it out once the shop lists the real part.

## Motion — the v3-specific parts

None of the 6mm belt/idler parts or the V-wheel blocks are in the V1E shop **yet**.  Expect them with the kit.

|QTY  |Description             |Comment                          |Link                        |
|-----|------------------------|---------------------------------|----------------------------|
|✅ ?  |Belt GT2 **6mm**       |Length ❓ until a v3 calculator exists.  **No steel-core belt** |<mark>Shop TBD</mark> – [Amazon†][az20]|
|✅ 6  |Idlers **Smooth** 20T   |6mm, 5mm bore                    |<mark>Shop TBD</mark> – [Amazon†][az21]|
|✅ 2  |Idlers **Toothed** 20T  |6mm, 5mm bore                    |<mark>Shop TBD</mark> – [Amazon†][az22]|
|🟡 2 |Pulleys 16T **6mm**     |1 per stepper.  Count/tooth inferred from v2 |<mark>Shop TBD</mark> – [Amazon†][az23]|
|✅ 2  |V-wheel blocks, **50×50** |"the smaller 50x50 vwheel blocks" — the common V-slot gantry plate + wheel sets |<mark>Shop TBD</mark> – [Amazon†][az24]|
|✅ ?  |**V-wheel extrusion**   |Profile and cut lengths ❓.  Do not cut anything yet |<mark>Shop TBD</mark> – [Amazon†][az25]|
|✅ 2  |Optical Endstop         |"same optical endstops as the previous zen" |[Shop][sh1] – <mark>—</mark>|
|🟡 2 |Stepper, Nema 17        |22mm+ shaft (v2 spec).  84 oz/in from the shop |[Shop][sh2] – [Amazon][az2]|

## Zen bits (unchanged from v2)

|QTY  |Description             |Comment                          |Link                        |
|-----|------------------------|---------------------------------|----------------------------|
|🟡 1 |½" × ½" Magnet          |High "N" rating                  |[Shop][sh3] – [United Nuclear][un1]|
|🟡 1 |½" Steel Ball           |                                 |[Shop][sh4] – [Amazon][az4]|
|🟡 ? |Sand                    |Baking soda is the "HD version of sand" |– [Amazon][az5]|
|❓ 1 |Glass / tray            |Sizing rules ❓.  v2 used magnet spacers when mounting hardware protrudes |– |

## Fasteners

|QTY  |Description             |Comment                          |Link                        |
|-----|------------------------|---------------------------------|----------------------------|
|✅ ~20|M3 × 20mm              |Head style ❓ (v2 used Phillips pan head) |– [Amazon†][az26]|
|✅ 6  |M5 × 20mm **or** 25mm  |Ryan listed either length        |– [Amazon†][az27]|
|❓ ? |T-nuts / drop-in nuts   |Depends on the extrusion profile |– |

## Electronics

Same story as v2 — any 2-driver board that can run CoreXY.  TMC silent drivers are strongly recommended; this thing sits in your living room.

|QTY  |Description             |Comment                          |Link                        |
|-----|------------------------|---------------------------------|----------------------------|
|🟡 1 |Control board, 2+ drivers|[Jackpot3](https://www.v1e.com/products/jackpot3-cnc-controller) (ESP32/FluidNC, wifi) is the obvious V1E-family pick.  v2 docs recommended Bart Dring's TMC2209 Pen/Laser controller |[Shop][sh5] – [Elecrow][el1]|
|🟡 1 |Power Supply 24V        |Board dependent                  |[Shop][sh6] – [Amazon][az6]|
|*    |Thread locker           |Optional, for pulley grub screws |[Shop][sh7] – [Amazon][az7]|
|*    |Lube                    |Optional, for idlers             |[Shop][sh8] – [Amazon][az8]|
|*    |Wire sleeve             |Optional, tidy                   |[Shop][sh9] – [Amazon][az9]|

[sh1]: https://www.v1e.com/collections/zenxy/products/optical-endstop
[sh2]: https://www.v1e.com/collections/zenxy/products/nema-17-76oz-in-steppers
[sh3]: https://www.v1e.com/collections/zenxy/products/1-2-x-1-2-magnet
[sh4]: https://www.v1e.com/collections/zenxy/products/1-2d-steel-ball
[sh5]: https://www.v1e.com/products/jackpot3-cnc-controller
[sh6]: https://www.v1e.com/products/24v-power-supply
[sh7]: https://www.v1e.com/collections/3dprinter-parts/products/0-5ml-threadlocker-242
[sh8]: https://www.v1e.com/collections/3dprinter-parts/products/super-lube-silicone-lubricating-grease-with-syncolon-ptfe
[sh9]: https://www.v1e.com/products/wire-sleeve

[az2]: https://amzn.to/3FcxGlE
[az4]: https://amzn.to/2hPecOB
[az5]: https://amzn.to/2vWrmiO
[az6]: https://amzn.to/3TXtjoM
[az7]: https://amzn.to/3GhaKmx
[az8]: https://amzn.to/31H7yS6
[az9]: https://amzn.to/3EDzb1H

[el1]: https://www.elecrow.com/jackpot3-cnc-controller.html
[un1]: https://unitednuclear.com/index.php?main_page=product_info&cPath=70_71&products_id=982

[az20]: https://www.amazon.com/s?k=GT2+6mm+belt+fiberglass
[az21]: https://www.amazon.com/s?k=GT2+20T+smooth+idler+6mm+5mm+bore
[az22]: https://www.amazon.com/s?k=GT2+20T+toothed+idler+6mm+5mm+bore
[az23]: https://www.amazon.com/s?k=GT2+16T+pulley+6mm+belt+5mm+bore
[az24]: https://www.amazon.com/s?k=v-slot+gantry+plate+50x50+v+wheel
[az25]: https://www.amazon.com/s?k=v-slot+aluminum+extrusion
[az26]: https://www.amazon.com/s?k=M3+x+20mm+screw+assortment
[az27]: https://www.amazon.com/s?k=M5+x+20mm+screw+assortment

**As an Amazon Associate Ryan earns from qualifying purchases.**  Buy from the [V1E shop](https://www.v1e.com/collections/zenxy) when you can — it directly funds designs like this one.

`†` = generic Amazon **search**, not a V1E affiliate link and not a vetted part.  These are placeholders so you can see what the part looks like.  Replace with the shop link once v3 parts are listed.

## Printed Parts

<mark>TODO:</mark> ❓ Not released.  Expect a "ZenXY v3 Printed Parts Set" in the shop alongside the hardware kit, as with [v2](https://www.v1e.com/products/zenxy-v2-printed-parts-set).

Printing guidance from v2 that will almost certainly still apply:

- PLA or PETG.  Any semi-rigid material works, but PLA/PETG win on accuracy, durability and ease.
- 25% infill, no supports needed.

## Upgrading from a v2 table

- v3 has a **20mm smaller footprint**, and Ryan is making **v2→v3 spacers** so an existing v2 table/glass can be reused.
- Your v2 10mm belt, 10mm idlers/pulleys, round rails and Mini V wheels do **not** carry over.  The magnet, steel ball, steppers, optical endstops, sand and power supply do.

---

# <big>SIZING</big>

<mark>TODO:</mark> ❓ No v3 calculator yet.  Sizing depends on the extrusion profile and the 50×50 block dimensions, neither of which are published.

For reference on how v2 handled it, see the [v2 calculator](https://docs.v1e.com/zenxy/zen2calculator/) — it took your table size and returned rail lengths and belt length.  **Do not use v2 numbers for a v3 build.**

# <big>Firmware</big>

CoreXY belting, **homes Y before X** (v2 behaviour, expected to carry over).  The exact build size has to be set before compiling.

- Marlin example (v2): [Allted/Marlin](https://github.com/Allted/Marlin/tree/CHOOSE_VERSION)
- FluidNC / ESP32 (Jackpot family): [V1E FluidNC notes in this repo](../fluidnc/README.MD)
- Grbl_Esp32 (v2 TMC2209 Pen/Laser board): [pre-configured repo](https://github.com/V1EngineeringInc/Grbl_Esp32)

## Starting Gcode

v2 used hard-mounted endstops plus endstop triggers, so homing needs offsets baked into your start gcode.  v3 changed the endstop setup ("easier to set the endstops"), so **expect the offsets to change** — but the shape of it will look like this ([v2 GRBL version](https://docs.v1e.com/zenxy/#example-starting-gcode)):

```gcode
$HY
G92 X0 Y0
G0 Y-18.5      ; offset past the flag — v3 value TBD
G92 X0 Y0
$HX
G0 X-28        ; offset past the flag — v3 value TBD
G92 X0 Y0
G1 X2 F2000    ; safe-speed nudge in case your pattern gcode has no feedrate
```

# <big>Wiring</big>

v2 rule of thumb, expected to still apply: the stepper on the same block as the endstops plugs into the **X** port.  If motion is wrong, power down and flip both plugs, or just one.  CoreXY troubleshooting is guess-and-check; it is more confusing than Cartesian.

# <big>Assembly</big>

<mark>TODO:</mark> ❓ Not released.  [v2 assembly doc](https://docs.v1e.com/zenxy/zen2assm1/) is the closest thing available, and the belt-routing / tensioning sections should still be conceptually relevant.

v2 tips worth carrying forward:

- Set truck/carriage tension **before** the belts go on — it is very hard to judge afterwards.
- Tension does not need to be high.  All wheels making light contact is the quietest.  Too loose or too tight adds noise but does not hurt image quality.
- Align pulleys with the indents on the printed parts, and tighten **both** grub screws — flat one first.

# <big>Table</big>

See the [v2 example table](https://docs.v1e.com/zenxy/#example-table) and its [Fusion 360 file](https://a360.co/3wNh68T) for proportions and glass mounting ideas.  Also [srcnet's point](https://forum.v1e.com/t/zenxy-build/54481/3?u=azab2c) — this one is flat enough to hang on a wall if you swap sand for a pen, and [MakerJim's](https://forum.v1e.com/t/zenxy-build/54481/4?u=azab2c) — flip it over and mount a laser.

# <big>Build Log / Status</big>

```javascript
// WAITING ON RYAN
    Design files
    Printed parts list
    Extrusion profile + cut lengths
    Belt length formula
    Kit availability

// DECIDED
    Control board : Jackpot3 (ESP32 / FluidNC)

// TODO
    Table design + glass sourcing
    Sand vs baking soda
    Confirm 50x50 block part number once Ryan names it
```

# <big>Community</big>

- [ZenXY Build](https://forum.v1e.com/t/zenxy-build/54481?u=azab2c) — the main v3 topic
- [ZenXY v2 builds](https://forum.v1e.com/tag/zenxy) — plenty of table/glass/sand lessons that still apply

---

## License

[![CC BY-SA 4.0][cc-by-sa-shield]][cc-by-sa]

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa], matching the V1 Engineering docs.

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-shield]: https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg
