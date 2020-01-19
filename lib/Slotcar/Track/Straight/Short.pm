package Slotcar::Track::Straight::Short;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Straight::Base';

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

has '+length'      => ( default => 78_000);    # 78mm
has '+sku'         => (default => 'C8236');
has '+description' => (default => 'Short Straight');

__PACKAGE__->meta->make_immutable;
1;
