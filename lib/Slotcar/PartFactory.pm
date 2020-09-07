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

has_part C8205 => ( traits => [qw/
    Straight Standard
/]);

has_part C8207 => ( traits => [qw/
    Straight Half
/]);

has_part C8200 => ( traits => [qw/
    Straight Quarter
/]);

has_part C8236 => ( traits => [qw/
    Straight Short
/]);

has_part C8435 => ( traits => [qw/
    Straight Standard 
/]); # plus ARCPro

has_part C7036 => ( traits => [qw/
    Straight Extended
/]); # plus ActiveSensors and CrossOver

has_part C7000 => ( traits => [qw/
    Straight Half
/]); # plus ActiveSensors and InactiveSensors

has_part C7018 => ( traits => [qw/
    Straight Half
/]); # plus StartingGrid

has_part C8278 => ( traits => [qw/
    Curve R1 C16
/]);

has_part C8202 => ( traits => [qw/
    Curve R1 C8
/]);

has_part C8234 => ( traits => [qw/
    Curve R2 C16
/]);

has_part C8206 => ( traits => [qw/
    Curve R2 C8
/]);

has_part C8204 => ( traits => [qw/
    Curve R3 C16
/]);

has_part C8235 => ( traits => [qw/
    Curve R4 C16
/]);

sub BUILD {
    my $self = shift;
    use Data::Dumper;
    print STDERR Dumper($self->parts);
}

__PACKAGE__->meta->make_immutable;
1;
