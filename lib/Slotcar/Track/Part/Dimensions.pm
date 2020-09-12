package Slotcar::Track::Part::Dimensions;
use Moose;
use namespace::autoclean;

has lane_offset => (
    is          => 'ro',
    isa         => 'Num',
    default     => 39.0
);

has half_width => (
    is          => 'ro',
    isa         => 'Num',
    lazy        => 1,
    default     => sub { shift->lane_offset * 2; },
);

has width            => (
    is          => 'ro',
    isa         => 'Num',
    lazy        => 1,
    default     => sub { shift->half_width * 2; },
);

has conductor_offset => (
    is          => 'ro',
    isa         => 'Num',
    default     => 5.5
);

has conductor_width => (
    is          => 'ro',
    isa         => 'Num',
    lazy        => 1,
    default     => sub { shift->conductor_offset * 2; },
);

has groove_offset => (
    is          => 'ro',
    isa         => 'Num',
    default     => 1.5
);

has groove_width => (
    is          => 'ro',
    isa         => 'Num',
    lazy        => 1,
    default     => sub { shift->groove_offset * 2; },
);

has sensor_radius => (
    is          => 'ro',
    isa         => 'Num',
    lazy        => 1,
    default     => 3.5,
);


__PACKAGE__->meta->make_immutable;
1;
