package Slotcar::Layout;
use Moose;
use namespace::autoclean;

use Slotcar::Track::PieceFactory;
use Slotcar::Track::Offset;

# TOOD POD
use SVG (-inline => 1, -nocredits => 1);
use Readonly;

# Represents a collection of joined pieces, ie a 
# layout. Each piece is a Slotcar::Track::Piece instance,
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
    isa         => 'ArrayRef[Slotcar::Track::Piece]',
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

has grid => (
    is          => 'ro',
    isa         => 'Bool',
    default     => 0,
);

has current_offset => (
    is          => 'rw',
    isa         => 'Slotcar::Track::Offset',
    lazy        => 1,
    default     => sub {
        return Slotcar::Track::Offset->new(
            x     => 500,
            y     => 100,
            angle =>   0,
        )
    },
);

has _factory => (
    is          => 'ro',
    isa         => 'Slotcar::Track::PieceFactory',
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

    my $piece = $self->_factory->create_piece($sku, $self->current_offset);
    $self->append_piece($piece);

    my $new_offset = $self->current_offset->add_offset( $piece->part->next_piece_offset );
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

    # Now render the actual instances in our layout.
    $self->map_pieces( sub {
        $_->render($self->_svg);
    });

    return $self->_svg->xmlify;
}

Readonly my $GRID_1000 => '#808080';
Readonly my $GRID_500  => '#a0a0a0';
Readonly my $GRID_100  => '#c0c0c0';
Readonly my $GRID_25   => '#e8e8e8';

sub _build_svg {
    my $self = shift;

    my $svg = SVG->new(
        width  => $self->width,
        height => $self->height,
    );

    if ($self->grid) {
        # Rare valid use of C-style for loop :)
        for (my $x = 0; $x <= $self->width; $x += 25) {
            $svg->line(
                x1 => $x,
                y1 => 0,
                x2 => $x,
                y2 => $self->height,
                stroke => $self->_grid_col($x),
            );
        }
        for (my $y = 0; $y <= $self->height; $y += 25) {
            $svg->line(
                x1 => 0,
                y1 => $y,
                x2 => $self->width,
                y2 => $y,
                stroke => $self->_grid_col($y),
            );
        }
    }

    return $svg;
}

sub _grid_col {
    my ($self, $v) = @_;

    return $GRID_1000 if ($v % 1_000) == 0;
    return $GRID_500  if ($v %   500) == 0;
    return $GRID_100  if ($v %   100) == 0;
    return $GRID_25;
}

sub _build_factory {
    my $self = shift;

    return Slotcar::Track::PieceFactory->new(svg => $self->_svg);
}

__PACKAGE__->meta->make_immutable;
1;
