package Slotcar::Track::Part::Role::Curve;
use Moose::Role;

use Math::Trig;

# Common code/attributes for the CurveL and CurveR roles

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

has reversed => (
    is          => 'ro',
    isa         => 'Bool',
    lazy        => 1,
    builder     => '_is_reversed',
);

requires '_is_reversed';



use Slotcar::Track::Offset;

# TODO Should be a lazy attribute not a sub, so we don't recalc every time
sub next_piece_offset {
    my ($self) = @_;

    return $self->_offset_for_angle($self->angle);
}

sub _offset_for_angle {
    my ($self, $angle) = @_;

    my $factor = $self->reversed ? -1 : 1;

    my $half_angle     = $angle / 2.0;
    my $sin_half_angle = sin($half_angle);
    my $chord_length   = 2 * $self->radius * $sin_half_angle;

    my $dx = $chord_length * cos($half_angle);
    my $dy = $chord_length * $sin_half_angle;

    return Slotcar::Track::Offset->new(
        x     => $dx,
        y     => $factor * $dy,
        angle => $factor * $angle,
    );
}

# Angle not used
sub label_offset {
    my ($self) = @_;

    # Pick point half-way round centre line
    return $self->_offset_for_angle($self->angle / 2.0);
}

sub _polar_to_cartesian {
    my ($self, $centre_x, $centre_y, $radius, $angle, $width) = @_;   # Angles in radians

    my $x = $centre_x + $radius * cos($angle);
    my $y = $centre_y + $radius * sin($angle);

    return ($x, $y - $self->radius + $width);
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

sub _curve_path {
    my ($self, $d) = @_;

    my $angle   = $d->{angle};
    my $radius  = $d->{radius};
    my $width   = $d->{width};

    my $half_width   = $width / 2.0;
    my $outer_radius = $radius + $half_width;
    my $inner_radius = $radius - $half_width;

    my $cx = 0;
    my $cy = - $width;

    my ($in_s_x,  $in_s_y)  = $self->_polar_to_cartesian(0, $cy, $inner_radius, deg2rad(90), $width);
    my ($in_e_x,  $in_e_y)  = $self->_polar_to_cartesian(0, $cy, $inner_radius, deg2rad(90) - $angle, $width);
    my ($out_s_x, $out_s_y) = $self->_polar_to_cartesian(0, $cy, $outer_radius, deg2rad(90) - $angle, $width);
    my ($out_e_x, $out_e_y) = $self->_polar_to_cartesian(0, $cy, $outer_radius, deg2rad(90), $width);

    return sprintf("M %f %f
        A %f %f 0 0 0 %f %f
        L %f %f
        A %f %f 0 0 1 %f %f
        Z
        ",
        $in_s_x, $in_s_y,
        $inner_radius, $inner_radius,
        $in_e_x, $in_e_y,
        $out_s_x, $out_s_y,
        $outer_radius, $outer_radius,
        $out_e_x, $out_e_y
    );
}

sub _render_single_groove {
    my ($self, $track, $offset) = @_;

    my $cols = $self->colours;
    my $dims = $self->dimensions;

    my $path1 = $self->_curve_path({
        angle   => $self->angle,
        radius  => $self->radius + $offset,
        width   => $dims->conductor_width,
    });
    my $path2 = $self->_curve_path({
        angle  => $self->angle,
        radius => $self->radius + $offset,
        width  => $dims->groove_width,
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
# after render_border => sub {
#     my ($self, $track) = @_;

#     my $cols = $self->colours;
#     my $dims = $self->dimensions;

#     my $path = $self->_curve_path({
#         angle  => $self->angle,
#         radius => $self->radius,
#         width  => $dims->width,
#     });
#     $track->path(
#         d              => $path,
#         stroke         => $cols->edge,
#         'stroke-width' => 2,
#         fill           => 'none',
#     );
# };

no Moose::Role;
1;
