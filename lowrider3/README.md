# <big>V1E LowRider3 Mods, Notes and Resources</big>

<mark style="opacity:0.4">
TODO: Create index of Mods within this Repo.  Until then browse the sub folders.</mark>
<br/><br/><br/>

# Milling Settings
@Noobs like me, MUST read [V1E Docs/Milling Basics](https://docs.v1engineering.com/tools/milling-basics/), [V1E Docs/Milling Metal](https://docs.v1engineering.com/tools/milling-metal/)
- Baseline Settings
  - Starter settings...  For materials softer than Metal https://docs.v1engineering.com/tools/milling-basics/#for-the-impatient
    - { bit: 1/8", feed: 8mm/s, plunge: 3mm/s, doc: 1mm, step-over: 45%, finish: bit-dia/10 } 
  - Metal settings https://docs.v1engineering.com/tools/milling-metal/#baseline-settings


## Actual Observed Settings
Machine capability depends on the design, build materials, assembly quality, and maintenance.  With that in mind, here's what people have been able to achieve.  They show  what's possible, and what to strive for :

|Quality|Material|Bit|DOC|Plunge Angle|Feed XY|Feed Z|Speed|Coolant|Notes / Source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
||Acrylic|3mm 1 flute upcut|6mm|60deg|20mm/s, finish: 10mm/s|2mm/s|???|???|@Olivier [Acylic on LR2](https://forum.v1e.com/t/acrylic-on-lr2/33034/29?u=azab2c)<br/>- step-over: 30%, trochoidal-stepover : 20%, trochoidal-width: 50%, oscillation: 0.05mm
||
||Polycarbonate|1/8" 2 flute straight cut|3mm|45deg|50mm/s|13mm/s|???||@jjwharris<br/>- Video @ https://www.youtube.com/watch?v=U8_uKYhMN8c<br/>- https://forum.v1e.com/t/cutting-polycarbonate/6869/7?u=azab2c
||
|Great|Cast Acyrlic|Carbide 1 flute upcut 3mm<br/><mark>Wirbel 1 Schneider?</mark>|5.5mm|60deg|Troch 25mm/s|Troch 7.5mm/s|10K (Makita Lowest setting)|NA|@Tokoloshe step-over:75%,trochoidal-stepover:20%,trochoidal-width:50%, oscillation:0mm , <br/>- Video @ https://forum.v1e.com/t/control-box-for-the-open-cnc-shield-2/36611?u=azab2c <br/>- https://forum.v1e.com/t/der-froschkonig-lowrider-3-in-oldenburg-germany/35897/91?u=azab2c <br/>- https://forum.v1e.com/t/first-acrylic-cut-advice-please/27712/26?u=azab2c
||
|?|Alu|Carbide 1 flute upcut 6mm|10mm|60deg|Troch 25mm/s|Troch 7.5mm/s|10K (Makita Lowest setting)|NA|@Tokoloshe step-over:<mark>???%</mark>,trochoidal-stepover:<mark>???%</mark>,trochoidal-width:50%, oscillation:0mm, <br/>- https://forum.v1e.com/t/der-froschkonig-lowrider-3-in-oldenburg-germany/35897/91?u=azab2c
||
|?|Cast Acrylic|Carbide 2 flute upcut 1/8"|2mm|90deg|Troch 8mm/s|Troch 1.6mm/s|7K|NA|@barry99705 step-over:30%, trochoidal-step:20%, trochoidal-width:50%,oscillation: 0.05mm ?<br/>- https://www.youtube.com/watch?v=KtqhBiFaDpQ&t=396s <br/>- https://forum.v1e.com/t/acrylic-troubleshooting/5283/21?u=azab2c 
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

## Acrylic

- [Polish edges with 400 thru to 2000+ grit]([Protect front and back faces during flame polish](https://forum.v1e.com/t/acrylic-on-lr2/33034/32?u=azab2c)
- [How to Polish and Shape Plastic Edges](https://www.youtube.com/watch?v=QhAXbA2lmnE)
  - Mapp gas
- [Protect front and back faces during flame polish](https://forum.v1e.com/t/acrylic-on-lr2/33034/32?u=azab2c)

### Resources
- [CNC Production Routing Guide](https://forum.v1e.com/t/acrylic-troubleshooting/5283/4?u=azab2c)


# Software
