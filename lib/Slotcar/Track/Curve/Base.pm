package Slotcar::Track::Curve::Base;
use Moose;

extends 'Slotcar::Track::Base';

use Math::Trig;

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

# Reversible parts (curves) will generate an L
# sku and an R sku, curving to the left or right
# from the point-of-view of a car on the circuit.

has '+reversible' => ( default => 1 );

# Units = mm
has radius => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

# Angle in degrees (floating point)
has angle => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

has _sin_half_angle => (
    is          => 'ro',
    isa         => 'Num',
    lazy        => 1,
    default     => sub {
        my $self = shift; 

        # We're going to need sin(θ/2) a few places,
        # so pre-calc it here
        my $half_theta = deg2rad($self->angle / 2.0);
        return sin($half_theta);
    },
);

has _chord_length => (
    is          => 'ro',
    isa         => 'Num',
    lazy        => 1,
    default     => sub {
        my $self = shift; 

        # Length of chord from this origin to next.
        # Store here to save calculating it multiple times.
        # C = 2 * r * sin(θ/2)
        return 2 * $self->radius * $self->_sin_half_angle;
    },
);

# Delta x/y, from origin to where next piece's
# origin should be.
has dx => (
    is          => 'ro',
    isa         => 'Num',
    lazy        => 1,
    default     => sub {
        my $self = shift; 

        # dx is c * cos(θ/2)
        my $half_theta = deg2rad($self->angle / 2.0);
        return $self->_chord_length * cos($half_theta);
    },
);

has dy => (
    is          => 'ro',
    isa         => 'Num',
    lazy        => 1,
    default     => sub {
        my $self = shift; 

        # dy is c * cos(θ/2)
        return $self->_chord_length * $self->_sin_half_angle;
    },
);

override render_base => sub {
    my ($self, $track) = @_;

    # Radius 2 sample dimentions:
    # Outer radius = 370, width = 156
    # Inner radius = 214
    # Outer lane radius = 370-39 = 331
    # Inner lane radius = 331-78 = 253
    my $track_outer_radius = $self->radius + $self->half_width;
    my $track_inner_radius = $self->radius - $self->half_width;
    $track->path(
        d => $self->_curve_to_path($track_outer_radius, $track_inner_radius),
        fill => $self->reversed ? '#553333' : $self->track_base_colour,
        stroke => $self->track_edge_colour,
        'stroke-width' => 2,
    );
};

override render_conductors => sub {
    my ($self, $track) = @_;

    my $groove1_radius = $self->radius - $self->lane_offset;
    my $groove2_radius = $self->radius + $self->lane_offset;

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
    my $theta = deg2rad($self->angle);

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
        x     => $self->dx,
        y     => $self->dy,
        angle => $self->angle,
    );
}

no Moose;
1;
