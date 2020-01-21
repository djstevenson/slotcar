package Slotcar::Track::Curve::R1::C8;
use Moose;

# 1/8th of a circle, i.e. 45˚

extends 'Slotcar::Track::Curve::R1::Base';

# Units = µm
has '+angle'       => ( default => 8 );

has '+sku'         => (default => 'C8202');
has '+description' => (default => 'R1 45˚');

no Moose;
1;
