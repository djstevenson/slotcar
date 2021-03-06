package Slotcar::Track::PieceFactory;
use Moose;
use namespace::autoclean;

use Slotcar::Track::Moose;

# https://www.youtube.com/watch?v=wFcWBrkQ87M

# TODO POD DOCS
use Try::Tiny;
use Class::Load;

use Slotcar::Track::Piece;

# TODO Support renderer plugins - for now it's just SVG
has svg => (
    is          => 'ro',
    isa         => 'SVG',
    required    => 1,
);

# A 'part' describes the size/look/etc of
# an item of track that Scalextric sells. This
# hash is keyed by the Cxxxx code.
has parts => (
    traits   => [ 'Hash' ],
    is       => 'ro',
    isa      => 'HashRef[Slotcar::Track::Part]',
    init_arg => undef,
    default  => sub { ref(shift)->meta->parts },
    handles  => {
        get_part  => 'get',
        all_parts => 'values',
    }
);

has_part C8205 => ( traits => [qw/
    Straight Standard
/]);

has_part C8207 => ( traits => [qw/
    Straight Half
/]);

has_part C8200 => ( traits => [qw/
    Straight Quarter
/]);

has_part C8236 => ( traits => [qw/
    Straight Short
/]);

has_part C8435 => ( traits => [qw/
    Straight Standard ARCPro
/]);

has_part C7036 => ( traits => [qw/
    Straight Extended LaneChanger
/]);

has_part C7000 => ( traits => [qw/
    Straight Half LaneChangeSensor
/]);

has_part C7018 => ( traits => [qw/
    Straight Half StartingGrid
/]);

has_part C8278R => ( traits => [qw/
    CurveR R1 C16
/]);

has_part C8278L => ( traits => [qw/
    CurveL R1 C16
/]);

has_part C8202R => ( traits => [qw/
    CurveR R1 C8
/]);

has_part C8202L => ( traits => [qw/
    CurveL R1 C8
/]);

has_part C8234R => ( traits => [qw/
    CurveR R2 C16
/]);

has_part C8234L => ( traits => [qw/
    CurveL R2 C16
/]);

has_part C8206R => ( traits => [qw/
    CurveR R2 C8
/]);

has_part C8206L => ( traits => [qw/
    CurveL R2 C8
/]);

has_part C8529R => ( traits => [qw/
    CurveR R2 C4
/]);

has_part C8529L => ( traits => [qw/
    CurveL R2 C4
/]);

has_part C8297R => ( traits => [qw/
    CurveR R3 C8
/]);

has_part C8297L => ( traits => [qw/
    CurveL R3 C8
/]);

has_part C8204R => ( traits => [qw/
    CurveR R3 C16
/]);

has_part C8204L => ( traits => [qw/
    CurveL R3 C16
/]);

has_part C8235R => ( traits => [qw/
    CurveR R4 C16
/]);

has_part C8235L => ( traits => [qw/
    CurveL R4 C16
/]);

sub BUILD {
    my ($self) = @_;

    $self->render_part_defs;
}

# A 'piece' is an individual item of trackwork in
# the layout.  A piece is a 'part', plus an 'offset',
# the latter defining the position and orientation.
# So, if you have 8xC8206 in a circle, you have 
# eight pieces, sharing a single part.
sub create_piece {
    my ($self, $sku, $offset) = @_;

    my $part = $self->get_part($sku) or die $sku;

    return Slotcar::Track::Piece->new(
        part     => $part,
        offset   => $offset,
    );
}

# Renders a part as a global item that can be
# referenced via a 'use' item. Part is rendered
# with its origin (centre of leading edge) at (0,0).
sub render_part_defs {
    my ($self) = @_;

    my $svg  = $self->svg;
    my $defs = $svg->defs(id => 'defs');

    for my $part ( $self->all_parts ) {
        my $track = $defs->group(id => $part->sku);
        $part->render_part_def($track);
    }

}

__PACKAGE__->meta->make_immutable;
1;
