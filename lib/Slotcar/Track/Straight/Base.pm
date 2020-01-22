package Slotcar::Track::Straight::Base;
use Moose;

extends 'Slotcar::Track::Base';

use Slotcar::Track::Join::Double;

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

use SVG (-inline => 1);

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

    my $base = $svg->group(
        style => {
            stroke => 'black',
            fill   => 'grey',
        },
    );

    $base->rectangle(
        x => 10,
        y => 10,
        width => $self->length,
        height => $self->width,
    );

    my $groove = $svg->group(
    );
    my $groove_y = $self->joins->{left}->offset_1;
    my $groove_l = $self->length;
    $groove->rectangle(
        style => {
            stroke => 'black',
            fill   => 'lightgrey',
        },
        x => 10,
        y => $groove_y - 5,
        width => $self->length,
        height => 10,
    );

    return $svg->xmlify;
}


no Moose;
1;
