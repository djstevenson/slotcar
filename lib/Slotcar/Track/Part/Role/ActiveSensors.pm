package Slotcar::Track::Part::Role::ActiveSensors;
use Moose::Role;

use Readonly;

Readonly my $SENSOR_X_OFFSET => 11.0;

after render_sensors => sub {
    my ($self, $track) = @_;

    my $dims = $self->dimensions;

    $self->_render_sensor($track, -$dims->lane_offset);
    $self->_render_sensor($track,  $dims->lane_offset);
};

sub _render_sensor {
    my ($self, $track, $y) = @_;

    my $dims = $self->dimensions;
    my $cols = $self->colours;

    $track->circle(
        cx             => $SENSOR_X_OFFSET,
        cy             => $y,
        r              => $dims->sensor_radius,
        fill           => $cols->sensor_active,
        stroke         => $cols->edge,
        'stroke-width' => 1.0,
    ); 
}

no Moose::Role;
1;
