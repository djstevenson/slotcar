package Slotcar::Track::Straight::StartingGrid;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Straight::Half';

# Same dimensions has half-straight, but will
# render different

has '+sku'         => (default => 'C7018');
has '+description' => (default => 'Starting Grid Straight');

use Readonly;

# Dimensions in mm
Readonly my $X_OFFSET_1           => 15.0;
Readonly my $X_OFFSET_2           => 75.0;
Readonly my $GRID_LINE_THICKNESS  =>  5.0;
Readonly my $GRID_LINE_TAIL_SIZE  => 20.0;
Readonly my $GRID_LINE_WIDTH      => 65.0;
Readonly my $GRID_BLANK_WIDTH     => 15.0;

override render_markings => sub {
    my ($self, $track) = @_;

    super();

    # $self->_starting_position($track, $X_OFFSET_1,  $self->joins->{left}->offset_1);
    # $self->_starting_position($track, $X_OFFSET_2,  $self->joins->{left}->offset_2);
};

# $x = offset from end of track to start of paint line
# $y = width-wise centre of paint line (i.e centre of groove)
sub _starting_position {
    my ($self, $track, $x, $y) = @_;

    # Width-wise line that the cars must be behind
    # In two parts as the centre is blank
    $track->rectangle(
        fill   => $self->white_paint,
        x      => $x,
        y      => $y - ($GRID_LINE_WIDTH / 2.0),
        width  => $GRID_LINE_THICKNESS,
        height => ($GRID_LINE_WIDTH - $GRID_BLANK_WIDTH) / 2.0,
    );

    $track->rectangle(
        fill   => $self->white_paint,
        x      => $x,
        y      => $y + ($GRID_BLANK_WIDTH / 2.0),
        width  => $GRID_LINE_THICKNESS,
        height => ($GRID_LINE_WIDTH - $GRID_BLANK_WIDTH) / 2.0,
    );

    # Length-wise 'tail' on the right
    $track->rectangle(
        fill   => $self->white_paint,
        x      => $x,
        y      => $y - ($GRID_LINE_WIDTH / 2.0),
        width  => $GRID_LINE_TAIL_SIZE,
        height => $GRID_LINE_THICKNESS,
    );


    # Length-wise 'tail' on the left
    $track->rectangle(
        fill   => $self->white_paint,
        x      => $x,
        y      => $y + ($GRID_LINE_WIDTH / 2.0) - $GRID_LINE_THICKNESS,
        width  => $GRID_LINE_TAIL_SIZE,
        height => $GRID_LINE_THICKNESS,
    );
}

__PACKAGE__->meta->make_immutable;
1;
