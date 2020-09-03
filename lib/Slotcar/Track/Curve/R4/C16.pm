package Slotcar::Track::Curve::R4::C16;
use Moose;

# 1/16th circle (22.5˚) Radius 4

extends 'Slotcar::Track::Curve::R4::Base';

# Units = mm
has '+angle'       => ( default => 22.5 );

has '+sku'         => (default => 'C8235');
has '+description' => (default => 'R4 22.5˚');

no Moose;
1;
