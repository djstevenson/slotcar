package Slotcar::Track::Curve::R2::Base;
use Moose;

extends 'Slotcar::Track::Curve::Base';

# Units = µm
has '+radius' => ( default => 370_000 );

no Moose;
1;
