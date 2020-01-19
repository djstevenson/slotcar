package Slotcar::Track::Straight::Standard;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Straight::Base';

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

has '+length'      => ( default => 350_000);  # 350mm
has '+sku'         => (default => 'C8205');
has '+description' => (default => 'Standard Straight');

__PACKAGE__->meta->make_immutable;
1;
