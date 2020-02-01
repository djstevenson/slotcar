package Slotcar::PieceFactory;
use Moose;
use namespace::autoclean;

# TODO POD DOCS
use Try::Tiny;
use Class::Load;

# Don't really want this here, move the renderer out
has svg => (
    is          => 'ro',
    isa         => 'SVG',
    required    => 1,
);

has _parts => (
    is          => 'ro',
    isa         => 'HashRef[Slotcar::Track::Base]',
    lazy        => 1,
    builder     => '_build_parts',
);

sub piece {
    my ($self, $part_sku) = @_;

    my $parts = $self->_parts;

    die "Part ${part_sku} not found" unless exists $parts->{$part_sku};

    # Currently returns a cached part object. But will need to
    # return something else, so we can have two different C8205 objects
    # for example.
    return $parts->{$part_sku};
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

    my %parts;
    foreach my $partial_class_name ( @class_names ) {
        my $full_class_name = 'Slotcar::Track::' . $partial_class_name;

        my $svg = $self->svg;

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

__PACKAGE__->meta->make_immutable;
1;
