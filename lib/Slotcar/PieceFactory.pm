package Slotcar::PieceFactory;
use Moose;
use namespace::autoclean;

# TODO POD DOCS
use Try::Tiny;
use Class::Load;

use Slotcar::Piece;

has _parts => (
    is          => 'ro',
    isa         => 'HashRef[Slotcar::Track::Base]',
    lazy        => 1,
    builder     => '_build_parts',
);

# TODO Support renderer plugins - for now it's just SVG
has svg => (
    is          => 'ro',
    isa         => 'SVG',
    required    => 1,
);


sub piece {
    my ($self, $part_sku) = @_;

    my $parts = $self->_parts;

    die "SKU '${part_sku}' not found"
        unless exists $parts->{$part_sku};

    return Slotcar::Piece->new(
        x        => 0,  # Parameter x/y/r
        y        => 0,
        rotation => 0,
        part     => $parts->{$part_sku},
    );
}

sub _build_parts {
    my $self = shift;

    my @class_names = (
        'Straight::ARCPowerBase',
        'Straight::Standard',
        'Straight::Half',
        'Straight::StartingGrid',
        'Straight::Quarter',
        'Straight::Short',
        'Curve::R1::C8',
        'Curve::R1::C16',
        'Curve::R2::C4',
        'Curve::R2::C8',
        'Curve::R2::C16',
        'Curve::R3::C16',
        'Curve::R4::C16',
    );

    my $svg = $self->svg;
    my %parts;
    foreach my $partial_class_name ( @class_names ) {
        my $full_class_name = 'Slotcar::Track::' . $partial_class_name;

        # Will die if a class fails to load, or we can't
        # create an instance. That's probably the correct
        # behaviour
        Class::Load::load_class($full_class_name);
        my $part_object = $full_class_name->new(svg => $svg);
        my $sku = $part_object->sku;
        $parts{$sku} = $part_object;
    }

    return \%parts;
}

# Create a 'defs' section in the SVG which
# describes what each track piece looks like, but
# remains hidden. We'll then instantiate ('use' in SVG)
# references to those defs in different physical locations.
sub render_defs {
    my $self = shift;

    my $svg = $self->svg;

    my $defs = $svg->defs(id => 'defs');

    foreach my $part ( values %{ $self->_parts }) {
        $part->render_def($defs);
    }
}

__PACKAGE__->meta->make_immutable;
1;
