package Slotcar::Track::Curve::R1::Base;
use Moose;

extends 'Slotcar::Track::Curve::Base';

# Units = mm
has '+radius' => ( default => 136 );

no Moose;
1;
