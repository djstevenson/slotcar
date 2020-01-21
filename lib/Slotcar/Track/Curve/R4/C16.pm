package Slotcar::Track::Curve::R4::C16;
use Moose;

# 1/16th of a circle, i.e. 22.5˚

extends 'Slotcar::Track::Curve::R4::Base';

# Units = µm
has '+angle'       => ( default => 16 );

has '+sku'         => (default => 'C8235');
has '+description' => (default => 'R4 22.5˚');

no Moose;
1;
