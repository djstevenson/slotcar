package Slotcar::Track::Part::Role::LaneChanger::FakeCrossover;
use Moose::Role;

use Readonly;

# Should these be in the dimensions object? I think
# it's ok here, as they are specific to this part.
Readonly my $START_X => 171.0;
Readonly my $END_X   => 515.0;
Readonly my $P1_X    => 386.0;
Readonly my $P2_X    => 374.0;

has _path => (
    is          => 'ro',
    isa         => 'Str',
    lazy        => 1,
    builder     => '_make_path',
);


sub _make_path {
    my ($self) = @_;

    my $lane = $self->dimensions->lane_offset;

    return sprintf('M %f %f C %f %f %f %f %f %f M %f %f C %f %f %f %f %f %f',
        # Cross 1
        $START_X, -$lane,
        $P1_X,    -$lane,
        $P2_X,     $lane,
        $END_X,    $lane,
        # Cross 2
        $START_X,  $lane,
        $P1_X,     $lane,
        $P2_X,    -$lane,
        $END_X,   -$lane,
    );
}


before render_grooves => sub {
    my ($self, $track) = @_;

    my $colour = $self->colours->conductor;
    my $width  = $self->dimensions->conductor_width;

    $track->path(
        d              => $self->_path,
        stroke         => $colour,
        'stroke-width' => $width,
        fill           => 'none',
    );
};

after render_grooves => sub {
    my ($self, $track) = @_;

    my $colour = $self->colours->groove;
    my $width  = $self->dimensions->groove_width;

    $track->path(
        d              => $self->_path,
        stroke         => $colour,
        'stroke-width' => $width,
        fill           => 'none',
    );
};


# Put the label at the sensor end, away from
# the crossover
around label_offset => sub {
    return Slotcar::Track::Offset->new(
        x     => 100,
        y     => 0,
        angle => 0,
    );
};

no Moose::Role;
1;
