package Slotcar::Track::Curve::R1::C8;
use Moose;

# 1/8th circle (45˚) Radius 1

extends 'Slotcar::Track::Curve::R1::Base';

# Units = mm
has '+angle'       => ( default => 45.0 );

has '+sku'         => (default => 'C8202');
has '+description' => (default => 'R1 45˚');

no Moose;
1;
