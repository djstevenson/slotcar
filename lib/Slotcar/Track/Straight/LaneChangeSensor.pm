package Slotcar::Track::Straight::LaneChangeSensor;
use Moose;
use namespace::autoclean;

extends 'Slotcar::Track::Straight::Half';

# Sensor that precedes curved lane changers.
# These are 'ended' - one end has holes for sensors
# but there's nothing there. The other end has holes
# WITH censors, and also has 3.5mm sockets for
# electrical connection to lane changer. This end
# much join directly to the lane changer.

has '+sku'         => (default => 'C7000');
has '+description' => (default => 'Lane Change Sensor');

use Readonly;

# Dimensions in mm
Readonly my $X_OFFSET => 46.0;
Readonly my $RADIUS   =>  4.0;

override render_conductor_mods => sub {
    my ($self, $track) = @_;

    # Dummy holes at 'left' end
    # Real sensors at 'right' end
    # (cars travelling left to right)

    my $x1 = $X_OFFSET;
    my $x2 = $self->length - $X_OFFSET;
    my $y1 = $self->joins->{left}->offset_1;
    my $y2 = $self->joins->{left}->offset_2;
    my @holes = (
        { x => $x1, y => $y1, fill => $self->sensor_hole_dummy  },
        { x => $x1, y => $y2, fill => $self->sensor_hole_dummy  },
        { x => $x2, y => $y1, fill => $self->sensor_hole_active },
        { x => $x2, y => $y2, fill => $self->sensor_hole_active },
    );

    foreach my $hole ( @holes ) {
        $track->circle(
            cx => $hole->{x},
            cy => $hole->{y},
            r  => $RADIUS,
            fill => $hole->{fill},
            stroke => $self->track_base_colour,
            'stroke-width' => 0.5,
        );
    }
};

__PACKAGE__->meta->make_immutable;
1;
