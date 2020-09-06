package Slotcar::Track::Role::Curve::A45;
use Moose::Role;

use Math::Trig;

sub _build_angle {
    return deg2rad(45.0);
}

no Moose::Role;
1;
