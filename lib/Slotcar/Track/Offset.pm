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

__PACKAGE__->meta->make_immutable;
1;
