package Slotcar::Track::Curve::R1::A225;
use Moose;

extends 'Slotcar::Track::Curve::R1::Base';

# Units = mm
has '+angle'       => ( default => 225 );

has '+sku'         => (default => 'C8278');
has '+description' => (default => 'R1 22.5˚');

no Moose;
1;
