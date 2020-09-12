package Slotcar::Track::Part::Role::LaneChangeSensor;
use Moose::Role;

with 'Slotcar::Track::Part::Role::Sensors';

sub build_sensors {
    my ($self) = @_;

    return [
        Slotcar::Track::Part::Sensor->new(
            x      => 46.0,
            active => 0,
        ),
        Slotcar::Track::Part::Sensor->new(
            x      => 129.0,
            active => 1,
        ),
    ];
}

no Moose::Role;
1;
