# SlotRacing

An experimental module for modelling slotcar-racing tracks.  Will initially support just Scalextric Sport track.

This module is not connected in any way with the Scalextric brand, its owners Hornby Hobbies, or any other "official" entity.  

## Geometry

Standard two-lane track width is 156mm.

### Curves

Curves are radius 1 thru 4, at 214, 370, 526, 682mm radii respectively. The measurement is to the outside of the track piece.

Slots are speced at the 1/4 and 3/4 width points, i.e. 39mm from each edge, with a 78mm central span (except where reduces for chicanes/crossovers/etc of course).

Single-lane pieces are half of the width of a two-lane piece, at 78mm with a central slot.  Therefore, two single-lane pieces match exactly up to a dual-lane piece.

Modelling of border pieces etc will come later.

The angles available in single pieces depend on the radius, e.g. there are pieces up to 90˚ for R1, 45˚ for R2, but no pieces larger than 22.5˚ for R3/R4.

#### Radius 1

Radius of outer edge of track is 214mm.

Angles available are:
* 22.5˚ - C8278
* 45˚ - C8202
* 90˚ - C8201

#### Radius 2

Radius of outer edge of track is 370mm, so these can fit flush between R1 and R3 curves for multi-lane layouts.

Angles available are:
* 22.5˚ - C8234
* 45˚ - C8206
* 45˚ banked - C8296
* 90˚ "diamond" crossover - C8203. Only to be used in pairs in older ARC Pro sets that powered the two lanes separately. More recent power units apply the same power to both lanes, so a single curve crossover is ok.

#### Radius 3

Radius of outer edge of track is 526mm, so these can fit flush between R2 and R4 curves for multi-lane layouts.

Angles available are:
* 22.5˚ - C8204
* 45˚ banked - C8297
* 22.5˚ single-lane = C7017


### Straights

#### Standard straight

Length = 350mm.

Two-lane piece = C8205
Arc Pro power section = C????
Two-lane side-swipe straights (pair) = C8246, total length = 700mm

#### Half straight

Length = 175mm.

Two-lane piece = C8207
Two-lane piece with start-grid markings = C7018
One-lane piece = C7016

#### Quarter straight

C8200, length = 87.5mm

#### Short straight

C8236, length = 78mm


### Special pieces

#### Pit-lane entry/exit

Details to follow, basically they are 1-lane-in/2-lanes-out, and 2-lanes-in/1-lane-out, and are 1.5 standard straights in length, ie length of 525mm

#### 90˚ crossroads

C8210. TODO: Add dimensions

#### 90˚ flyover

C8295. TODO: Add dimensions

#### Straight lane-changer

C7036, straight lane-changer, 1.5 standard straights in length, ie length of 525mm

#### Curve lane-changer

C7007, half-straight detector, plus 45˚ radius 2 lane changer, to be used as a pair. Not part of current catalogue.


# Trade Marks

SCALEXTRIC is a registered Trade Mark of Hornby Hobbies Limited.

# Author

David Stevenson, Oxford UK, 2020.
david@ytfc.com