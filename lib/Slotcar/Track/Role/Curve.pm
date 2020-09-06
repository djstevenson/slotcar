package Slotcar::Track::Role::Curve;
use Moose::Role;

with 'Slotcar::Track::Role';

# mm radius of centre-line of curve
has radius => (
    is          => 'ro',
    isa         => 'Num',
    builder     => '_build_radius',
    init_arg    => undef,
);

# RADIANS!
has angle => (
    is          => 'ro',
    isa         => 'Num',
    builder     => '_build_angle',
    init_arg    => undef,
);


requires '_build_radius';
requires '_build_angle';

no Moose::Role;
1;
