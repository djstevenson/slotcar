package Slotcar::Track::Part::Role::Standard;
use Moose::Role;

sub _build_length { return 350.0 }

no Moose::Role;
1;
