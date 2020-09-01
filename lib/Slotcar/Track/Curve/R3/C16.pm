package Slotcar::Track::Curve::R3::C16;
use Moose;

extends 'Slotcar::Track::Curve::R3::Base';

# Units = mm
has '+angle'       => ( default => 225 );

has '+sku'         => (default => 'C8204');
has '+description' => (default => 'R3 22.5˚');

no Moose;
1;
