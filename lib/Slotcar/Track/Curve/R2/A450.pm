package Slotcar::Track::Curve::R2::A450;
use Moose;

extends 'Slotcar::Track::Curve::R2::Base';

# Units = mm
has '+angle'       => ( default => 450 );

has '+sku'         => (default => 'C8206');
has '+description' => (default => 'R2 45˚');

no Moose;
1;
