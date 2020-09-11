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


no Moose::Role;
1;
