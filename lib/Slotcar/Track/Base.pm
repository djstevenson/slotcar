package Slotcar::Track::Base;
use Moose;
# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

use Slotcar::Track::Offset;

use Readonly;

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

# These are attributes rather than constants
# so that pieces can override them.
# Units are mm
has width => (
    is          => 'ro',
    isa         => 'Num',
    default     => 156,
);

# Distance from origin (centre) to
# each lane centre.
# Units are mm
has lane_offset => (
    is          => 'ro',
    isa         => 'Num',
    default     => 39,
);

has next_piece_offset => (
    is          => 'ro',
    isa         => 'Slotcar::Track::Offset',
    lazy        => 1,
    builder     => 'next_piece_offset_builder',
);

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

# Readonly const rather than attribute?
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
    default     => '#e0e0d8',
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

Readonly my $RADIUS   =>  3.5;
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
        stroke => $self->track_edge_colour,
        'stroke-width' => 1.0,
    );
}

sub next_piece_offset_builder {
    die 'did not override next_piece_offset_builder';
}

no Moose;
1;
