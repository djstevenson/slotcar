package Slotcar::Track::Part::Role::Sensors;
use Moose::Role;

use Slotcar::Track::Part::Sensor;

has sensors => (
    traits      => ['Array'],
    is          => 'ro',
    isa         => 'ArrayRef[Slotcar::Track::Part::Sensor]',
    lazy        => 1,
    builder     => 'build_sensors',
    handles     => {
        all_sensors => 'elements',
    }
);

requires 'build_sensors';

after render_sensors => sub {
    my ($self, $track) = @_;

    for my $sensor ($self->all_sensors) {
        $self->_render_sensor_pair($track, $sensor);
    }
};


sub _render_sensor_pair {
    my ($self, $track, $sensor) = @_;

    my $dims = $self->dimensions;

    $self->_render_sensor_single($track, $sensor, -$dims->lane_offset);
    $self->_render_sensor_single($track, $sensor,  $dims->lane_offset);

}
sub _render_sensor_single {
    my ($self, $track, $sensor, $y) = @_;

    my $dims = $self->dimensions;
    my $cols = $self->colours;

    $track->circle(
        cx             => $sensor->x,
        cy             => $y,
        r              => $dims->sensor_radius,
        fill           => $sensor->active ? $cols->sensor_active : $cols->sensor_inactive,
        stroke         => $cols->edge,
        'stroke-width' => 1.0,
    ); 
}

no Moose::Role;
1;
