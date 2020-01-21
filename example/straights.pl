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

my $track = [
    Slotcar::Track::Straight::ARCPowerBase->new,
    Slotcar::Track::Straight::Standard->new,
    Slotcar::Track::Straight::Standard->new,
    Slotcar::Track::Straight::Half->new,
    Slotcar::Track::Straight::StartingGrid->new,
    Slotcar::Track::Straight::Quarter->new,
    Slotcar::Track::Straight::Short->new,
    Slotcar::Track::Curve::R1::C16->new,
    Slotcar::Track::Curve::R2::C8->new,
    Slotcar::Track::Curve::R3::C16->new,
    Slotcar::Track::Curve::R4::C16->new,
];

use Data::Dumper;
print "Standard joins = ", Dumper($track->[0]->joins);
print "Start Grid joins = ", Dumper($track->[3]->joins);
print "R1 22.5˚ curve joins = ", Dumper($track->[6]->joins);

# Can we invent a DSL for describing tracks?
# c8425 <=> C8205 <=> C8205 <=> C8207 etc?
# <=> means connect right join of first item to 
#     left join of second.
#
# Not yet sure how we'd do crossroads etc.
