package Slotcar::Track::Part::Colours;
use Moose;
use namespace::autoclean;

has track_base  => (is => 'ro', isa => 'Str', default => '#333333');
has conductor   => (is => 'ro', isa => 'Str', default => '#c0c0c0');
has groove      => (is => 'ro', isa => 'Str', default => '#000000');
has edge        => (is => 'ro', isa => 'Str', default => '#111111');

has white_paint => (is => 'ro', isa => 'Str', default => '#dddddd');

__PACKAGE__->meta->make_immutable;
1;
