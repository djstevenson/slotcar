package Slotcar::Track::Join::Double;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Join::Base';

# Defines the common case of a two-lane straight join
# with a join with of 156mm, lanes at 39mm from each end,
# and a gap of 78mm between lanes.

has '+lanes'    => ( default => 2 );
has '+offset_1' => ( default =>  39 );
has '+offset_2' => ( default => 117 );

__PACKAGE__->meta->make_immutable;
1;
