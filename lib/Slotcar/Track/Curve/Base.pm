package Slotcar::Track::Curve::Base;
use Moose;

extends 'Slotcar::Track::Base';

use Slotcar::Track::Join::Double;

use Math::Trig;

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

# Note - we're going to need to record which way
# around an instance of a curve piece is. Does
# it curve to left or right?

has '+lanes' => ( default => 2);
has '+width' => ( default => 156);

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

override define_joins => sub {
    my $self = shift;

    die 'Implement joins for curved pieces';

    # return {
    #     left  => Slotcar::Track::Join::Double->new,
    #     right => Slotcar::Track::Join::Double->new(
    #         offset_x    => $self->length,
    #         offset_y    => $self->width,
    #         is_inverted => 1,
    #     ),
    # };
};

sub render_def {
    my ($self, $defs) = @_;

    my $svg = $self->svg;
    
    my $track = $defs->group(id => $self->sku);

    # Radius 2 sample dimentions:
    # Outer radius = 370, width = 156
    # Inner radius = 214
    # Outer lane radius = 370-39 = 331
    # Inner lane radius = 331-78 = 253

    $track->path(
        d => $self->_curve_to_path(370, 214),
        fill => $self->track_base_colour,
        stroke => $self->track_edge_colour,
        'stroke-width' => 2,
    );

    # my $groove_y1 = $self->joins->{left}->offset_1;
    # my $groove_y2 = $self->joins->{left}->offset_2;
    # my $groove_l = $self->length;

    # my $groove_1 = $track->group;
    # # Conductors
    # $groove_1->rectangle(
    #     fill => $self->conductor_colour,
    #     x => 0,
    #     y => $groove_y1 - 5,
    #     width => $self->length,
    #     height => 10,
    # );
    # # Slot
    # $groove_1->rectangle(
    #     fill => $self->groove_colour,
    #     x => 0,
    #     y => $groove_y1 - 1.5,
    #     width => $self->length,
    #     height => 3,
    # );

    # my $groove_2 = $track->group;
    # # Conductors
    # $groove_2->rectangle(
    #     fill => $self->conductor_colour,
    #     x => 0,
    #     y => $groove_y2 - 5,
    #     width => $self->length,
    #     height => 10,
    # );
    # # Slot
    # $groove_2->rectangle(
    #     fill  => $self->groove_colour,
    #     x => 0,
    #     y => $groove_y2 - 1.5,
    #     width => $self->length,
    #     height => 3,
    # );
}

# Generate SVG path for drawing an arc.
# The arc has a thickness (e.g. drawing
# a curved track is an arc with a 
# thickness - track width - of 156mm).
# $outer_radius = radius of outside edge
# $inner_radius = radius of inner edge
sub _curve_to_path {
    my ($self, $outer_radius, $inner_radius) = @_;

    # Angle in degrees
    my $theta = 2 * pi / $self->angle;

    # 	d="M 0 0
    # 	   a 370 370 0 0 1 141.593 28.165
    # 	   l -59.699 144.125
    # 	   A 214 214 0 0 0 0 156
    # 	   Z
    # 	   "
    # 	stroke="#000000"
    # 	fill="#333333"
    # 	stroke-width="2"
    # />
    my $thickness = $outer_radius - $inner_radius;

    # x = radius * sin(θ)
    # y = radius * (1 - cos(θ))
    my $s = sin($theta);
    my $c = cos($theta);
    my $end_point_x = $outer_radius * $s;
    my $end_point_y = $outer_radius * (1 - $c);

    # -w * sin(θ), w * cos(θ) - w=thickness
    my $inner_end_point_x = -($thickness * $s);
    my $inner_end_point_y = $thickness * $c;

    return sprintf("M 0 0
        a %f %f 0 0 1 %f %f
        l %f %f
        A %f %f 0 0 0 0 %f
        Z
        ",
        $outer_radius, $outer_radius,
        $end_point_x, $end_point_y,
        $inner_end_point_x, $inner_end_point_y,
        $inner_radius, $inner_radius,
        $outer_radius - $inner_radius
    );
}

no Moose;
1;
