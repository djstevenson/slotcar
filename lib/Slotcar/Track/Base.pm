package Slotcar::Track::Base;
use Moose;
# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

use Slotcar::Track::Join::Base;

# Override these with values for each piece type
has lanes => (
    is          => 'ro',
    isa         => 'Int',
    required    => 1,
);

has sku => (
    is          => 'ro',
    isa         => 'Str',
    required    => 1,
);

has description => (
    is          => 'ro',
    isa         => 'Str',
    required    => 1,
);

# Units are mm
has width => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

# You'll want to override the builder to setup
# your joins.
has joins => (
    is          => 'ro',
    isa         => 'HashRef[Slotcar::Track::Join::Base]',
    lazy        => 1,
    builder     => 'define_joins',
);

# Default = no joins, not very useful, override it
sub define_joins {
    return {};
}

# TODO Renderer in different classes?
has svg => (
    is          => 'ro',
    isa         => 'SVG',
    required    => 1,
);

sub render_def {
    my ($self, $defs) = @_;

    # Renders a definition of this object that isn't visible.
    # We can later instantiate ('use' in SVG) instances with
    # different locations etc.
    
    my $object = $defs->group(id => $self->sku);

    $object->rectangle(
        fill => $self->track_base_colour,
        stroke => $self->track_edge_colour,
        'stroke-width' => 2,
        x => 0,
        y => 0,
        width => $self->length,
        height => $self->width,
    );

    my $groove_y1 = $self->joins->{left}->offset_1;
    my $groove_y2 = $self->joins->{left}->offset_2;
    my $groove_l = $self->length;

    my $groove_1 = $object->group;
    # Conductors
    $groove_1->rectangle(
        fill => $self->conductor_colour,
        x => 0,
        y => $groove_y1 - 5,
        width => $self->length,
        height => 10,
    );
    # Slot
    $groove_1->rectangle(
        fill => $self->groove_colour,
        x => 0,
        y => $groove_y1 - 1.5,
        width => $self->length,
        height => 3,
    );

    my $groove_2 = $object->group;
    # Conductors
    $groove_2->rectangle(
        fill => $self->conductor_colour,
        x => 0,
        y => $groove_y2 - 5,
        width => $self->length,
        height => 10,
    );
    # Slot
    $groove_2->rectangle(
        fill  => $self->groove_colour,
        x => 0,
        y => $groove_y2 - 1.5,
        width => $self->length,
        height => 3,
    );
}

has track_base_colour => (
    is          => 'ro',
    isa         => 'Str',
    default     => '#333333',
);

has track_edge_colour => (
    is          => 'ro',
    isa         => 'Str',
    default     => '#000000',
);

has conductor_colour => (
    is          => 'ro',
    isa         => 'Str',
    default     => '#c0c0c0', # HTML silver
);

has groove_colour => (
    is          => 'ro',
    isa         => 'Str',
    default     => '#000000',
);

has white_paint => (
    is          => 'ro',
    isa         => 'Str',
    default     => '#b0b0b0',
);


no Moose;
1;
