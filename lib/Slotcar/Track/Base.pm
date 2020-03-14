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
    die 'Override render_def';
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
