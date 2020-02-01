#!/usr/bin/env perl

use strict;
use warnings;

use FindBin::libs;
use List::Util qw( sum );

use Slotcar::PieceFactory;

use SVG (-inline => 1, -nocredits => 1);

my $svg = SVG->new(  # 1m square base board
    width  => 1_000,
    height => 1_000,
);

my $piece_factory = Slotcar::PieceFactory->new(svg => $svg);
my @track = qw/
    C8435
    C8205
    C8205
    C8207
    C7018
    C8200
    C8236
    C8278
    C8206
    C8204
    C8235
    C8529
/;

my @pieces = map { $piece_factory->piece($_)} @track;

# Can currently only render one piece
$pieces[1]->render;
# $track->[5]->render;
print $svg->xmlify;

# Can we invent a DSL for describing tracks?
# c8425 <=> C8205 <=> C8205 <=> C8207 etc?
# <=> means connect right join of first item to 
#     left join of second.
#
# Not yet sure how we'd do crossroads etc.
