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

    $self->part->svg->use(
        x => $self->offset->x,
        y => $self->offset->y,
        # transform => 'rotate($self->offset->angle)',
        '-href' => '#' . $self->part->sku,
    );
}

__PACKAGE__->meta->make_immutable;
1;
