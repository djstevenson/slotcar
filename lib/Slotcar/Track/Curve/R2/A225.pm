package Slotcar::Track::Curve::R2::A225;
use Moose;

extends 'Slotcar::Track::Curve::R2::Base';

# Units = mm
has '+angle'       => ( default => 225 );

has '+sku'         => (default => 'C8234');
has '+description' => (default => 'R2 22.5˚');

no Moose;
1;
