package Slotcar::Track::Join::Double;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Join::Base';

# Defines the common case of a two-lane straight join
# with a join with of 156mm, lanes at 39mm from each end,
# and a gap of 78mm between lanes.

has '+lanes'    => ( default => 2 );
has '+offset_x' => ( default => 0 );
has '+offset_y' => ( default => 0 );

__PACKAGE__->meta->make_immutable;
1;
