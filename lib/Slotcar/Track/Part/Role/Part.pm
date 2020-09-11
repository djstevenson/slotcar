package Slotcar::Track::Part::Role::Part;
use Moose::Role;

requires 'next_piece_offset';
requires 'render_part_def';

sub create_part_group {
    my ($self, $defs) = @_;

    my $group = $defs->group(id => $self->sku);
    $self->render_part_def($group);
}

use Slotcar::Track::Part::Colours;

has colours => (
    is          => 'ro',
    isa         => 'Slotcar::Track::Part::Colours',
    lazy        => 1,
    default     => sub { return Slotcar::Track::Part::Colours->new; },
);

use Slotcar::Track::Part::Dimensions;

has dimensions => (
    is          => 'ro',
    isa         => 'Slotcar::Track::Part::Dimensions',
    lazy        => 1,
    default     => sub { return Slotcar::Track::Part::Dimensions->new; },
);

sub render_part_def {
    my ($self, $track) = @_;

    $self->render_base($track);
    $self->render_grooves($track);
    $self->render_paint($track);
    $self->render_border($track);
}

sub render_base    { } # Please override
sub render_grooves { } # Please override
sub render_paint   { } # Please override
sub render_border  { } # Please override

no Moose::Role;
1;
