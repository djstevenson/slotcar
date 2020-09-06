package Slotcar::Track::Curve::R2::C8;
use Moose;

# 1/8th circle (45˚) Radius 2

with 'Slotcar::Track::Role::Curve::R2';
with 'Slotcar::Track::Role::Curve::A45';
with 'Slotcar::Track::Role::Curve';

sub _build_sku { return 'C8206'; }

no Moose;
1;
