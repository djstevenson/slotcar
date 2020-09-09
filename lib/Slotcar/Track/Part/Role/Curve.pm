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

    my $a = $self->angle;

    my $half_angle     = $self->angle / 2.0;
    my $sin_half_angle = sin($half_angle);
    my $chord_length   = 2 * $self->radius * $sin_half_angle;

    my $dx = $chord_length * cos($half_angle);
    my $dy = $chord_length * $sin_half_angle;

    return Slotcar::Track::Offset->new(
        x     => $dx,
        y     => $dy,
        angle => $a,
    );
}

sub render_part_def {
    my ($self, $group) = @_;

    print STDERR $self->sku, " Render curve R=", $self->radius, "\n";
}

no Moose::Role;
1;
