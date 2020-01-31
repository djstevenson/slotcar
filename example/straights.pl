#!/usr/bin/env perl

use strict;
use warnings;

use FindBin::libs;
use List::Util qw( sum );

# Need a factory to make these easier to construct
use Slotcar::Track::Straight::ARCPowerBase;
use Slotcar::Track::Straight::Standard;
use Slotcar::Track::Straight::Half;
use Slotcar::Track::Straight::StartingGrid;
use Slotcar::Track::Straight::Quarter;
use Slotcar::Track::Straight::Short;
use Slotcar::Track::Curve::R1::C16;
use Slotcar::Track::Curve::R2::C8;
use Slotcar::Track::Curve::R3::C16;
use Slotcar::Track::Curve::R4::C16;

use SVG (-inline => 1, -nocredits => 1);

my $svg = SVG->new(  # 1m square base board
    width  => 1_000,
    height => 1_000,
);

my $track = [
    Slotcar::Track::Straight::ARCPowerBase->new(svg => $svg),
    Slotcar::Track::Straight::Standard->new(svg => $svg),
    Slotcar::Track::Straight::Standard->new(svg => $svg),
    Slotcar::Track::Straight::Half->new(svg => $svg),
    Slotcar::Track::Straight::StartingGrid->new(svg => $svg),
    Slotcar::Track::Straight::Quarter->new(svg => $svg),
    Slotcar::Track::Straight::Short->new(svg => $svg),
    Slotcar::Track::Curve::R1::C16->new(svg => $svg),
    Slotcar::Track::Curve::R2::C8->new(svg => $svg),
    Slotcar::Track::Curve::R3::C16->new(svg => $svg),
    Slotcar::Track::Curve::R4::C16->new(svg => $svg),
];

# Can currently only render one piece
$track->[1]->render;
# $track->[5]->render;
print $svg->xmlify;

# Can we invent a DSL for describing tracks?
# c8425 <=> C8205 <=> C8205 <=> C8207 etc?
# <=> means connect right join of first item to 
#     left join of second.
#
# Not yet sure how we'd do crossroads etc.
