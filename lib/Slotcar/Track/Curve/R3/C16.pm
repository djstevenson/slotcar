package Slotcar::Track::Curve::R3::C16;
use Moose;

# 1/16th of a circle, i.e. 22.5˚

extends 'Slotcar::Track::Curve::R3::Base';

# Units = mm
has '+angle'       => ( default => 16 );

has '+sku'         => (default => 'C8204');
has '+description' => (default => 'R3 22.5˚');

no Moose;
1;
