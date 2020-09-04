package Slotcar::Track::Curve::R2::Base;
use Moose;

extends 'Slotcar::Track::Curve::Base';

# Units = mm
has '+radius' => ( default => 292 );

no Moose;
1;
