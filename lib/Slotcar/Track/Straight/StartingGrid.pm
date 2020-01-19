package Slotcar::Track::Straight::StartingGrid;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Straight::Half';

# Same dimensions has half-straight, but will
# render different

has '+sku'         => (default => 'C7018');
has '+description' => (default => 'Stater Grid');

__PACKAGE__->meta->make_immutable;
1;
