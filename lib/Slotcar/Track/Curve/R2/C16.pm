package Slotcar::Track::Curve::R2::C16;
use Moose;

# 1/16th circle (22.5˚) Radius 2

extends 'Slotcar::Track::Curve::R2::Base';

# Units = mm
has '+angle'       => ( default => 22.5 );

has '+sku'         => (default => 'C8234');
has '+description' => (default => 'R2 22.5˚');

no Moose;
1;
