package Slotcar::Track::Straight::Quarter;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Straight::Base';

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

has '+length'      => ( default => 87.5);
has '+sku'         => (default => 'C8200');
has '+description' => (default => 'Quarter Straight');

__PACKAGE__->meta->make_immutable;
1;
