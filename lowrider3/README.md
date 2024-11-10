## [V1E LowRider 3 Mods, Notes and Resources](/lowrider3/README.md)

- [LR3 Custom Front Grill (strut)](/lowrider3/front-grill-strut/README.md)<br/>
- [LR3 Custom Mid Belt Y Tensioner Blocks](/lowrider3/y-tension-blocks/README.md)<br/>
- [LR3 Vac Hose parts](/lowrider3/vac-hose/README.md)<br/>
- [LR3 Vac Hose Hanger parts](/lowrider3/vac-hose-hanger/README.md)
- [LR3 Makita tool mount for 2-1/2" Vac hose and reusable zipties](/lowrider3/makita-tool-mount/README.md)<br/>
- [LR3 IDEX build (Dual Router)](/lowrider3/idex/README.md)
- [LR3 Adapter for Pen, Drag knife or (RDZ) diamond engraver](/lowrider3/drag-bit-pen-mount/README.md)
- [LR3 BowFlex dumbell weight adapters](/lowrider3/bowflex-mount/README.md)
- [LR3 Almost pointless pointy dust flaps](/lowrider3/dust-flaps/README.md)
- [LR3 **ALL** the Struts generator - Was used to enable fast downloading of pre generated LR3 Struts from LR3 Calculator](/lowrider3/strut-plate-variable/README.md)<br/>


## Milling Settings
@Noobs like me, MUST read [V1E Docs/Milling Basics](https://docs.v1engineering.com/tools/milling-basics/), [V1E Docs/Milling Metal](https://docs.v1engineering.com/tools/milling-metal/)
- Baseline Settings
  - Starter settings...  For materials softer than Metal https://docs.v1engineering.com/tools/milling-basics/#for-the-impatient
    - { bit: 1/8", feed: 8mm/s, plunge: 3mm/s, doc: 1mm, step-over: 45%, finish: bit-dia/10 } 
  - Metal settings https://docs.v1engineering.com/tools/milling-metal/#baseline-settings


### Actual Observed Settings
Machine capability depends on the design, build materials, assembly quality, and maintenance.  With that in mind, here's what people have been able to achieve.  They show  what's possible, and what to strive for :

**Use Landscape orientation if reading with CellPhone or small screen.  Table below has 10+ columns**

|Quality|Material|Bit|DOC|Plunge Angle|Feed XY|Feed Z|RPM/Speed|Coolant|Notes / Source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
||Polycarbonate|1/8" 2 flute|1.5mm|45 deg|183mm/s|13m/s|Speed 6|Cold weather|@jjwharris, more details in [Forum Post](https://forum.v1e.com/t/cutting-polycarbonate/6869/14)<br/>- https://www.youtube.com/watch?v=Eilyq0q-F1o<br/>- Acc { print: 100, retract: 3000, travel: 1000}<br/>- Drivers { current : 1000mA }|
||
||Generic Pine|[1/2" dovetail](https://www.ecotools.be/hm-zwaluwstaartfrees-12-7-mm)|5mm|Plunge Angle?|11.7mm/s|3mm/s|Katsu 4|| @Olivier <br/>- Conventional + Climb milling<br/>- https://forum.v1e.com/t/how-to-work-out-milling-settings/39117/13?u=azab2c|
||
||Alu|[V1E 1/8" Carbide single flute](https://www.v1e.com/products/carbide-single-flute)|7mm|90deg|20mm/s|4mm/s|12K-15K|25psi air + hint of IPA|Trochoidal Milling: Stepover 10% Width: 50% Oscillation: 0<br/>https://youtu.be/wTbvzWy-f1o |
||
||Alu|6mm 2 flute|10mm|Angle???|15mm/s|4mm/s|Speed???|Coolant???|@ Tokoloshe, <br/>- Video https://www.youtube.com/watch?v=d00vYzRvVSI<br/>- Step over 20% https://forum.v1e.com/t/my-first-aluminum-part/41673/5?u=azab2c |
||
||Acrylic|3mm 1 flute upcut|6mm|60deg|20mm/s, finish: 10mm/s|2mm/s|Makita/Katsu 1 = lowest|None|@Olivier [Acylic on LR2](https://forum.v1e.com/t/acrylic-on-lr2/33034/29?u=azab2c)<br/>- step-over: 30%, trochoidal-stepover : 20%, trochoidal-width: 50%, oscillation: 0.05mm
||
||Polycarbonate|1/8" 2 flute straight cut|3mm|45deg|50mm/s|13mm/s|???||@jjwharris<br/>- Video @ https://www.youtube.com/watch?v=U8_uKYhMN8c<br/>- https://forum.v1e.com/t/cutting-polycarbonate/6869/7?u=azab2c
||
|Great|Cast Acyrlic|Carbide 1 flute upcut 3mm<br/><mark>Wirbel 1 Schneider?</mark>|5.5mm|60deg|Troch 25mm/s|Troch 7.5mm/s|10K (Makita Lowest setting)|NA|@ Tokoloshe step-over:75%,trochoidal-stepover:20%,trochoidal-width:50%, oscillation:0mm , <br/>- Video @ https://forum.v1e.com/t/control-box-for-the-open-cnc-shield-2/36611?u=azab2c <br/>- https://forum.v1e.com/t/der-froschkonig-lowrider-3-in-oldenburg-germany/35897/91?u=azab2c <br/>- https://forum.v1e.com/t/first-acrylic-cut-advice-please/27712/26?u=azab2c
||
|?|Alu|Carbide 1 flute upcut 6mm|10mm|60deg|Troch 25mm/s|Troch 7.5mm/s|10K (Makita Lowest setting)|NA|@ Tokoloshe step-over:<mark>???%</mark>,trochoidal-stepover:<mark>???%</mark>,trochoidal-width:50%, oscillation:0mm, <br/>- https://forum.v1e.com/t/der-froschkonig-lowrider-3-in-oldenburg-germany/35897/91?u=azab2c
||
|?|Cast Acrylic|Carbide 2 flute upcut 1/8"|2mm|90deg|Troch 8mm/s|Troch 1.6mm/s|7K|NA|@ barry99705 step-over:30%, trochoidal-step:20%, trochoidal-width:50%,oscillation: 0.05mm ?<br/>- https://www.youtube.com/watch?v=KtqhBiFaDpQ&t=396s <br/>- https://forum.v1e.com/t/acrylic-troubleshooting/5283/21?u=azab2c 
||
|?|Cast Acrylic|Carbide single flute 1/8"?|0.5mm|90deg|18mm/s|?|8.5K|?|https://forum.v1e.com/t/bits-for-cutting-abs-pc-plastic-at-1-8-inch-thickness/21278/5?u=azab2c
||
|Great|Cast Acrylic|Carbide single flute 2mm|0.4mm|90deg|10mm/s|3mm/s|5k|NA|https://forum.v1e.com/t/first-acrylic-cut-advice-please/27712/9?u=azab2c
||
|Meh|Alu|Carbide 1/8"|0.25mm|90deg|3mm/ms||10K|WD-40| https://forum.v1e.com/t/aluminum-plates-for-lr3-speeds-and-feeds/33094/6 |
||
||MDF|1/8"|?|90deg|50mm/s||||https://forum.v1e.com/t/lowrider-maximum-speeds-and-feeds-depends-cut-deep-with-slow-feeds-to-max-cut-volume/29228/3
||
||MDF/Particle|1/8"|13mm|90deg|14mm/s|4mm/s|20k|NA|Topic includes Ryan's profiles https://forum.v1e.com/t/doing-some-more-speed-testing/34972/4?u=azab2c
||
||MDF|1/8"|12.5mm|90deg|22mm/s||7k|NA|https://forum.v1e.com/t/lr3-speed/34613/4?u=azab2c
||
||Soft Wood|1/4"|10mm|15mm/s|10mm|||NA|https://forum.v1e.com/t/lowrider-maximum-speeds-and-feeds-depends-cut-deep-with-slow-feeds-to-max-cut-volume/29228/12

### Acrylic

- [Polish edges with 400 thru to 2000+ grit]([Protect front and back faces during flame polish](https://forum.v1e.com/t/acrylic-on-lr2/33034/32?u=azab2c)
- [How to Polish and Shape Plastic Edges](https://www.youtube.com/watch?v=QhAXbA2lmnE)
  - Mapp gas
- [Protect front and back faces during flame polish](https://forum.v1e.com/t/acrylic-on-lr2/33034/32?u=azab2c)

### Drawing
- Consider [Pentel EnerGel RTX Retractable Liquid Gel Pen, (0.3mm) Needle Tip, Extra Fine Line, Blue Ink, 3-Pk (BLN73BP3C)](https://www.amazon.com/gp/product/B01NAVDLI5)
  - Used by misc [forum members](https://forum.v1e.com/t/another-florida-build-lr3-2/38080/185?u=azab2c).

### Resources
- [CNC Production Routing Guide](https://forum.v1e.com/t/acrylic-troubleshooting/5283/4?u=azab2c)


## Software
