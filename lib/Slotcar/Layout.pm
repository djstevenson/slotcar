package Slotcar::Layout;
use Moose;
use namespace::autoclean;

use Slotcar::PieceFactory;
use Slotcar::Track::Offset;

# TOOD POD
use SVG (-inline => 1, -nocredits => 1);

# Represents a collection of joined pieces, ie a 
# layout. Each piece is a Slotcar::Piece instance,
# which has an x,y coordinate, a rotation angle,
# and a 'part', which is an instance of 
# Slotcar::Track::*
#
# If you have, say, four standard straights, that's
# four pieces, each referencing one part.  Each piece
# refers to the same part but has its own offset.
# The first piece has offset x=0, y=0, a=0.

has pieces => (
    is          => 'ro',
    isa         => 'ArrayRef[Slotcar::Piece]',
    lazy        => 1,
    default     => sub { return []; },
    traits      => ['Array'],
    handles     => {
        piece_count   => 'count',
        all_pieces    => 'elements',
        append_piece  => 'push',
        map_pieces    => 'map',
    },
);

# Board width/height in mm.
has width => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

has height => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

has current_offset => (
    is          => 'rw',
    isa         => 'Slotcar::Track::Offset',
    lazy        => 1,
    default     => sub {
        return Slotcar::Track::Offset->new(
            x     => 0,
            y     => 0,
            angle => 0,
        )
    },
);

has _factory => (
    is          => 'ro',
    isa         => 'Slotcar::PieceFactory',
    lazy        => 1,
    builder     => '_build_factory',
);

# TODO Support renderer plugins - for now it's just SVG
has _svg => (
    is          => 'ro',
    isa         => 'SVG',
    lazy        => 1,
    builder     => '_build_svg',
);

sub add_piece {
    my ($self, $sku) = @_;

    my $piece = $self->_factory->piece($sku, $self->current_offset);
    $self->append_piece($piece);

    my $new_offset = $self->current_offset->add_offset( $piece->part->next_piece_offset );
    print STDERR "OFF x=", $new_offset->x, " y=", $new_offset->y, " a=", $new_offset->angle, "\n";
    $self->current_offset( $new_offset );
}

sub add_pieces {
    my ($self, $skus) = @_;

    map {
        $self->add_piece($_)
    } @{ $skus };
}

sub render {
    my $self = shift;

    # Render a defs section which defines what track pieces
    # look like. It's a "library" of track parts, if you like.
    $self->_factory->render_defs;

    # Now render the actual instances in our layout.
    $self->map_pieces( sub {
        $_->render;
    });

    return $self->_svg->xmlify;
}

sub _build_svg {
    my $self = shift;

    return SVG->new(
        width  => $self->width,
        height => $self->height,
    );
}

sub _build_factory {
    my $self = shift;

    return Slotcar::PieceFactory->new(svg => $self->_svg);
}

__PACKAGE__->meta->make_immutable;
1;
