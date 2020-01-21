package Slotcar::Track::Curve::Base;
use Moose;

extends 'Slotcar::Track::Base';

use Slotcar::Track::Join::Double;

# Not really sure how these need to look yet.
# POD docs will follow once the design is a bit
# more settled.

has '+lanes' => ( default => 2);
has '+width' => ( default => 156_000);  # 156mm

# Units = µm
has radius => (
    is          => 'ro',
    isa         => 'Int',
    required    => 1,
);

# Angle is the wrong word, find something better.
# It's the portion of a circle, e.g. 22.5˚ is 
# represented as 16 here (360/16). A value of
# 1 would represent a full circle.  Scalextric
# pieces come in 22.5˚, 45˚ and 90˚ (not all
# available at all radii), and there are
# represented as 16, 8, 4 respectively

has angle => (
    is          => 'ro',
    isa         => 'Int',
    required    => 1,
);

override define_joins => sub {
    my $self = shift;

    die "What do we need here?";

    # return {
    #     left  => Slotcar::Track::Join::Double->new,
    #     right => Slotcar::Track::Join::Double->new(
    #         offset_x    => $self->length,
    #         offset_y    => $self->width,
    #         is_inverted => 1,
    #     ),
    # };
};

no Moose;
1;
