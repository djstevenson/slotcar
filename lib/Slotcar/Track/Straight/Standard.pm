package Slotcar::Track::Straight::Standard;
use Moose;
use namespace::autoclean;

with 'Slotcar::Track::Role::Straight';
with 'Slotcar::Track::Role';

sub _build_length { return 350.0; }

sub _build_sku { return 'C8205'; }

__PACKAGE__->meta->make_immutable;
1;
