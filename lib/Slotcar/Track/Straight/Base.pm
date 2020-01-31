package Slotcar::Track::Straight::Base;
use Moose;

extends 'Slotcar::Track::Base';

use Slotcar::Track::Join::Double;

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

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

# Probably want to organise this so that we render
# all objects, then $svg_obj->use to add visual
# instances to the SVG doc. Or something.
sub render {
    my $self = shift;
    # Will need args/attrs for position/orientation/etc

    my $svg = $self->svg;
    
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

    # The actual render
    $svg->use(
        x => 0,
        y => 0,
        '-href' => '#standard-straight',
    );
}


no Moose;
1;
