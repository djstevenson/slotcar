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

override render_def => sub {
    my ($self, $defs) = @_;

    my $svg = $self->svg;
    
    my $track = $defs->group(id => $self->sku);

    $track->rectangle(
        fill => $self->track_base_colour,
        stroke => $self->track_edge_colour,
        'stroke-width' => 2,
        x => 0,
        y => 0,
        width => $self->length,
        height => $self->width,
    );

    # Add any track base paint markings
    $self->render_markings($track);

    my $groove_y1 = $self->joins->{left}->offset_1;
    my $groove_y2 = $self->joins->{left}->offset_2;
    my $groove_l = $self->length;

    my $groove_1 = $track->group;
    # Conductors
    $groove_1->rectangle(
        fill => $self->conductor_colour,
        x => 0,
        y => $groove_y1 - 5.5,
        width => $self->length,
        height => 10,
    );
    # Slot
    $groove_1->rectangle(
        fill => $self->groove_colour,
        x => 0,
        y => $groove_y1 - 2,
        width => $self->length,
        height => 3,
    );

    my $groove_2 = $track->group;
    # Conductors
    $groove_2->rectangle(
        fill => $self->conductor_colour,
        x => 0,
        y => $groove_y2 - 5.5,
        width => $self->length,
        height => 10,
    );
    # Slot
    $groove_2->rectangle(
        fill  => $self->groove_colour,
        x => 0,
        y => $groove_y2 - 2,
        width => $self->length,
        height => 3,
    );

    # Add anything that renders over conductors,
    # e.g. detector holes
    $self->render_conductor_mods($track);
};

# Render markings - paint applied to the road
# plasic that does NOT appear over the 
# conductors/slots.  Default is to paint
# nothing, override it if required.
# 
sub render_markings {
    # my ($self, $track) = @_;
}

# Render things that go 'over' the conductors,
# is things that should be rendered AFTER the
# conductor/groove. Example is the hole for
# the car detectors.
# 
sub render_conductor_mods {
    # my ($self, $track) = @_;
}

no Moose;
1;
