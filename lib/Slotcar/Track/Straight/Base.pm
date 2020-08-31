package Slotcar::Track::Straight::Base;
use Moose;

extends 'Slotcar::Track::Base';

use Slotcar::Track::Offset;

# Override this to set a length
# e.g. has '+length' => (default => 350);
has length => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

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

    # Grooves at 1/4 and 3/4 width
    my $groove_y1 = 1 * $self->lane_offset;
    my $groove_y2 = 3 * $self->lane_offset;

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

sub next_piece_offset_builder {
    my ($self) = @_;

    return Slotcar::Track::Offset->new(
        x     => $self->length,
        y     => 0,
        angle => 0,
    );
}

no Moose;
1;
