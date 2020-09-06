package Slotcar::Track::Role;
use Moose::Role;

has sku => (
    is          => 'ro',
    isa         => 'Str',
    builder     => '_build_sku',
    init_arg    => undef,
);

requires '_build_sku';

no Moose::Role;
1;
