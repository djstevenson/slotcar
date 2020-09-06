package Slotcar::Track::Straight::Half;
use Moose;
use namespace::autoclean;

with 'Slotcar::Track::Role::Straight';
with 'Slotcar::Track::Role';

sub _build_length { return 175.0; }

sub _build_sku { return 'C8207'; }

__PACKAGE__->meta->make_immutable;
1;
