package Slotcar::Track::Role::Straight;
use Moose::Role;

has length => (
    is          => 'ro',
    isa         => 'Num',
    builder     => '_build_length',
    init_arg    => undef,
);

requires '_build_length';

1;
