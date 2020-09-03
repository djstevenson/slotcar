package Slotcar::Track::Straight::ARCPowerBase;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Straight::Standard';

# Same as standard straight in terms of size/joins etc.
# Will render differently though as it has the power
# interface and finish line.

has '+sku'         => (default => 'C8435');
has '+description' => (default => 'ARC PRO Power Base');

# The markings on the ARC PRO power base track are kinda:
# |||| ARCPRO |||| in oblique (the actual text is 
# inverted, black on white)
#
# The above symbolism isn't quite centred. There is a 
# checkered "finish line" at the left end (cars
# travelling left to right), and the symbols are
# baseline-centred in what's left after that line.

use Readonly;

override render_markings => sub {
    my ($self, $track) = @_;

    $self->_render_checkered_finish_line($track);
    $self->_render_arc_pro_logo($track);
};

# Parameters for finish line

Readonly my $FINISH_X_OFFSET   =>  6.0;
Readonly my $FINISH_Y_OFFSET1  =>  1.0;
Readonly my $FINISH_Y_OFFSET2  =>  7.0;
Readonly my $FINISH_Y_OFFSET3  =>  7.0;
Readonly my $FINISH_BOX_WIDTH  =>  8.0;
Readonly my $FINISH_BOX_HEIGHT => 16.0;

# Parameters for lap detectors
# Dimensions in mm
Readonly my $LAP_X_OFFSET => 11.0;

# TODO This is used in a few places. DRY it
override render_conductor_mods => sub {
    my ($self, $track) = @_;

    # Real holes at 'left' end
    # (cars travelling from origin end)

    my $x1 = $LAP_X_OFFSET;
    my $x2 = $self->length - $LAP_X_OFFSET;

    # Grooves equidistant either side of centre
    my $groove_y1 = - $self->lane_offset;
    my $groove_y2 =   $self->lane_offset;
    my @sensors = (
        { x => $x1, y => $groove_y1, type => 'active'  },
        { x => $x1, y => $groove_y2, type => 'active'  },
    );

    foreach my $sensor ( @sensors ) {
        $self->render_sensor($track, $sensor);
    }
};


sub _render_checkered_finish_line {
    my ($self, $track) = @_;

    # Grooves at 1/4 and 3/4 width
    my $j1 = 1 * $self->lane_offset;
    my $j2 = 3 * $self->lane_offset;
    my @boxes = (
        { x => $FINISH_X_OFFSET,                     y => $FINISH_Y_OFFSET1                       },
        { x => $FINISH_X_OFFSET + $FINISH_BOX_WIDTH, y => $FINISH_Y_OFFSET1  + $FINISH_BOX_HEIGHT },

        { x => $FINISH_X_OFFSET,                     y => $j1 + $FINISH_Y_OFFSET2                       },
        { x => $FINISH_X_OFFSET + $FINISH_BOX_WIDTH, y => $j1 + $FINISH_Y_OFFSET2  + $FINISH_BOX_HEIGHT },
        { x => $FINISH_X_OFFSET,                     y => $j1 + 2.0*$FINISH_BOX_HEIGHT+$FINISH_Y_OFFSET2                       },
        { x => $FINISH_X_OFFSET + $FINISH_BOX_WIDTH, y => $j1 + 2.0*$FINISH_BOX_HEIGHT+$FINISH_Y_OFFSET2  + $FINISH_BOX_HEIGHT },

        { x => $FINISH_X_OFFSET,                     y => $j2 + $FINISH_Y_OFFSET2                       },
        { x => $FINISH_X_OFFSET + $FINISH_BOX_WIDTH, y => $j2 + $FINISH_Y_OFFSET2  + $FINISH_BOX_HEIGHT },
    );

    foreach my $box (@boxes) {
        $track->rectangle(
            x => $box->{x},
            y => $box->{y},
            width => $FINISH_BOX_WIDTH,
            height => $FINISH_BOX_HEIGHT,
            fill => $self->white_paint,
        );
    }

}

# Paramaters for the 'logo'
Readonly my $OBLIQUE_X_OFFSET =>  8.0;
Readonly my $OBLIQUE_HEIGHT   => 38.0;
Readonly my $STROKE_WIDTH     =>  6.0;
Readonly my $TEXT_X           => 120.0;
Readonly my $TEXT_Y           =>  90.0;
Readonly my $TEXT_FONT        =>  'italic 26px sans-serif';

Readonly my @LINE_OFFSETS     => ( 50.0, 63.0, 76.0, 89.0, 256.0, 269.0, 282.0, 295.0 );

sub _render_arc_pro_logo {
    my ($self, $track) = @_;

    foreach my $offset (@LINE_OFFSETS) {
        $self->_render_oblique_line($track, $offset);
    }

    $track->rectangle(
        x => 125,
        y => 59,
        width => 141,
        height => 38,
        fill => $self->white_paint,
        rx => 10, ry => 10,
        transform => 'skewX(-12)',
    );

    $track->text(
        x => $TEXT_X,
        y => $TEXT_Y,
        style => {
            font => $TEXT_FONT,
            fill => $self->track_base_colour,
        },
        transform => 'rotate(180, 178, 80)',
    )->cdata('ARCPRO');
}

sub _render_oblique_line {
    my ($self, $track, $offset) = @_;

    my $half_w = $OBLIQUE_HEIGHT / 2.0;

    my $y1 = $self->half_width + $half_w;

    $track->path(
        d => sprintf("M %f %f l %f 0 l %f %f l %f 0 Z",
            $offset, $y1,
            $STROKE_WIDTH,
            $OBLIQUE_X_OFFSET, -$OBLIQUE_HEIGHT,
            -$STROKE_WIDTH,
        ),
        fill => $self->white_paint,
    );
}


__PACKAGE__->meta->make_immutable;
1;
