package Slotcar::Track::Curve::R2::C4;
use Moose;

# 1/4th of a circle, i.e. 90˚
# Only sold via sets, not normally available
# separately (but pops up on Ebay etc).

extends 'Slotcar::Track::Curve::R2::Base';

# Units = mm
has '+angle'       => ( default => 4 );

has '+sku'         => (default => 'C8529');
has '+description' => (default => 'R2 90˚');

no Moose;
1;
