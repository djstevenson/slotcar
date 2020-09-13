package Slotcar::Track::Piece;
use Moose;
use namespace::autoclean;

use Math::Trig qw/ rad2deg pi /;

use Slotcar::Track::Offset;

has offset => (
    is          => 'ro',
    isa         => 'Slotcar::Track::Offset',
    required    => 1,
);

# Defines the dimensions etc of the track part
has part => (
    is          => 'ro',
    isa         => 'Slotcar::Track::Part',
    required    => 1,
);

# True if 'reversed'. Curve parts, by default,
# curve to the right (anti-clockwise) for cars
# traversing the circuit. To curve to the left,
# set this to true.
has reversed => (
    is          => 'ro',
    isa         => 'Bool',
    default     => 0,
);

# Render an svg 'use' tag to reference
# the definition that's already in the library
# of track elements in the defs section.
sub render {
    my ($self, $svg) = @_;

    my $offset = $self->offset;
    my $x      = $offset->x;
    my $y      = $offset->y;
    my $angle  = $offset->angle;

    my $extra = '';
    my ($x2, $y2) = (0,0);
    if ($self->reversed) {
        $extra = sprintf('rotate(%f %f %f)',
            rad2deg(pi - $self->part->next_piece_offset->angle),
            $x,
            $y
        );
        $x2 = - $self->part->next_piece_offset->x;
        $y2 = - $self->part->next_piece_offset->y;
    }

    $svg->use(
        x => $x + $x2,
        y => $y + $y2,
        transform => sprintf('rotate(%f %f %f) %s', rad2deg($angle), $x, $y, $extra),
        '-href' => '#' . $self->part->sku,
    );
}

__PACKAGE__->meta->make_immutable;
1;
