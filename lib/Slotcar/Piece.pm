package Slotcar::Piece;
use Moose;
use namespace::autoclean;

has x => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

has y => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

# Degrees clockwise from "left join is vertical"
has rotation => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

# Defines the dimensions etc of the track piece
has track => (
    is          => 'ro',
    isa         => 'Slotcar::Track::Base',
    required    => 1,
);


__PACKAGE__->meta->make_immutable;
1;
