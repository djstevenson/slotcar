package Slotcar::Track::Part;
use Moose;
use namespace::autoclean;

with 'MooseX::Traits';

has sku => (
    is          => 'ro',
    isa         => 'Str',
    required    => 1,
);


# Traits to be applied to the part
# e.g. Curve, Straight, ...
has traits => (
	is			=> 'ro',
	isa			=> 'ArrayRef',
	default		=> sub{ [] },
);

__PACKAGE__->meta->make_immutable;
1;
