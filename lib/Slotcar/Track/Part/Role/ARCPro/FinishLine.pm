package Slotcar::Track::Part::Role::ARCPro::FinishLine;
use Moose::Role;

use Readonly;

after render_paint => sub {
    my ($self, $track) = @_;

    my $dims = $self->dimensions;

    $self->_render_checkered_finish_line($track);
};

# Parameters for finish line

Readonly my $FINISH_X_OFFSET   =>  6.0;
Readonly my $FINISH_Y_MARGIN   =>  1.0;
Readonly my $FINISH_Y_MARGIN2  =>  2.0;
Readonly my $FINISH_LINE_WIDTH =>  1.0;
Readonly my $FINISH_BOX_WIDTH  =>  8.0;
Readonly my $FINISH_BOX_HEIGHT => 15.75;

sub _render_checkered_finish_line {
    my ($self, $track) = @_;

    my $dims = $self->dimensions;
    my $white_paint = $self->colours->white_paint;

    # Finish line markings are not mirrored about the centre
    # x
    #  x
    # ======
    # x
    #  x
    # x
    #  x
    # ======
    # x
    #  x

    # Left edge Y
    my $left_track_edge = -$dims->half_width + $FINISH_Y_MARGIN;

    # Centre secion Y
    my $left_conductor_inner = -$dims->lane_offset + $dims->conductor_offset + $FINISH_Y_MARGIN2;

    # Right edge Y
    my $right_track_edge = - $left_track_edge;

    my $x1 = $FINISH_X_OFFSET;
    my $x2 = $x1 + $FINISH_BOX_WIDTH;
    my $y1 = $left_track_edge;
    my $y2 = $y1 + $FINISH_BOX_HEIGHT;

    my $y3 = $left_conductor_inner;
    my $y4 = $y3 + $FINISH_BOX_HEIGHT;
    my $y5 = $y4 + $FINISH_BOX_HEIGHT;
    my $y6 = $y5 + $FINISH_BOX_HEIGHT;

    my $y7 = $right_track_edge - 2 * $FINISH_BOX_HEIGHT;
    my $y8 = $y7 + $FINISH_BOX_HEIGHT;

    # TOP TWO BOXES (LEFT OUTER)
    $self->_box($track, $x1, $y1, $white_paint);
    $self->_box($track, $x2, $y2, $white_paint);

    # MIDDLE FOUR BOXES
    $self->_box($track, $x1, $y3, $white_paint);
    $self->_box($track, $x2, $y4, $white_paint);
    $self->_box($track, $x1, $y5, $white_paint);
    $self->_box($track, $x2, $y6, $white_paint);

    # BOTTOM TWO BOXES (RIGHT OUTER)
    $self->_box($track, $x1, $y7, $white_paint);
    $self->_box($track, $x2, $y8, $white_paint);

}

sub _box {
    my ($self, $track, $x, $y, $p) = @_;

    $track->rectangle(
        x      => $x,
        y      => $y,
        width  => $FINISH_BOX_WIDTH,
        height => $FINISH_BOX_HEIGHT,
        fill   => $p,
    );
}

no Moose::Role;
1;
