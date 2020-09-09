package Slotcar::Track::Part::Role::Part;
use Moose::Role;

requires 'next_piece_offset';
requires 'render_part_def';

sub create_part_group {
    my ($self, $defs) = @_;

    my $group = $defs->group(id => $self->sku);
    $self->render_part_def($group);
}

no Moose::Role;
1;
