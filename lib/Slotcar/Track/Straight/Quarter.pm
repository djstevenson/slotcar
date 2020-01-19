package Slotcar::Track::Straight::Quarter;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Straight::Base';

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

has '+length' => ( default => 87_500);    # 87.5mm

__PACKAGE__->meta->make_immutable;
1;
