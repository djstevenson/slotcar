package Slotcar::Track::Curve::R4::C16;
use Moose;

# 1/16th circle (22.5˚) Radius 4

with 'Slotcar::Track::Role::Curve::R4';
with 'Slotcar::Track::Role::Curve::C16';
with 'Slotcar::Track::Role::Curve';

sub _build_sku { return 'C8235'; }

no Moose;
1;
