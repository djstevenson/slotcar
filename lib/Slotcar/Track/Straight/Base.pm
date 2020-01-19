package Slotcar::Track::Straight::Base;
use Moose;

extends 'Slotcar::Track::Base';

use Slotcar::Track::Join::Double;

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

has '+lanes' => ( default => 2);
has '+width' => ( default => 156_000);  # 156mm

# Override length in a subclass.

override define_joins => sub {
    my $self = shift;

    return {
        left  => Slotcar::Track::Join::Double->new,
        right => Slotcar::Track::Join::Double->new(
            offset_x    => $self->length,
            offset_y    => $self->width,
            is_inverted => 1,
        ),
    };
};

no Moose;
1;
