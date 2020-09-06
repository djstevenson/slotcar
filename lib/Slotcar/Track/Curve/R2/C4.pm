package Slotcar::Track::Curve::R2::C4;
use Moose;

# Only sold via sets, not normally available
# separately (but pops up on Ebay etc).

# 1/4 circle (90˚) Radius 2

with 'Slotcar::Track::Role::Curve::C4';
with 'Slotcar::Track::Role::Curve::R2';
with 'Slotcar::Track::Role::Curve';
with 'Slotcar::Track::Role';


sub _build_sku { return 'C8529'; }

no Moose;
1;
