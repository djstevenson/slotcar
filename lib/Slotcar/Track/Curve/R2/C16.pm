package Slotcar::Track::Curve::R2::C16;
use Moose;

# 1/16th circle (22.5˚) Radius 2

with 'Slotcar::Track::Role::Curve::R2';
with 'Slotcar::Track::Role::Curve::A22_5';
with 'Slotcar::Track::Role::Curve';

sub _build_sku { return 'C8234'; }

no Moose;
1;
