Some notes related to the Pi+TFT35 Case I end up using/modding/creating...

# Goals
- Must be pretty, pro look and feel
- Must not see any wiring.
- Must Pivot for convenient viewing angle, and access to enclosure parts
- Must Mount to 2020
- Must Be compact, but not melt.
- Should have gratuitious LED lighting.  Need to one up MK4.
- Nice to end up with design that can be reused for other projects.

# Parts

- [GeeekPi Pi 4 TFT 3.5" Resistive Touch Screen, with Case, Fan and Heatsinks. 320x480 resolution](https://www.amazon.com/gp/product/B083C12N57)
- [HOTNOW Short USB C Cable Right Angle 1ft, 3 pack](https://www.amazon.com/gp/product/B092KF36T6)


# Printing
- Used PETG for better temp resilience and more flex/spring to help parts fit without cracking.
- Infill: Cura's Tri-Hexagon infill at 25% goes well with the Hexagon vent holes.


# Tasks
## TODO:
- Lid, add positive stop to lid so will stop bottom's left plate.
## DONE:
- Case Mount, design support arms, connecting 2020 to case.
- Lid, extend overhang, avoid left panel being proud
- Add Boss/standoffs for Pi
- Case Mount, clip recesses
- Cutout for wiring exit
- Holes sized/spaced for 2020
- Leave knockouts for 2020 holes
- Reduce pi nub dia size
- Increase hinge clearance
- Remove thin tab for wiring
- Increase knockout thickness for holes
- LCD support left front corner


# Hexagon Vent/Grill Info
Some Fusion 360 specific details describing the hexagon vent dimensions.

Radius = Edge = 3.6mm, Hex Spacing=1.8

Repeat Pattern for Horizontally aligned Hexagons:
```
    Quantity/Distance:
    5
    ( 4 * ( ( 2 * 7.2 ) - 0.4825 ) ) * 1 mm

    Quantity/Distance:
    3
    ( 2 * ( ( 3.118 * 2 ) + 1.8 ) ) * 1 mm
```

Repeat Pattern for Vertically aligned Hexagons:
```
    Quantity/Distance:
    2
    ( 1 * ( ( 2 * 7.2 ) - 0.4825 ) ) * 1 mm

    Quantity/Distance:
    8
    -( 7 * ( ( 3.118 * 2 ) + 1.8 ) ) * 1 mm
```    

# Related Work:

https://www.printables.com/model/13559-official-lcd-7-raspberry-pi-case/files

![](https://media.printables.com/media/prints/13559/images/121712_9f5b8a5f-cef2-41cc-9dfb-3fcf251d7161/thumbs/inside/1280x960/jpg/img_20180904_165834_13559.webp)

