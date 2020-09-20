package Slotcar::Track::Part::Role::Curve;
use Moose::Role;

has radius => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
    builder     => '_build_radius',
);

has angle => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
    builder     => '_build_angle',
);

use Slotcar::Track::Offset;

sub next_piece_offset {
    my ($self) = @_;

    return $self->_offset_for_angle($self->angle);
}

sub _offset_for_angle {
    my ($self, $angle) = @_;

    my $half_angle     = $angle / 2.0;
    my $sin_half_angle = sin($half_angle);
    my $chord_length   = 2 * $self->radius * $sin_half_angle;

    my $dx = $chord_length * cos($half_angle);
    my $dy = $chord_length * $sin_half_angle;

    return Slotcar::Track::Offset->new(
        x     => $dx,
        y     => $dy,
        angle => $angle,
    );
}

# Angle not used
sub label_offset {
    my ($self) = @_;

    # Pick point half-way round centre line
    return $self->_offset_for_angle($self->angle / 2.0);
}

after render_base => sub {
    my ($self, $track) = @_;

    my $cols = $self->colours;
    my $dims = $self->dimensions;

    my $path = $self->_curve_path({
        angle  => $self->angle,
        radius => $self->radius,
        width  => $dims->width,
    });
    $track->path(
        d    => $path,
        fill => $cols->track_base,
    );
};

after render_grooves => sub {
    my ($self, $track) = @_;

    my $dims = $self->dimensions;

    $self->_render_single_groove($track, $dims->lane_offset);
    $self->_render_single_groove($track, -$dims->lane_offset);
};

sub _render_single_groove {
    my ($self, $track, $offset) = @_;

    my $cols = $self->colours;
    my $dims = $self->dimensions;

    my $path1 = $self->_curve_path({
        angle   => $self->angle,
        radius  => $self->radius + $offset,
        width   => $dims->conductor_width,
        start_y => -$offset,
    });
    my $path2 = $self->_curve_path({
        angle  => $self->angle,
        radius => $self->radius + $offset,
        width  => $dims->groove_width,
        start_y => -$offset,
    });
    $track->path(
        d    => $path1,
        fill => $cols->conductor,
    );
    $track->path(
        d    => $path2,
        fill => $cols->groove,
    );
}

sub _curve_path {
    my ($self, $d) = @_;

    my $angle   = $d->{angle};
    my $radius  = $d->{radius};
    my $width   = $d->{width};
    my $start_x = $d->{start_x} // 0;
    my $start_y = $d->{start_y} // 0;

    my $s = sin($angle);
    my $c = cos($angle);

    my $half_width = $width / 2.0;
    my $outer_radius = $radius + $half_width;
    my $inner_radius = $radius - $half_width;

    my $outer_end_point_x = $outer_radius * $s;
    my $outer_end_point_y = $outer_radius * (1 - $c);
    my $inner_end_point_x = $inner_radius * $s;
    my $inner_end_point_y = $inner_radius * (1 - $c);

    # -w * sin(θ), w * cos(θ) - w=width
    my $inner_end_delta_x = -$width * $s;
    my $inner_end_delta_y =  $width * $c;

    $start_y -= $half_width;  # Cos origin is in centre
    return sprintf("M %f %f
        a %f %f 0 0 1 %f %f
        l %f %f
        A %f %f 0 0 0 0 %f
        Z
        ",
        $start_x,
        $start_y,
        $outer_radius, $outer_radius,
        $outer_end_point_x, $outer_end_point_y,
        $inner_end_delta_x, $inner_end_delta_y,
        $inner_radius, $inner_radius,
        $start_y + $outer_radius - $inner_radius
    );
}

after render_border => sub {
    my ($self, $track) = @_;

    my $cols = $self->colours;
    my $dims = $self->dimensions;

    my $path = $self->_curve_path({
        angle  => $self->angle,
        radius => $self->radius,
        width  => $dims->width,
    });
    $track->path(
        d              => $path,
        stroke         => $cols->edge,
        'stroke-width' => 2,
        fill           => 'none',
    );
};

no Moose::Role;
1;
