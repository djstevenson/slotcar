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
        d    => $self->_curve_path($dims->width),
        fill => $cols->track_base,
    );
};

after render_grooves => sub {
    my ($self, $track) = @_;

    my $dims = $self->dimensions;

    # $self->_render_single_groove($track, $dims->lane_offset);
    # $self->_render_single_groove($track, -$dims->lane_offset);
};

# Width of arc,
# Offset (default 0) = offset from centre radius
sub _curve_path {
    my ($self, $width, $offset) = @_;

    $offset //= 0;

    my $rev = $self->reversed ? 1 : -1;

    my $angle      = $self->angle;
    my $radius     = $self->radius + $rev * $offset;
    my $half_width = $width / 2.0;

    # Short names, three chars
    # First = i/o for inner/outer
    # Second = s/e for start/end point of curve
    # Third  = x/y with obvious meaning
    # So $isx is 'x' value of start point of inner radius
    my ($isx, $isy, $iex, $iey);
    my ($osx, $osy, $oex, $oey);

    my $outer_radius = $radius + $half_width;
    my $inner_radius = $radius - $half_width;
    my $i_offset = $self->_offset_for_angle($angle, $inner_radius);
    my $o_offset = $self->_offset_for_angle($angle, $outer_radius);
    $i_offset->log('INNER');
    $o_offset->log('OUTER');

    # S1/S2 = "sweep" from SVG arc definition
    my ($s1, $s2);

    if ($self->reversed) {
        ($s1, $s2) = (0,1);

        ($isx, $isy) = (0, - $offset - $half_width);
        ($iex, $iey) = ($isx + $i_offset->x, $isy - $i_offset->y);
        ($oex, $oey) = (0, $isy + $width);
        ($osx, $osy) = ($oex + $o_offset->x, $oey - $o_offset->y);
    }
    else {
        ($s1, $s2) = (1,0);

        ($isx, $isy) = (0, $offset + $half_width);
        ($iex, $iey) = ($isx + $i_offset->x, $isy + $i_offset->y);
        ($oex, $oey) = (0, $isy - $width);
        ($osx, $osy) = ($oex + $o_offset->x, $oey + $o_offset->y);
    }

    # Start at origin. Line to inner start x/y
    # Arc to inner end, line to outer start,
    # arc to outer end, then close off back to
    # origin (Z)
    my $y_origin = $offset;
    return sprintf("M 0 %f
        L %f %f
        A %f %f 0 0 %d %f %f
        L %f %f
        A %f %f 0 0 %d %f %f
        Z
        ",
        $y_origin,
        $isx, $isy,
        $inner_radius, $inner_radius,
        $s1,
        $iex, $iey,
        $osx, $osy,
        $outer_radius, $outer_radius,
        $s2,
        $oex, $oey
    );
}

sub _render_single_groove {
    my ($self, $track, $offset) = @_;

    my $cols = $self->colours;
    my $dims = $self->dimensions;

    $track->path(
        d    => $self->_curve_path($dims->conductor_width, $offset),
        fill => $cols->conductor,
    );
    $track->path(
        d    => $self->_curve_path($dims->groove_width, $offset),
        fill => $cols->groove,
    );
}

after render_border => sub {
    my ($self, $track) = @_;

    my $cols = $self->colours;
    my $dims = $self->dimensions;

    $track->path(
        d              => $self->_curve_path($dims->width),
        stroke         => $cols->edge,
        'stroke-width' => 2,
        fill           => 'none',
    );
};

no Moose::Role;
1;
