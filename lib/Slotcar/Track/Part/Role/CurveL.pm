package Slotcar::Track::Part::Role::CurveL;
use Moose::Role;

use Math::Trig;

sub _is_reversed { return 1; }

with 'Slotcar::Track::Part::Role::Curve';

use Slotcar::Track::Offset;

# sub _render_single_groove {
#     my ($self, $track, $offset) = @_;

#     my $cols = $self->colours;
#     my $dims = $self->dimensions;

#     my $path1 = $self->_curve_path({
#         angle   => $self->angle,
#         radius  => $self->radius + $offset,
#         width   => $dims->conductor_width,
#     });
#     my $path2 = $self->_curve_path({
#         angle  => $self->angle,
#         radius => $self->radius + $offset,
#         width  => $dims->groove_width,
#     });
#     $track->path(
#         d    => $path1,
#         fill => $cols->conductor,
#     );
#     $track->path(
#         d    => $path2,
#         fill => $cols->groove,
#     );
# }


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
