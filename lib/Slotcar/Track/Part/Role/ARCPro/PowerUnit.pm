package Slotcar::Track::Part::Role::ARCPro::PowerUnit;
use Moose::Role;

use Readonly;

# Parameters for the power unit
Readonly my $BASE_W   => 178.0;
Readonly my $BASE_H   =>  15.0;
Readonly my $TAPER_W  => 126.0;
Readonly my $TAPER_H  =>  87.0;
Readonly my $TAPER_X  => ($BASE_W - $TAPER_W) / 2.0;
Readonly my $BUTTON_Y => 56.0;
Readonly my $BUTTON_W => 15.0;
Readonly my $BUTTON_G =>  3.0;  # Gap between buttons
Readonly my $BUTTON_H =>  4.0;

Readonly my @BUTTON_COLS => (
    '#cc0000',
    '#00cc00',
    '#0000cc',
    '#cccc00',
    '#cc6600',
    '#cccccc',
);

Readonly my $LINE_1_Y =>  15.0;
Readonly my $LINE_X_G =>   1.2;
Readonly my $LINE_Y_G =>   4.0;
Readonly my $LINE_1_W => 164.0;
Readonly my $LINE_H   =>   2.5;
Readonly my $LINE_COL => '#191919';

after render_base => sub {
    my ($self, $track) = @_;

    my $dims = $self->dimensions;
    my $cols = $self->colours;

    my $length = $self->length;

    my $start_x = ($length - $BASE_W)/2.0;
    my $base_path = sprintf('M %f %f l %f 0 l 0 %f l %f 0 Z',
        $start_x, -$dims->half_width,
        $BASE_W,
        -$BASE_H,
        -$BASE_W
    );

    my $start_y = - ($dims->half_width + $BASE_H);
    my $taper_path = sprintf('M %f %f l %f 0 l %f %f l %f 0 Z',
        $start_x, $start_y,
        $BASE_W,
        -$TAPER_X, -$TAPER_H,
        -$TAPER_W
    );
    $track->path(
        d              => $base_path . $taper_path,
        stroke         => $cols->edge,
        'stroke-width' => 2,  # Put this in dims?
        fill           => $cols->base,
    );

    my $x = ($length - 2.5 * $BUTTON_G) / 2.0 - 3.0 * $BUTTON_W;
    my $y = $start_y - $BUTTON_Y; 
    for my $i ( 0 .. 5 ) {
        $track->line(
            x1             => $x,
            y1             => $y,
            x2             => $x + $BUTTON_W,
            y2             => $y,
            stroke         => $BUTTON_COLS[$i],
            'stroke-width' => $BUTTON_H,
        );
        $x += $BUTTON_W + $BUTTON_G;
    }

    $x = ($length - $LINE_1_W) / 2.0;
    $y = $start_y - $LINE_1_Y;
    my $w = $LINE_1_W;
    for my $i ( 0 .. 5 ) {
        $track->line(x1 => $x, y1 => $y, x2 => $x + $w, y2 => $y, stroke => $LINE_COL, 'stroke-width' => $LINE_H);
        $x += $LINE_X_G;
        $y -= $LINE_Y_G;
        $w -= $LINE_X_G * 2.0;
    }
};

no Moose::Role;
1;
