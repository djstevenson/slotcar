package Slotcar::Track::Part::Role::StartingGrid;
use Moose::Role;

use Readonly;

# Dimensions in mm
Readonly my $X_OFFSET_1           => 156.0;
Readonly my $X_OFFSET_2           =>  96.0;
Readonly my $GRID_LINE_THICKNESS  =>   5.0;
Readonly my $GRID_LINE_TAIL_SIZE  =>  20.0;
Readonly my $GRID_LINE_WIDTH      =>  65.0;
Readonly my $GRID_BLANK_WIDTH     =>  15.0;

after render_paint => sub {
    my ($self, $track) = @_;

    my $dims = $self->dimensions;

    $self->_starting_position($track, $X_OFFSET_1,   $dims->lane_offset);
    $self->_starting_position($track, $X_OFFSET_2, - $dims->lane_offset);
};

# $x = offset from end of track to start of paint line
# $y = width-wise centre of paint line (i.e centre of groove)
sub _starting_position {
    my ($self, $track, $x, $y) = @_;

    my $white_paint = $self->colours->white_paint;

    # Width-wise line that the cars must be behind
    # In two parts as the centre is blank
    $track->rectangle(
        fill   => $white_paint,
        x      => $x,
        y      => $y - ($GRID_LINE_WIDTH / 2.0),
        width  => $GRID_LINE_THICKNESS,
        height => ($GRID_LINE_WIDTH - $GRID_BLANK_WIDTH) / 2.0,
    );

    $track->rectangle(
        fill   => $white_paint,
        x      => $x,
        y      => $y + ($GRID_BLANK_WIDTH / 2.0),
        width  => $GRID_LINE_THICKNESS,
        height => ($GRID_LINE_WIDTH - $GRID_BLANK_WIDTH) / 2.0,
    );

    # Length-wise 'tail' on the right
    $track->rectangle(
        fill   => $white_paint,
        x      => $x - $GRID_LINE_TAIL_SIZE,
        y      => $y - ($GRID_LINE_WIDTH / 2.0),
        width  => $GRID_LINE_TAIL_SIZE,
        height => $GRID_LINE_THICKNESS,
    );


    # Length-wise 'tail' on the left
    $track->rectangle(
        fill   => $white_paint,
        x      => $x - $GRID_LINE_TAIL_SIZE,
        y      => $y + ($GRID_LINE_WIDTH / 2.0) - $GRID_LINE_THICKNESS,
        width  => $GRID_LINE_TAIL_SIZE,
        height => $GRID_LINE_THICKNESS,
    );
}

no Moose::Role;
1;
