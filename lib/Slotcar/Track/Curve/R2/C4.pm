package Slotcar::Track::Curve::R2::C4;
use Moose;

# Only sold via sets, not normally available
# separately (but pops up on Ebay etc).

# 1/4 circle (90˚) Radius 2

extends 'Slotcar::Track::Curve::R2::Base';

# Units = mm
has '+angle'       => ( default => 90.0 );

has '+sku'         => (default => 'C8529');
has '+description' => (default => 'R2 90˚');

no Moose;
1;
