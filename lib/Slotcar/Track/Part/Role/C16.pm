package Slotcar::Track::Part::Role::C16;
use Moose::Role;

use Math::Trig;

sub _build_angle { return deg2rad(22.5) }

1;
