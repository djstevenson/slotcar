package Slotcar::Track::Curve::R1::C8;
use Moose;

extends 'Slotcar::Track::Curve::R1::Base';

# Units = mm
has '+angle'       => ( default => 450 );

has '+sku'         => (default => 'C8202');
has '+description' => (default => 'R1 45˚');

no Moose;
1;
