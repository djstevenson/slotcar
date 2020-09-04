package Slotcar::Piece;
use Moose;
use namespace::autoclean;

use Slotcar::Track::Offset;

has offset => (
    is          => 'ro',
    isa         => 'Slotcar::Track::Offset',
    required    => 1,
);

# Defines the dimensions etc of the track part
has part => (
    is          => 'ro',
    isa         => 'Slotcar::Track::Base',
    required    => 1,
);

# Render an svg 'use' tag to reference
# the definition that's already in the library
# of track elements in the defs section.
sub render {
    my $self = shift;

    my $offset = $self->offset;
    my $x = $offset->x;
    my $y = $offset->y;

    $self->part->svg->use(
        x => $x,
        y => $y,
        transform => sprintf('rotate(%f %f %f)', $self->offset->angle, $x, $y),
        '-href' => '#' . $self->part->sku,
    );

    $self->part->svg->circle(
        cx => $x,
        cy => $y,
        r  => 4,
        fill => '#c0c0c0',
        stroke => '#ff9966',
        'stroke-width' => 2.0,
    );
}

__PACKAGE__->meta->make_immutable;
1;
