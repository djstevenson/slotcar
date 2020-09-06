package Slotcar::Track::Straight::Quarter;
use Moose;
use namespace::autoclean;

with 'Slotcar::Track::Role::Straight';
with 'Slotcar::Track::Role';

sub _build_length { return 87.5; }

sub _build_sku { return 'C8200'; }

__PACKAGE__->meta->make_immutable;
1;
