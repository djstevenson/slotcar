package Slotcar::Track::Piece;
use Moose;
use namespace::autoclean;

use Math::Trig qw/ rad2deg /;

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

# Render an svg 'use' tag to reference
# the definition that's already in the library
# of track elements in the defs section.
sub render {
    my ($self, $svg) = @_;

    my $offset = $self->offset;
    my $x      = $offset->x;
    my $y      = $offset->y;
    my $angle  = $offset->angle;

    $svg->use(
        x => $x,
        y => $y,
        transform => sprintf('rotate(%f %f %f)', rad2deg($angle), $x, $y),
        '-href' => '#' . $self->part->sku,
    );
}

__PACKAGE__->meta->make_immutable;
1;
