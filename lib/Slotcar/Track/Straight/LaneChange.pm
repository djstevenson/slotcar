package Slotcar::Track::Straight::LaneChange;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Straight::Base';

use utf8;

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

has '+length'      => ( default => 525);
has '+sku'         => (default => 'C7036');
has '+description' => (default => 'Straight Lane Change');

use Readonly;
Readonly my $INNER_GROOVE_LONG_STRAIGHT   => 156.0;
Readonly my $INNER_GROOVE_CURVE1_RADIUS   => 448.0;
Readonly my $INNER_GROOVE_CURVE1_ANGLE    => 360.0/26.0;    # 26˚

Readonly my $INNER_GROOVE_MIDDLE_STRAIGHT => 140.0;

# Flipper
Readonly my $FLIPPER_X                    => 223.0;
Readonly my $FLIPPER_LENGTH               => 104.0;
Readonly my $FLIPPER_HEIGHT               =>  14.0;
Readonly my $FLIPPER_END_RADIUS_X         =>  14.0;
Readonly my $FLIPPER_END_RADIUS_Y         =>  21.0;
Readonly my $FLIPPER_SIDE_RADIUS          => 458.0;
Readonly my $FLIPPER_ARC_ANGLE            =>   0.14; # 8˚
Readonly my $FLIPPER_ARC_X                => $FLIPPER_END_RADIUS_X * sin($FLIPPER_ARC_ANGLE);
Readonly my $FLIPPER_ARC_Y                => $FLIPPER_END_RADIUS_X * cos($FLIPPER_ARC_ANGLE);

print STDERR "x=$FLIPPER_ARC_X y=$FLIPPER_ARC_Y\n";

override render_conductors => sub {
    my ($self, $track) = @_;

    my $groove_y1 = $self->joins->{left}->offset_1;
    my $groove_y2 = $self->joins->{left}->offset_2;

    # Groove 1/2 are the outer conductors and slots
    my $groove_1 = $track->group;
    # Conductors
    $groove_1->rectangle(
        fill => $self->conductor_colour,
        x => 0,
        y => $groove_y1 - $self->conductor_width / 2.0,
        width => $self->length,
        height => $self->conductor_width / 2.0,
    );
    # Slot
    $groove_1->rectangle(
        fill => $self->groove_colour,
        x => 0,
        y => $groove_y1 - $self->groove_width / 2.0,
        width => $self->length,
        height => $self->groove_width,
    );

    my $groove_2 = $track->group;
    # Conductors
    $groove_2->rectangle(
        fill => $self->conductor_colour,
        x => 0,
        y => $groove_y2,
        width => $self->length,
        height => $self->conductor_width / 2.0,
    );
    # Slot
    $groove_2->rectangle(
        fill  => $self->groove_colour,
        x => 0,
        y => $groove_y2 - $self->groove_width / 2.0,
        width => $self->length,
        height => $self->groove_width,
    );

    # The long inner conductors, starting at the
    # sensor end.
    # Go straight for 156mm, then curve downwards at
    # radius 448mm (estimated, I don't have the 
    # actual dimension).
    my $groove_3 = $track->group;
    $groove_3->rectangle(
        fill => $self->conductor_colour,
        x => 0,
        y => $groove_y1 + $self->groove_width / 2.0,
        width => $INNER_GROOVE_LONG_STRAIGHT,
        height => ($self->conductor_width - $self->groove_width) / 2.0,
    );
    $groove_3->rectangle(
        fill => $self->conductor_colour,
        x => $FLIPPER_X + $FLIPPER_LENGTH + 4.0,
        y => $groove_y1 + $self->groove_width / 2.0,
        width => $INNER_GROOVE_MIDDLE_STRAIGHT,
        height => ($self->conductor_width - $self->groove_width) / 2.0,
    );
    # $groove_3->path(
    #     d => $self->_curve_to_path($INNER_GROOVE_CURVE1_RADIUS + $self->groove_width / 2.0, $INNER_GROOVE_CURVE1_RADIUS - $self->groove_width / 2.0, $INNER_GROOVE_CURVE1_ANGLE),
    #     fill => $self->conductor_colour,
    # );


    # Lane 1 flipper
    $groove_3->path(
        d => $self->flipper_path($groove_y1),
        fill => $self->conductor_colour,
    );

};

sub flipper_path {
    my ($self, $groove_y) = @_;

    my $y = $groove_y + $self->groove_width / 2.0;

    my $straight_edge = sprintf('M %f %f l %f 0',
        $FLIPPER_X, $y, 
        $FLIPPER_LENGTH,
    );

    my $end_curve = sprintf('a %f %f 0 0 1 %f %f',
        $FLIPPER_END_RADIUS_X, $FLIPPER_END_RADIUS_Y,
        -$FLIPPER_ARC_X, $FLIPPER_ARC_Y,
    );

    my $side_curve = sprintf('A %f %f 0 0 0 %f %f',
        $FLIPPER_SIDE_RADIUS, $FLIPPER_SIDE_RADIUS,
        $FLIPPER_X, $y,
    );
    return join(' ', $straight_edge, $end_curve, $side_curve, 'Z');
}

__PACKAGE__->meta->make_immutable;
1;
