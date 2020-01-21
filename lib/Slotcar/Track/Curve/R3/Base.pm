package Slotcar::Track::Curve::R3::Base;
use Moose;

extends 'Slotcar::Track::Curve::Base';

# Units = µm
has '+radius' => ( default => 526_000 );

no Moose;
1;
