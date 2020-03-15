#!/usr/bin/env perl

use strict;
use warnings;

use FindBin::libs;
use List::Util qw( sum );

use Slotcar::Layout;

my $layout = Slotcar::Layout->new(
    width => 1_000,
    height => 500,
);

my @track = qw/
    C8435
/;
    # C7000
    # C7018
    # C8205
    # C8207
    # C8435
    # C8200
    # C8236
    # C8278
    # C8206
    # C8204
    # C8235
    # C8529
$layout->add_pieces( \@track );

# Can currently only render one piece
my $output = $layout->render;
print $output;

# Can we invent a DSL for describing tracks?
# c8425 <=> C8205 <=> C8205 <=> C8207 etc?
# <=> means connect right join of first item to 
#     left join of second.
#
# Not yet sure how we'd do crossroads etc.
