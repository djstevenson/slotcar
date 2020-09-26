package Slotcar::Track::Part::Role::CurveR;
use Moose::Role;

use Math::Trig;

sub _is_reversed { return 0; }

with 'Slotcar::Track::Part::Role::Curve';

no Moose::Role;
1;
