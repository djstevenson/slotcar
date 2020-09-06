package Slotcar::Track::Curve::R1::C16;
use Moose;
use namespace::autoclean;

# 1/8th circle (45˚) Radius 1

with 'Slotcar::Track::Role::Curve::R1';
with 'Slotcar::Track::Role::Curve::C16';
with 'Slotcar::Track::Role::Curve';

sub _build_sku { return 'C8278'; }

__PACKAGE__->meta->make_immutable;
1;
