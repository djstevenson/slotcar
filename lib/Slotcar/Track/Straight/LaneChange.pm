package Slotcar::Track::Straight::LaneChange;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Straight::Base';

use Math::Trig;

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

has '+length'      => (default => 525);
has '+sku'         => (default => 'C7036');
has '+description' => (default => 'Straight Lane Change');

use Readonly;

# Temporary measure, render the crossover as paint
# markings. Doing the real render is hard! There
# are more important things to work on right
# now, such as connecting pieces together.

Readonly my $CROSS_CENTRE_X   => 340.0;
Readonly my $CROSS_WIDTH      =>  60.0;
Readonly my $CROSS_LENGTH     => 310.0;
Readonly my $CROSS_LINE_WIDTH =>  16.0;

override render_markings => sub {
    my ($self, $track) = @_;

    my $start_x = $CROSS_CENTRE_X - $CROSS_LENGTH / 2.0 - $CROSS_LINE_WIDTH / 2.0;
    my $start_y1 = ($self->width - $CROSS_WIDTH) / 2.0;
    my $start_y2 = ($self->width + $CROSS_WIDTH) / 2.0;

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
        fill => $self->white_paint,
    );
};

__PACKAGE__->meta->make_immutable;
1;
