package Slotcar::Track::Part::Role::LaneChanger::Sensors;
use Moose::Role;

with 'Slotcar::Track::Part::Role::Sensors';

sub build_sensors {
    my ($self) = @_;

    return [
        Slotcar::Track::Part::Sensor->new(
            x      => 15.0,
            active => 1,
        ),
    ];
}

no Moose::Role;
1;
