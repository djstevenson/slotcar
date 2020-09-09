package Slotcar::Track::Part::Role::StartingGrid;
use Moose::Role;

after render_part_def => sub {
    my ($self, $svg) = @_;

	print STDERR $self->sku, " Render grid\n";
};

no Moose::Role;
1;
