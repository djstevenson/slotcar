package Slotcar::Track::Straight::Base;
use Moose;

extends 'Slotcar::Track::Base';

use Slotcar::Track::Join::Double;

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

use SVG (-inline => 1, -nocredits => 1);

has '+lanes' => ( default => 2);
has '+width' => ( default => 156);

# Override this to set a length
# e.g. has '+length' => (default => 350);
has length => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);


override define_joins => sub {
    my $self = shift;

    return {
        left  => Slotcar::Track::Join::Double->new,
        right => Slotcar::Track::Join::Double->new(
            offset_x    => $self->length,
            offset_y    => $self->width,
            is_inverted => 1,
        ),
    };
};

sub render {
    my $self = shift;
    # Will need args/attrs for position/orientation/etc

    # Render to SVG at top-left = 10,10.  Units are mm

    my $svg = SVG->new(
        width  => 1_000,
        height => 1_000,
    );

    my $defs = $svg->defs(id => 'defs');
    my $standard = $defs->group(id => 'standard-straight');

    $standard->rectangle(
        fill => $self->track_base_colour,
        stroke => $self->track_edge_colour,
        'stroke-width' => 2,
        x => 0,
        y => 0,
        width => $self->length,
        height => $self->width,
    );

    my $groove_y1 = $self->joins->{left}->offset_1;
    my $groove_y2 = $self->joins->{left}->offset_2;
    my $groove_l = $self->length;

    my $groove_1 = $standard->group;
    # Conductors
    $groove_1->rectangle(
        fill => $self->conductor_colour,
        x => 0,
        y => $groove_y1 - 5,
        width => $self->length,
        height => 10,
    );
    # Slot
    $groove_1->rectangle(
        fill => $self->groove_colour,
        x => 0,
        y => $groove_y1 - 1.5,
        width => $self->length,
        height => 3,
    );

    my $groove_2 = $standard->group;
    # Conductors
    $groove_2->rectangle(
        fill => $self->conductor_colour,
        x => 0,
        y => $groove_y2 - 5,
        width => $self->length,
        height => 10,
    );
    # Slot
    $groove_2->rectangle(
        fill  => $self->groove_colour,
        x => 0,
        y => $groove_y2 - 1.5,
        width => $self->length,
        height => 3,
    );

    # Temporarily render four times, to test rendering
    # an object multiple times from a single definition
    $svg->use(
        x => 0,
        y => 0,
        '-href' => '#standard-straight',
    );
    $svg->use(
        x => 350,
        y => 0,
        '-href' => '#standard-straight',
    );
    $svg->use(
        x => 0,
        y => 156,
        '-href' => '#standard-straight',
    );
    $svg->use(
        x => 350,
        y => 156,
        '-href' => '#standard-straight',
    );
    return $svg->xmlify;
}


no Moose;
1;
