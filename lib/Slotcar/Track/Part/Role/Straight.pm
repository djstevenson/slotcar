package Slotcar::Track::Part::Role::Straight;
use Moose::Role;

has length => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
    builder     => '_build_length',
);

use Slotcar::Track::Offset;

sub next_piece_offset {
    my ($self) = @_;

    return Slotcar::Track::Offset->new(
        x     => $self->length,
        y     => 0,
        angle => 0,
    );
}

no Moose::Role;
1;
