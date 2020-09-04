package Slotcar::Track::Curve::R1::C16;
use Moose;

# 1/16th circle (22.5˚) Radius 1

extends 'Slotcar::Track::Curve::R1::Base';

# Units = mm
has '+angle'       => ( default => 22.5 );

has '+sku'         => (default => 'C8278');
has '+description' => (default => 'R1 22.5˚');

no Moose;
1;
