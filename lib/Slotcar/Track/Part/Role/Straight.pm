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

# This can probably be in Role::Part, common to all parts
sub render_part_def {
    my ($self, $track) = @_;

    $self->_render_base($track);
    $self->_render_grooves($track);
    $self->_render_border($track);
}

sub _render_base {
    my ($self, $track) = @_;

    my $cols = $self->colours;
    my $dims = $self->dimensions;

    $track->rectangle(
        fill   => $cols->track_base,
        x      => 0,
        y      => -$dims->half_width,
        width  => $self->length,
        height => $dims->width,
    );
}

sub _render_grooves {
    my ($self, $track) = @_;

    my $dims = $self->dimensions;
    $self->_render_groove($track, -$dims->lane_offset);
    $self->_render_groove($track,  $dims->lane_offset);
}

sub _render_groove {
    my ($self, $track, $y) = @_;

    my $cols = $self->colours;
    my $dims = $self->dimensions;
    $track->rectangle(
        fill   => $cols->conductor,
        x      => 0,
        y      => $y - $dims->conductor_offset,
        width  => $self->length,
        height => $dims->conductor_width,
    );

    $track->rectangle(
        fill   => $cols->groove,
        x      => 0,
        y      => $y - $dims->groove_offset,
        width  => $self->length,
        height => $dims->groove_width,
    );

}

sub _render_border {
    my ($self, $track) = @_;

    my $cols = $self->colours;
    my $dims = $self->dimensions;

    $track->rectangle(
        x      => 0,
        y      => -$dims->half_width,
        width  => $self->length,
        height => $dims->width,
        stroke => $cols->edge,
        'stroke-width' => 2,
        fill   => 'none',
    );
}

no Moose::Role;
1;
