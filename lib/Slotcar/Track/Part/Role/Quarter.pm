package Slotcar::Track::Part::Role::Quarter;
use Moose::Role;

sub _build_length { return 87.5 }

no Moose::Role;
1;
