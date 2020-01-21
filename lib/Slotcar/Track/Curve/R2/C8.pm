package Slotcar::Track::Curve::R2::C8;
use Moose;

# 1/8th of a circle, i.e. 45˚

extends 'Slotcar::Track::Curve::R2::Base';

# Units = µm
has '+angle'       => ( default => 8 );

has '+sku'         => (default => 'C8206');
has '+description' => (default => 'R2 45˚');

no Moose;
1;
