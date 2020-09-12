package Slotcar::Track::Part::Role::LaneChanger::FakeCrossover;
use Moose::Role;

use Readonly;

# Temporary measure, render the crossover as paint
# markings. Doing the real render is hard! Do that later,
# there are more important things to work on right now

Readonly my $CROSS_CENTRE_X   => 340.0;
Readonly my $CROSS_WIDTH      =>  60.0;
Readonly my $CROSS_LENGTH     => 310.0;
Readonly my $CROSS_LINE_WIDTH =>  16.0;

after render_paint => sub {
    my ($self, $track) = @_;

    my $cols = $self->colours;
    my $dims = $self->dimensions;

    my $start_x  = $CROSS_CENTRE_X - $CROSS_LENGTH / 2.0 - $CROSS_LINE_WIDTH / 2.0;
    my $start_y1 = - $CROSS_WIDTH / 2.0;
    my $start_y2 = $CROSS_WIDTH / 2.0;

    my $path = sprintf('M %f %f l %f 0 l %f %f l %f 0 Z',
        $start_x, $start_y1,
        $CROSS_LINE_WIDTH,
        $CROSS_LENGTH, $CROSS_WIDTH,
        -$CROSS_LINE_WIDTH,
    );

    $path .= sprintf('M %f %f l %f 0 l %f %f l %f 0 Z',
        $start_x, $start_y2,
        $CROSS_LINE_WIDTH,
        $CROSS_LENGTH, -$CROSS_WIDTH,
        -$CROSS_LINE_WIDTH,
    );

    $track->path(
        d => $path,
        fill => $cols->white_paint,
    );

};


no Moose::Role;
1;
