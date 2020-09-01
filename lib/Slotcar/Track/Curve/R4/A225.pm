package Slotcar::Track::Curve::R4::A225;
use Moose;

extends 'Slotcar::Track::Curve::R4::Base';

# Units = mm
has '+angle'       => ( default => 225 );

has '+sku'         => (default => 'C8235');
has '+description' => (default => 'R4 22.5˚');

no Moose;
1;
