package Slotcar::Track::Curve::R2::Base;
use Moose;

extends 'Slotcar::Track::Curve::Base';

# Units = mm
has '+radius' => ( default => 370 );

no Moose;
1;
