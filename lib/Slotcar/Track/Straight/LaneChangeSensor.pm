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
    # (cars travelling from origin end)

    my $x1 = $X_OFFSET;
    my $x2 = $self->length - $X_OFFSET;
    
    # Grooves at 1/4 and 3/4 width
    my $groove_y1 = 1 * $self->lane_offset;
    my $groove_y2 = 3 * $self->lane_offset;
    my @sensors = (
        { x => $x1, y => $groove_y1, type => 'dummy'  },
        { x => $x1, y => $groove_y2, type => 'dummy'  },
        { x => $x2, y => $groove_y1, type => 'active' },
        { x => $x2, y => $groove_y2, type => 'active' },
    );

    foreach my $sensor ( @sensors ) {
        $self->render_sensor($track, $sensor);
    }
};

__PACKAGE__->meta->make_immutable;
1;
