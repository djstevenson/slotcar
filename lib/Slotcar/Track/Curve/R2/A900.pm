package Slotcar::Track::Curve::R2::A900;
use Moose;

# Only sold via sets, not normally available
# separately (but pops up on Ebay etc).

extends 'Slotcar::Track::Curve::R2::Base';

# Units = mm
has '+angle'       => ( default => 900 );

has '+sku'         => (default => 'C8529');
has '+description' => (default => 'R2 90˚');

no Moose;
1;
