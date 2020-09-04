package Slotcar::Track::Curve::R3::C16;
use Moose;

# 1/16th circle (22.5˚) Radius 3

extends 'Slotcar::Track::Curve::R3::Base';

# Units = mm
has '+angle'       => ( default => 22.5 );

has '+sku'         => (default => 'C8204');
has '+description' => (default => 'R3 22.5˚');

no Moose;
1;
