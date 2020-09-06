package Slotcar::Track::Curve::R3::C16;
use Moose;

# 1/16th circle (22.5˚) Radius 3

with 'Slotcar::Track::Role::Curve::R3';
with 'Slotcar::Track::Role::Curve::C16';
with 'Slotcar::Track::Role::Curve';
with 'Slotcar::Track::Role';

sub _build_sku { return 'C8204'; }

no Moose;
1;
