package Slotcar::Track::Piece;
use Moose;
use namespace::autoclean;

use Math::Trig qw/ rad2deg pi /;

use Slotcar::Track::Offset;

has offset => (
    is          => 'ro',
    isa         => 'Slotcar::Track::Offset',
    required    => 1,
);

# Defines the dimensions etc of the track part
has part => (
    is          => 'ro',
    isa         => 'Slotcar::Track::Part',
    required    => 1,
);

# Render an svg 'use' tag to reference
# the definition that's already in the library
# of track elements in the defs section.
sub render {
    my ($self, $svg) = @_;

    my $offset = $self->offset;
    my $x      = $offset->x;
    my $y      = $offset->y;
    my $angle  = $offset->angle;
    my $part   = $self->part;

    $svg->use(
        x => $x,
        y => $y,
        transform => sprintf('rotate(%f %f %f)', rad2deg($angle), $x, $y),
        '-href' => '#' . $part->sku,
    );


    # Get the label position relative to the origin.
    my $label_offset = $part->label_offset;
    my $dx = $label_offset->x;
    my $dy = $label_offset->y;

    my $sa = sin($angle);
    my $ca = cos($angle);

    my $textx = $dx * $ca - $dy * $sa;
    my $texty = $dx * $sa + $dy * $ca;
    
    # $svg->text(
    #     x => $x + $textx - 36,
    #     y => $y + $texty + 9,
    #     style => {
    #         font => sprintf('%dpx sans-serif', 24),
    #         fill => $part->colours->label,
    #     },
    # )->cdata($part->sku);
}

__PACKAGE__->meta->make_immutable;
1;
