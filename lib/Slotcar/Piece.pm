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
        x => 0,
        y => 0,
        # transform => 'rotate(-45)',
        '-href' => '#' . $self->part->sku,
    );
}

__PACKAGE__->meta->make_immutable;
1;
