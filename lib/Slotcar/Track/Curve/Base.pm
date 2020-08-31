package Slotcar::Track::Curve::Base;
use Moose;

extends 'Slotcar::Track::Base';

use Math::Trig;

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

# Note - we're going to need to record which way
# around an instance of a curve piece is. Does
# it curve to left or right? Current plan is to have
# two "fake" SKUs, e.g. C8206L and C8206R

# Units = mm
has radius => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

# Angle is the wrong word, find something better.
# It's the portion of a circle, e.g. 22.5˚ is 
# represented as 16 here (360/16). A value of
# 1 would represent a full circle.  Scalextric
# pieces come in 22.5˚, 45˚ and 90˚ (not all
# available at all radii), and there are
# represented as 16, 8, 4 respectively. So the
# angle in radians is 2π/angle

has angle => (
    is          => 'ro',
    isa         => 'Int',
    required    => 1,
);

override render_base => sub {
    my ($self, $track) = @_;

    # Radius 2 sample dimentions:
    # Outer radius = 370, width = 156
    # Inner radius = 214
    # Outer lane radius = 370-39 = 331
    # Inner lane radius = 331-78 = 253

    my $track_outer_radius = $self->radius;
    my $track_inner_radius = $self->radius - $self->width;
    $track->path(
        d => $self->_curve_to_path($track_outer_radius, $track_inner_radius),
        fill => $self->track_base_colour,
        stroke => $self->track_edge_colour,
        'stroke-width' => 2,
    );
};

override render_conductors => sub {
    my ($self, $track) = @_;

    my $track_outer_radius = $self->radius;
    my $groove1_radius = $track_outer_radius - 1 * $self->lane_offset;
    my $groove2_radius = $track_outer_radius - 3 * $self->lane_offset;

    $track->path(
        d => $self->_curve_to_path($groove1_radius + $self->conductor_width / 2.0, $groove1_radius - $self->conductor_width / 2.0),
        fill => $self->conductor_colour,
    );

    $track->path(
        d => $self->_curve_to_path($groove1_radius + $self->groove_width / 2.0, $groove1_radius - $self->groove_width / 2.0),
        fill => $self->groove_colour,
    );

    $track->path(
        d => $self->_curve_to_path($groove2_radius + $self->conductor_width / 2.0, $groove2_radius - $self->conductor_width / 2.0),
        fill => $self->conductor_colour,
    );

    $track->path(
        d => $self->_curve_to_path($groove2_radius + $self->groove_width / 2.0, $groove2_radius - $self->groove_width / 2.0),
        fill => $self->groove_colour,
    );
};

# Helper method for renderers.
#
# Generate SVG path for drawing an arc.
# The arc has a thickness (e.g. drawing
# a curved track is an arc with a 
# thickness - track width - of 156mm).
# $start_y = y of start coordinate (x is 0)
# $outer_radius = radius of outside edge
# $inner_radius = radius of inner edge
sub _curve_to_path {
    my ($self, $outer_radius, $inner_radius) = @_;

    # Angle in degrees
    my $theta = 2 * pi / $self->angle;

    my $thickness = $outer_radius - $inner_radius;

    my $start_y = $self->radius - $outer_radius;

    # x = radius * sin(θ)
    # y = radius * (1 - cos(θ))
    my $s = sin($theta);
    my $c = cos($theta);
    my $outer_end_point_x = $outer_radius * $s;
    my $outer_end_point_y = $outer_radius * (1 - $c);

    # -w * sin(θ), w * cos(θ) - w=thickness
    my $inner_end_delta_x = -$thickness * $s;
    my $inner_end_delta_y = $thickness * $c;

    return sprintf("M 0 %f
        a %f %f 0 0 1 %f %f
        l %f %f
        A %f %f 0 0 0 0 %f
        Z
        ",
        $start_y,
        $outer_radius, $outer_radius,
        $outer_end_point_x, $outer_end_point_y,
        $inner_end_delta_x, $inner_end_delta_y,
        $inner_radius, $inner_radius,
        $start_y + $outer_radius - $inner_radius
    );
}

sub next_piece_offset_builder {
    my ($self) = @_;

    return Slotcar::Track::Offset->new(
        x     => 0,                # Not right TODO
        y     => 0,                # Not right TODO
        angle => $self->angle,
    );
}

no Moose;
1;
