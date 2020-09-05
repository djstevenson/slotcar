#!/usr/bin/env perl

use strict;
use warnings;

use FindBin::libs;
use List::Util qw( sum );

use Slotcar::Layout;

my $layout = Slotcar::Layout->new(
    width  => 2_000,
    height => 2_000,
);

$layout->add_pieces( [qw/
    C7018
    C7018
    C8435
    C8235R
    C8204R
    C8206R
    C8206R
    C8204R
    C8235R
    C7036
    C8207
    C8235R
    C8204R
    C8206R
    C8206R
    C8204R
    C8235R
/] );

# Can currently only render one piece
my $output = $layout->render;
print $output;

# Can we invent a DSL for describing tracks?
# c8425 <=> C8205 <=> C8205 <=> C8207 etc?
# <=> means connect right join of first item to 
#     left join of second.
#
# Not yet sure how we'd do crossroads etc.
