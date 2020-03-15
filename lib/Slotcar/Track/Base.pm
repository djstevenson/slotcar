package Slotcar::Track::Base;
use Moose;
# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

use Slotcar::Track::Join::Base;

use Readonly;

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
    default     => 156,
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

    my $svg = $self->svg;
    
    my $track = $defs->group(id => $self->sku);

    # Override any or all of the following render
    # methods. If you don't need to draw one or
    # more of those things, don't bother overriding
    # the specific method
    $self->render_base($track);
    $self->render_markings($track);
    $self->render_conductors($track);
    $self->render_conductor_mods($track);
}

# Override to draw track base
sub render_base {}  # args = $self, $track

# Override to draw any paint markings - paint applied to the
# road plasic. Default is to paint nothing, override it if required.
# 
sub render_markings {}  # args = $self, $track

# Override to draw the conductors and grooves.
# 
sub render_conductors {}  # args = $self, $track

# Render things that go 'over' the conductors,
# i.e. things that should be rendered AFTER the
# conductor/groove. Example is the hole for
# the car detectors.
# 
sub render_conductor_mods {}  # args = $self, $track

has conductor_width => (
    is          => 'ro',
    isa         => 'Num',
    default     => 11.0,
);

has groove_width => (
    is          => 'ro',
    isa         => 'Num',
    default     => 3.0,
);

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

has sensor_hole_dummy => (
    is          => 'ro',
    isa         => 'Str',
    default     => '#000000',
);

has sensor_hole_active => (
    is          => 'ro',
    isa         => 'Str',
    default     => '#005000',
);

Readonly my $RADIUS   =>  4.0;
sub render_sensor {
    my ($self, $track, $sensor) = @_;

    # $sensor is a hash 
    # x, y = centre coords
    # type = dummy or active (changes colour)

    my $fill_attr_name = 'sensor_hole_' . $sensor->{type};
    my $fill_attr = $self->$fill_attr_name;
    $track->circle(
        cx => $sensor->{x},
        cy => $sensor->{y},
        r  => $RADIUS,
        fill => $fill_attr,
        stroke => $self->track_base_colour,
        'stroke-width' => 0.5,
    );
}

no Moose;
1;
