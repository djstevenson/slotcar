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
    my ($self, $angle, $radius) = @_;

    my $factor = $self->reversed ? -1 : 1;

    my $r = $radius // $self->radius;

    my $half_angle     = $angle / 2.0;
    my $sin_half_angle = sin($half_angle);
    my $chord_length   = 2 * $r * $sin_half_angle;

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

after render_base => sub {
    my ($self, $track) = @_;

    my $cols = $self->colours;
    my $dims = $self->dimensions;

    $track->path(
        d              => $self->_arc,
        stroke         => $cols->base,
        'stroke-width' => $dims->width,
        fill           => 'none',
    );
};

after render_grooves => sub {
    my ($self, $track) = @_;

    my $dims = $self->dimensions;

    $self->_render_single_groove($track, $dims->lane_offset);
    $self->_render_single_groove($track, -$dims->lane_offset);
};


sub _arc {
    my ($self, $extra) = @_;

    $extra //= 0;
    my $radius = $self->radius + $extra;
    my $offset = $self->_offset_for_angle($self->angle, $radius);

    return sprintf(
        'M 0 %f a %f %f 0 0 %d %f %f',
        $self->reversed ? $extra : -$extra,
        $radius, $radius,
        $self->reversed ? 0 : 1,
        $offset->x, $offset->y
    );  
}

sub _render_single_groove {
    my ($self, $track, $offset) = @_;

    my $cols = $self->colours;
    my $dims = $self->dimensions;

    $track->path(
        d              => $self->_arc($offset),
        stroke         => $cols->conductor,
        'stroke-width' => $dims->conductor_width,
        fill           => 'none',
    );

    $track->path(
        d              => $self->_arc($offset),
        stroke         => $cols->groove,
        'stroke-width' => $dims->groove_width,
        fill           => 'none',
    );
}

after render_border => sub {
    my ($self, $track) = @_;

    my $colour     = $self->colours->edge;
    my $half_width = $self->dimensions->half_width;

    # TODO Can't we do a single path here instead of three?

    # Leading edge
    $track->line(
        x1             => 0,
        y1             => $half_width,
        x2             => 0,
        y2             => -$half_width,
        stroke         => $colour,
        'stroke-width' => 2, # TODO this should be in $dims
        fill           => 'none',
    );

    # Two curved edges
    $track->path(
        d              => $self->_arc($half_width),
        stroke         => $colour,
        'stroke-width' => 2, # TODO this should be in $dims
        fill           => 'none',
    );
    $track->path(
        d              => $self->_arc(-$half_width),
        stroke         => $colour,
        'stroke-width' => 2, # TODO this should be in $dims
        fill           => 'none',
    );
};

no Moose::Role;
1;
