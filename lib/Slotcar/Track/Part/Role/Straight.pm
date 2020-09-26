package Slotcar::Track::Part::Role::Straight;
use Moose::Role;

has length => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
    builder     => '_build_length',
);

use Slotcar::Track::Offset;

sub next_piece_offset {
    my ($self) = @_;

    return Slotcar::Track::Offset->new(
        x     => $self->length,
        y     => 0,
        angle => 0,
    );
}

# Angle not used
sub label_offset {
    my ($self) = @_;

    return Slotcar::Track::Offset->new(
        x     => $self->length/2.0,
        y     => 0,
        angle => 0,
    );
}

after render_base => sub {
    my ($self, $track) = @_;

    my $colour = $self->colours->base;
    my $width  = $self->dimensions->width;

    $track->line(
        x1             => 0,
        y1             => 0,
        x2             => $self->length,
        y2             => 0,
        stroke         => $colour,
        'stroke-width' => $width,
        fill           => 'none',
    );
};

after render_grooves => sub {
    my ($self, $track) = @_;

    my $dims = $self->dimensions;
    $self->_render_groove($track, -$dims->lane_offset);
    $self->_render_groove($track,  $dims->lane_offset);
};

sub _render_groove {
    my ($self, $track, $y) = @_;

    my $cols = $self->colours;
    my $dims = $self->dimensions;

    my $len = $self->length;

    # Conductor
    $track->line(
        x1             => 0,
        y1             => $y,
        x2             => $len,
        y2             => $y,
        stroke         => $cols->conductor,
        'stroke-width' => $dims->conductor_width,
        fill           => 'none',
    );

    # Groove
    $track->line(
        x1             => 0,
        y1             => $y,
        x2             => $len,
        y2             => $y,
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

    # Two side edges
    my $length = $self->length;
    $track->line(
        x1             => 0,
        y1             => $half_width,
        x2             => $length,
        y2             => $half_width,
        stroke         => $colour,
        'stroke-width' => 2, # TODO this should be in $dims
        fill           => 'none',
    );
    $track->line(
        x1             => 0,
        y1             => -$half_width,
        x2             => $length,
        y2             => -$half_width,
        stroke         => $colour,
        'stroke-width' => 2, # TODO this should be in $dims
        fill           => 'none',
    );
};

no Moose::Role;
1;
