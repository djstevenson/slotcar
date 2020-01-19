package Slotcar::Track::Straight::Base;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Base';

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

has '+lanes' => ( default => 2);
has '+width' => ( default => 156_000);  # 156mm

# Override length in a subclass.

1;
