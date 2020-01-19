package Slotcar::Track::Straight::Half;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Straight::Base';

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

has '+length' => ( default => 175_000);   # 175mm

__PACKAGE__->meta->make_immutable;
1;
