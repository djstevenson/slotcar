package Slotcar::Track::Straight::ARCPowerBase;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Straight::Standard';

# Same as standard straight in terms of size/joins etc.
# Will render differently though as it has the power
# interface and finish line.

has '+sku'         => (default => 'C8435');
has '+description' => (default => 'ARC PRO Power Base');

__PACKAGE__->meta->make_immutable;
1;
