package Slotcar::Layout;
use Moose;
use namespace::autoclean;

use Slotcar::PieceFactory;

# TOOD POD
use SVG (-inline => 1, -nocredits => 1);

# Represents a collection of joined pieces, ie a 
# layout. Each piece is a Slotcar::Piece instance,
# which has an x,y coordinate, a rotation angle,
# and a 'type', which is an instance of 
# Slotcar::Track::*

has pieces => (
    is          => 'ro',
    isa         => 'ArrayRef[Slotcar::Piece]',
    lazy        => 1,
    default     => sub { return []; },
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

    my $piece = $self->_factory->piece($sku);
    push @{ $self->pieces }, $piece;
}

sub add_pieces {
    my ($self, $skus) = @_;

    foreach my $sku ( @{ $skus } ) {
        $self->add_piece($sku);
    }
}

sub render {
    my $self = shift;

    # Render a defs section which defines what track pieces
    # look like. It's a "library" of track parts, if you like.
    $self->_factory->render_defs;

    # Now render the actual instances in our layout.
    my $piece = $self->pieces->[0] or die 'No pieces to render';

    $piece->render;
    
    return $self->_svg->xmlify;
}

sub _build_svg {
    # TODO parameterise base board dimensions

    return SVG->new(  # 1m square base board
        width  => 1_000,
        height => 1_000,
    );
}

sub _build_factory {
    my $self = shift;

    return Slotcar::PieceFactory->new(svg => $self->_svg);
}

__PACKAGE__->meta->make_immutable;
1;
