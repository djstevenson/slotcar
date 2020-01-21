package Slotcar::Track::Curve::R1::Base;
use Moose;

extends 'Slotcar::Track::Curve::Base';

# Units = µm
has '+radius' => ( default => 214_000 );

no Moose;
1;
