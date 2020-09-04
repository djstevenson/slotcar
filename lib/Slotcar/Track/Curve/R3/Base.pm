package Slotcar::Track::Curve::R3::Base;
use Moose;

extends 'Slotcar::Track::Curve::Base';

# Units = mm
has '+radius' => ( default => 448 );

no Moose;
1;
