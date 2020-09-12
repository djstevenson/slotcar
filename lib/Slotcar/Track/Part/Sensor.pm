package Slotcar::Track::Part::Sensor;
use Moose;
use namespace::autoclean;

has x => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

has active => (
    is          => 'ro',
    isa         => 'Bool',
    required    => 1,
);

__PACKAGE__->meta->make_immutable;
1;
