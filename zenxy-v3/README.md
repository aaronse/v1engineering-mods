Sharing notes for a ZenXY **v3** build.  v3 is not released yet — this is a *pre-release* BOM assembled from what Ryan has shared publicly, so treat it as a shopping *plan*, not a shopping *list*.  Will keep updating as info lands.  Latest is always on [github](https://github.com/aaronse/v1engineering-mods/tree/main/zenxy-v3).

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

Links: **[Shop]** = [V1 Engineering shop](https://www.v1e.com/collections/zenxy) (buying here funds the design work).  **[Amazon]** = Ryan's affiliate link, reused from the [official V1E docs](https://docs.v1e.com/) so the credit goes where it should.  Prices are from a catalog snapshot and will drift.

All links in this file are machine-verified — see [Link verification](#link-verification) at the bottom.

## Buy now — in stock today

These are unchanged from v2 or generic enough to be safe.  Everything here is a live V1E product.

|QTY  |Description             |Price |Comment                          |Link                        |
|-----|------------------------|------|---------------------------------|----------------------------|
|🟡 2 |Stepper, Nema 17 84oz/in|$11.50|22mm+ shaft (v2 spec).  ~30" wires |[Shop][sh2] – [Amazon][az2]|
|✅ 2  |Optical Endstop        |$1.90 |"same optical endstops as the previous zen".  JST-JST, 1m lead |[Shop][sh1]|
|🟡 1 |½" × ½" Magnet          |$4.29 |Neodymium N50                    |[Shop][sh3] – [United Nuclear][un1]|
|🟡 1 |½" Steel Ball           |$0.59 |                                 |[Shop][sh4] – [Amazon][az4]|
|🟡 1 |Control board, 2+ drivers|$75.99|[Jackpot3][sh5] (ESP32 / FluidNC, wifi) is the obvious V1E-family pick.  v2 docs recommended Bart Dring's TMC2209 Pen/Laser board |[Shop][sh5] – [Elecrow][el1]|
|🟡 1 |Power Supply 24V 2.5A   |$17.99|Board dependent.  Shop listing explicitly covers the ZenXY |[Shop][sh6] – [Amazon][az6]|
|🟡 ? |Sand                    |      |Baking soda is the "HD version of sand" |[Amazon][az5]|
|*    |Lube                    |$0.65 |Optional, for idlers             |[Shop][sh8] – [Amazon][az8]|
|*    |Wire sleeve             |$0.59 |Optional, sold by the foot       |[Shop][sh9] – [Amazon][az9]|
|*    |Thread locker           |      |Optional, for pulley grub screws.  <mark>V1E no longer stocks this</mark> |[Amazon][az7]|
|*    |EndStop Plug Kit        |$2.99 |Optional, saves crimping         |[Shop][sh10]|

## Wait — v3-specific, not stocked yet

Ryan is [sourcing kit parts now](https://forum.v1e.com/t/zenxy-build/54481/9?u=azab2c).  **None of these exist in the V1E shop as of this writing** — I checked the whole catalog, there is no 6mm belt, 6mm idler, 6mm pulley, 50×50 block or V-slot extrusion SKU.  The "Nearest V1E part" column is the *10mm* v2 equivalent, shown so you can see the part family.  **Do not buy the 10mm ones for a v3 build.**

|QTY  |Description             |Comment                          |Nearest V1E part (WRONG width for v3) |
|-----|------------------------|---------------------------------|----------------------------|
|✅ ?  |Belt GT2 **6mm**       |Length ❓ until a v3 calculator exists.  **No steel-core belt** |[GT2 **10mm** Belt][sh11] $1.95/m|
|✅ 6  |Idlers **Smooth** 20T, 6mm |5mm bore                      |[20T Idler GT2 **10mm**][sh12] $2.30|
|✅ 2  |Idlers **Toothed** 20T, 6mm |5mm bore                     |[Toothed Idler **10mm** 20T][sh13] $1.19|
|🟡 2 |Pulleys 16T, 6mm        |1 per stepper.  Count/tooth inferred from v2 |[Pulley 16T GT2 **10mm**][sh14] $1.80|
|✅ 2  |V-wheel blocks, **50×50** |"the smaller 50x50 vwheel blocks" — reads as the common V-slot gantry plate + wheel sets |[V Wheel][sh15] $1.20 (the POM wheel only, 5mm bore / 15.3mm OD) |
|✅ ?  |**V-wheel extrusion**   |Profile and cut lengths ❓.  **Do not cut anything yet** |— none |
|✅ ~20|M3 × 20mm screws       |Head style ❓ (v2 used Phillips pan head) |— see [ZenXY v2 hardware bundle][sh16] |
|✅ 6  |M5 × 20mm **or** 25mm  |Ryan listed either length        |— see [ZenXY v2 hardware bundle][sh16] |
|❓ ? |T-nuts / drop-in nuts   |Depends on the extrusion profile |— none |
|❓ 1 |Glass / tray            |Sizing rules ❓.  v2 used magnet spacers when mounting hardware protrudes |— none |

Expect a **ZenXY v3 hardware bundle** and **printed parts set** to appear the way [v2's][sh16] did.  Watch the [ZenXY collection](https://www.v1e.com/collections/zenxy).

[sh1]:  https://www.v1e.com/products/optical-endstop
[sh2]:  https://www.v1e.com/products/nema-17-76oz-in-steppers
[sh3]:  https://www.v1e.com/products/1-2-x-1-2-magnet
[sh4]:  https://www.v1e.com/products/1-2d-steel-ball
[sh5]:  https://www.v1e.com/products/jackpot3-cnc-controller
[sh6]:  https://www.v1e.com/products/24v-power-supply
[sh8]:  https://www.v1e.com/products/super-lube-silicone-lubricating-grease-with-syncolon-ptfe
[sh9]:  https://www.v1e.com/products/wire-sleeve
[sh10]: https://www.v1e.com/products/endstop-plug
[sh11]: https://www.v1e.com/products/gt2-10mm-belt
[sh12]: https://www.v1e.com/products/20t-idler-gt2-10mm
[sh13]: https://www.v1e.com/products/idler-10mm-20t-5mm-bore
[sh14]: https://www.v1e.com/products/pulley-16-tooth-gt2-10mm
[sh15]: https://www.v1e.com/products/v-wheel
[sh16]: https://www.v1e.com/products/zenxy-v2-hardware-bundle

[az2]: https://amzn.to/3FcxGlE
[az4]: https://amzn.to/2hPecOB
[az5]: https://amzn.to/2vWrmiO
[az6]: https://amzn.to/3TXtjoM
[az7]: https://amzn.to/3GhaKmx
[az8]: https://amzn.to/31H7yS6
[az9]: https://amzn.to/3EDzb1H

[el1]: https://www.elecrow.com/jackpot3-cnc-controller.html
[un1]: https://unitednuclear.com/index.php?main_page=product_info&cPath=70_71&products_id=982

**As an Amazon Associate Ryan earns from qualifying purchases.**  Every `amzn.to` link above is lifted from the official [ZenXY](https://docs.v1e.com/zenxy/) and [LowRider](https://docs.v1e.com/lowrider/) docs and carries Ryan's `vicicn-20` tag.  Buy from the [V1E shop](https://www.v1e.com/collections/zenxy) when you can — it directly funds designs like this one.

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

# <big>Link verification</big>

A BOM whose links 404 is worse than no BOM, so every external link here is checked with [`tools/check-links.ps1`](../tools/check-links.ps1):

```powershell
./tools/check-links.ps1 zenxy-v3/README.md -LibraryPath E:\git\new-zenxy\models\library\v1e
```

It does three things: live HTTP check, redirect detection (catches renamed/merged shop products), and an **offline grounding check** — any `v1e.com/products/<handle>` link whose handle is missing from the local V1E parts library gets flagged, which catches BOM links to products that quietly stopped existing.

Output is problems-only by default, so it is cheap to paste back into an LLM.  `-All` for the full list.

Findings worth knowing:

- The threadlocker shop link used by the [official LR4 docs](https://docs.v1e.com/lowrider/) (`0-5ml-threadlocker-242`) is **404 and absent from the catalog** — V1E appears to have stopped stocking it.  Amazon link only here.
- Every `amzn.to` link resolves to a live Amazon product page carrying `tag=vicicn-20`, i.e. Ryan's associate tag.
- Liberapay, United Nuclear and Autodesk A360 answer bots with 403, so they report as `BLOCKED` rather than broken.  Liberapay confirmed good by hand.  The other two are carried over unchanged from the [official V1E ZenXY docs](https://docs.v1e.com/zenxy/) and I could not fetch them from here — **unverified**.

## License

[![CC BY-SA 4.0][cc-by-sa-shield]][cc-by-sa]

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa], matching the V1 Engineering docs.

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-shield]: https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg
