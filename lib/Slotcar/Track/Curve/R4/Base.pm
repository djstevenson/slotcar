package Slotcar::Track::Curve::R4::Base;
use Moose;

extends 'Slotcar::Track::Curve::Base';

# Units = µm
has '+radius' => ( default => 682_000 );

no Moose;
1;
