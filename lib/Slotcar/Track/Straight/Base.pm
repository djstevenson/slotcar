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

override render_base => sub {
    my ($self, $track) = @_;

    $track->rectangle(
        fill => $self->track_base_colour,
        stroke => $self->track_edge_colour,
        'stroke-width' => 2,
        x => 0,
        y => 0,
        width => $self->length,
        height => $self->width,
    );
};

override render_conductors => sub {
    my ($self, $track) = @_;

    my $groove_y1 = $self->joins->{left}->offset_1;
    my $groove_y2 = $self->joins->{left}->offset_2;
    my $groove_l = $self->length;

    my $groove_1 = $track->group;
    # Conductors
    $groove_1->rectangle(
        fill => $self->conductor_colour,
        x => 0,
        y => $groove_y1 - $self->conductor_width / 2.0,
        width => $self->length,
        height => $self->conductor_width,
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
        y => $groove_y2 - $self->conductor_width / 2.0,
        width => $self->length,
        height => $self->conductor_width,
    );
    # Slot
    $groove_2->rectangle(
        fill  => $self->groove_colour,
        x => 0,
        y => $groove_y2 - $self->groove_width / 2.0,
        width => $self->length,
        height => $self->groove_width,
    );
};


no Moose;
1;
