package Slotcar::Track::Part::Role::CurveL;
use Moose::Role;

use Math::Trig;

sub _is_reversed { return 1; }

with 'Slotcar::Track::Part::Role::Curve';

no Moose::Role;
1;
