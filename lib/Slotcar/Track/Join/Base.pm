package Slotcar::Track::Join::Base;
use Moose;

# Base class for all track-join definitions.
# POD docs will be added once the design is
# honed.

# A join has a position relative to the track piece's
# origin (top left, piece laid in the most logical
# orientation that you'd describe as "horizontal").
#
#
# It also has an orientation, which will be needed 
# for curves. 0˚ orientation is vertical, e.g. 
# along the short side of a standard straight.
#
# A join usually has two lanes, but can have one (e.g. 
# pit lane pieces have one at one or both ends).
#
# Track pieces normally have two joins, but there are pieces
# with four (90˚ crossover).  Currently none with one or three
# that I am aware of.

#
# Note, joins at opposite ends are normally 180˚ from each other
# e.g. one connects to the left and one to the right. On a straight,
# both left and right joins are stored as 0˚, but the latter has
# 'is_inverted' set. Not yet sure if this is the right design...
#
# Curve angles are stored as integer fractions of a circle,
# so 90˚ is represented as 4 (1/4 circle), 45˚ as 8,
# 22.5˚ as 16, etc.

has lanes => (
    is          => 'ro',
    isa         => 'Int',
    required    => 1,
);

# Units are µm
has offset_x => (
    is          => 'ro',
    isa         => 'Int',
    required    => 1,
);

has offset_y => (
    is          => 'ro',
    isa         => 'Int',
    required    => 1,
);

# True for right-end join
has is_inverted => (
    is          => 'ro',
    isa         => 'Bool',
    default     => 0,
);

no Moose;
1;
