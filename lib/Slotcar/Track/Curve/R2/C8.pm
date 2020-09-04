package Slotcar::Track::Curve::R2::C8;
use Moose;

# 1/8th circle (45˚) Radius 2

extends 'Slotcar::Track::Curve::R2::Base';

# Units = mm
has '+angle'       => ( default => 45.0 );

has '+sku'         => (default => 'C8206');
has '+description' => (default => 'R2 45˚');

no Moose;
1;
