package Slotcar::Track::Part::Role::ARCPro::Logo;
use Moose::Role;

use Readonly;

# Paramaters for the 'logo'
Readonly my $OBLIQUE_X_OFFSET =>  8.0;
Readonly my $OBLIQUE_HEIGHT   => 38.0;
Readonly my $STROKE_WIDTH     =>  6.0;
Readonly my $TEXT_X           => 120.0;
Readonly my $TEXT_Y           => 170.0;
Readonly my $TEXT_FONT        => 'italic 26px sans-serif';

Readonly my @LINE_OFFSETS     => ( 50.0, 63.0, 76.0, 89.0, 256.0, 269.0, 282.0, 295.0 );


after render_paint => sub {
    my ($self, $track) = @_;

    my $cols        = $self->colours;

    foreach my $offset (@LINE_OFFSETS) {
        $self->_render_oblique_line($track, $offset);
    }

    # TODO Why isn't this driven from the same params as the txt?
    $track->rectangle (
        x         => 109,
        y         => -19,
        width     => 141,
        height    => 38,
        fill      => $cols->white_paint,
        rx        => 10,
        ry        => 10,
        transform => 'skewX(-12)',
    );

    $track->text(
        x => $TEXT_X,
        y => $TEXT_Y,
        style => {
            font => $TEXT_FONT,
            fill => $cols->base,
        },
        transform => 'rotate(180, 178, 80)',  # Param this?
    )->cdata('ARCPRO');
};

sub _render_oblique_line {
    my ($self, $track, $offset) = @_;

    my $half_w = $OBLIQUE_HEIGHT / 2.0;

    $track->path(
        d => sprintf("M %f %f l %f 0 l %f %f l %f 0 Z",
            $offset, $half_w,
            $STROKE_WIDTH,
            $OBLIQUE_X_OFFSET, -$OBLIQUE_HEIGHT,
            -$STROKE_WIDTH,
        ),
        fill => $self->colours->white_paint,
    );
}


# Put the label to the side, away from
# the logo
around label_offset => sub {
    return Slotcar::Track::Offset->new(
        x     => 175,
        y     => -60,
        angle => 0,
    );
};

no Moose::Role;
1;
