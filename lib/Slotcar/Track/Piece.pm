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

# True if 'reversed'. Curve parts, by default,
# curve to the right (anti-clockwise) for cars
# traversing the circuit. To curve to the left,
# set this to true.
has reversed => (
    is          => 'ro',
    isa         => 'Bool',
    default     => 0,
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

    my $extra = '';
    my ($x2, $y2) = (0,0);
    if ($self->reversed) {
        $extra = sprintf('rotate(%f %f %f)',
            rad2deg(pi - $part->next_piece_offset->angle),
            $x,
            $y
        );
        $x2 = - $part->next_piece_offset->x;
        $y2 = - $part->next_piece_offset->y;
    }

    $svg->use(
        x => $x + $x2,
        y => $y + $y2,
        transform => sprintf('rotate(%f %f %f) %s', rad2deg($angle), $x, $y, $extra),
        '-href' => '#' . $part->sku,
    );


    # Get the label position relative to the origin.
    my $label_offset = $part->label_offset;
    my $dx = $label_offset->x;
    my $dy = $label_offset->y;


    # See if we can do it assuming not reversed, then rotate
    # to reverse?
    # ...


    # NEED TO DO SOME TWEAK WITH REVERSED PIECES
    my $sa = sin($angle);
    my $ca = cos($angle);

    my $textx = $dx * $ca - $dy * $sa;
    my $texty = $dx * $sa + $dy * $ca;
    
    $svg->circle(
        cx             => $x + $textx,
        cy             => $y + $texty,
        r              => 6,
        fill           => '#ffcc99',
    ); 
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
