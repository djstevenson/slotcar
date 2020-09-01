package Slotcar::Track::Offset;
use Moose;
use namespace::autoclean;

# TODO POD docs

# Defines x/y/angle offset of 'end' of piece relative to
# start.

# x/y offsets are coded as if the piece was horizontal
# and oriented to the right. So, for a straight piece,
# x offset will be the piece's length, y offset will be 0.
#
# For curves, the angle is the proportion of a circle that
# the piece bends. It is signed, +ve means "to the right" 
# (clockwise) as the car travels from the origin.
#
# Two examples:
#  45˚ bend to the right, angle is +8
#  22.5˚ bend to the left, angle is -16
#
# Angle is 0 for straight pieces.

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

has angle => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

# TODO Document this properly
# Returns a NEW offset record which adds the
# passed-in offset to 'this'.
sub add_offset {
    my ($self, $new_offset) = @_;

    return Slotcar::Track::Offset->new(
        x     => $self->x     + $new_offset->x,
        y     => $self->y     + $new_offset->y,
        # TODO This is _not_ the correct calculation!!
        angle => $self->angle + $new_offset->angle,
    );
}

__PACKAGE__->meta->make_immutable;
1;
