package Slotcar::Track::Offset;
use Moose;
use namespace::autoclean;

# TODO POD docs

use Math::Trig;

# Defines x/y/angle offset of 'end' of piece relative to
# start.

# x/y offsets are coded as if the piece was horizontal
# and oriented to the right. So, for a straight piece,
# x offset will be the piece's length, y offset will be 0.
#
# For curves, the angle is the number of degrees that the
# piece bends through. It is signed, +ve means "to the right" 
# (clockwise) as the car travels from the origin.
#
# Two examples:
#  45˚ bend to the right, angle is +450
#  22.5˚ bend to the left, angle is -225
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

    my $theta = deg2rad($self->angle);

    my $dx = $new_offset->x * cos($theta);
    my $dy = $new_offset->y * sin($theta);

    return Slotcar::Track::Offset->new(
        x     => $self->x + $dx,
        y     => $self->y + $dy,
        angle => ($self->angle + $new_offset->angle) % 3600,
    );
}

__PACKAGE__->meta->make_immutable;
1;
