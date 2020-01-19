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

# Units are µm
# Obviously we don't need that fine-grained level
# of accuracy, but it allows us to declare quarter
# straights (87.5mm), for example, without going
# to floating point
has width => (
    is          => 'ro',
    isa         => 'Int',
    required    => 1,
);

# Units are µm
# Override this to set a length
# e.g. has '+length' => (default => 350_000);
has length => (
    is          => 'ro',
    isa         => 'Int',
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

no Moose;
1;
