package Slotcar::Track::Part::Role::C4;
use Moose::Role;

use Math::Trig;

sub _build_angle { return deg2rad(90.0) }

1;
