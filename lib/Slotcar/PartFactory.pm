package Slotcar::PartFactory;
use Moose;
use namespace::autoclean;

use Slotcar::Track::Moose;

# TODO POD DOCS
use Try::Tiny;
use Class::Load;

use Slotcar::Track::Part;

# TODO Support renderer plugins - for now it's just SVG
has svg => (
    is          => 'ro',
    isa         => 'SVG',
    required    => 1,
);

has parts => (
    is       => 'ro',
    isa      => 'HashRef[Slotcar::Track::Part]',
    required => 1,
    default  => sub { ref(shift)->meta->parts },
);

has_part C8205 => (
    traits => [qw/ Straight Standard /],
    # traits => [ 'Slotcar::Track::Role::Straight', 'Slotcar::Track::Role::Standard']
);

has_part C8206 => (
    traits => [qw/ Curve R2 C8 /],
    # traits => [ 'Slotcar::Track::Role::Curve', 'Slotcar::Track::Role::R2', 'Slotcar::Track::Role::C8']
);

has_part C8234 => (
    traits => [qw/ Curve R2 C16 /],
    # traits => [ 'Slotcar::Track::Role::Curve', 'Slotcar::Track::Role::R2', 'Slotcar::Track::Role::C16']
);

sub BUILD {
    my $self = shift;
    use Data::Dumper;
    print STDERR Dumper($self->parts);
}

__PACKAGE__->meta->make_immutable;
1;
