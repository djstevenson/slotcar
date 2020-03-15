package Slotcar::Track::Straight::LaneChange;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Straight::Base';

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

has '+length'      => ( default => 525);
has '+sku'         => (default => 'C7036');
has '+description' => (default => 'Straight Lane Change');

use Readonly;
Readonly my $INNER_GROOVE_LONG_STRAIGHT => 156.0;

override render_conductors => sub {
    my ($self, $track) = @_;

    my $groove_y1 = $self->joins->{left}->offset_1;
    my $groove_y2 = $self->joins->{left}->offset_2;
    my $groove_l = $self->length;

    # Groove 1/2 are the outer conductors and slots
    my $groove_1 = $track->group;
    # Conductors
    $groove_1->rectangle(
        fill => $self->conductor_colour,
        x => 0,
        y => $groove_y1 - $self->conductor_width/2.0,
        width => $self->length,
        height => $self->conductor_width / 2.0,
    );
    # Slot
    $groove_1->rectangle(
        fill => $self->groove_colour,
        x => 0,
        y => $groove_y1 - $self->groove_width/2.0,
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
        y => $groove_y2 - $self->groove_width/2.0,
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
        y => $groove_y2 - $self->conductor_width/2.0,
        width => $INNER_GROOVE_LONG_STRAIGHT,
        height => ($self->conductor_width - $self->groove_width) / 2.0,
    );

};

__PACKAGE__->meta->make_immutable;
1;
