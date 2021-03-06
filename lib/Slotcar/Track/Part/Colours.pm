package Slotcar::Track::Part::Colours;
use Moose;
use namespace::autoclean;

has base      => (is => 'ro', isa => 'Str', default => '#333333');
has conductor       => (is => 'ro', isa => 'Str', default => '#c0c0c0');
has groove          => (is => 'ro', isa => 'Str', default => '#000000');
has edge            => (is => 'ro', isa => 'Str', default => '#111111');

has white_paint     => (is => 'ro', isa => 'Str', default => '#dddddd');
has label           => (is => 'ro', isa => 'Str', default => '#eeee00');

has sensor_active   => (is => 'ro', isa => 'Str', default => '#339933');
has sensor_inactive => (is => 'ro', isa => 'Str', default => '#333333');

__PACKAGE__->meta->make_immutable;
1;
