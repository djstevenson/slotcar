package Slotcar::Track::Meta::Part;

use Moose::Role;

has parts => (
    traits  => ['Hash'],
    is      => 'rw',
    isa     => 'HashRef[Slotcar::Track::Part]',
    default => sub { {} },
    handles => {add_part => 'set'},
);

no Moose::Role;

1;