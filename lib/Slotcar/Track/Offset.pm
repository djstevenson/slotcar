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
#  45˚ bend to the right, angle is +45
#  22.5˚ bend to the left, angle is -22.5
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

    my $theta = $self->angle;

    my $cos_t = cos($theta);
    my $sin_t = sin($theta);
    my $x     = $new_offset->x;
    my $y     = $new_offset->y;

    my $dx = ($x * $cos_t) - ($y * $sin_t);
    my $dy = ($y * $cos_t) + ($x * $sin_t);

    my $new_x = $self->x + $dx;
    my $new_y = $self->y + $dy;

    my $angle_change = $new_offset->angle;
    my $new_angle = Math::Trig::rad2rad($self->angle + $angle_change);

    return Slotcar::Track::Offset->new(
        x     => $new_x,
        y     => $new_y,
        angle => $new_angle,
    );
}

sub log {
    my ($self, $label) = @_;

    printf STDERR "%s x=%f, y=%f, a=%f\n", $label, $self->x, $self->y, $self->angle;
}

__PACKAGE__->meta->make_immutable;
1;
