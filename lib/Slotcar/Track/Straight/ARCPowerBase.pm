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
# |||[ ARCPRO ]|||
#
# The |[ symbols are oblique. The ARCPRO is without
# spaces, and is set vertically, but black on white, and
# the white background is a rounded-rect that is set
# obliquely.
#
# The above symbolism isn't quite centred. There is a 
# checkered "finish line" at the left end (cars
# travelling left to right), and the symbols are
# baseline-centred in what's left after that line.

use Readonly;

Readonly my $OBLIQUE_X_OFFSET =>  8.0;
Readonly my $OBLIQUE_HEIGHT   => 38.0;
Readonly my $STROKE_WIDTH     =>  6.0;

Readonly my @LINE_OFFSETS     => ( 40.0, 53.0, 66.0, 259.0, 272.0, 285.0 );

override render_markings => sub {
    my ($self, $track) = @_;

    foreach my $offset (@LINE_OFFSETS) {
        $self->_render_oblique_line($track, $offset);
    }
};

sub _render_oblique_line {
    my ($self, $track, $offset) = @_;

    my $half_w = $OBLIQUE_HEIGHT/2.0;

    my $y1 = $self->width/2 + $half_w;

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
