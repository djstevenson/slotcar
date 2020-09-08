package Slotcar::Track::Part::Role::Short;
use Moose::Role;

sub _build_length { return 78.0 }

no Moose::Role;
1;
