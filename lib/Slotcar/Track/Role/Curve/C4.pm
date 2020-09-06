package Slotcar::Track::Role::Curve::C4;
use Moose::Role;

use Math::Trig;

sub _build_angle {
    return deg2rad(90.0);
}

no Moose::Role;
1;
