package Slotcar::Track::Curve::R4::Base;
use Moose;

extends 'Slotcar::Track::Curve::Base';

# Units = mm
has '+radius' => ( default => 604 );

no Moose;
1;
