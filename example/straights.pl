#!/usr/bin/env perl

use strict;
use warnings;

use FindBin::libs;
use List::Util qw( sum );

use Slotcar::Layout;

my $layout = Slotcar::Layout->new(
    width   => 3_500,
    height  => 2_000,
    grid    => 1,
    start_x => 610,
    start_y => 160,
);

$layout->add_pieces( [qw/
    C8235L
/] );
# $layout->add_pieces( [qw/
#     C8235R
#     C8235L
#     C8205
#     C7036
#     C7018
#     C7018
#     C8435
#     C8235R
#     C8235R
#     C8235R
#     C8235R
#     C8205
#     C8235R
#     C8235R
#     C8235R
#     C8200
#     C8235R
#     C8205
#     C7036
#     C8235R
#     C8235R
#     C8204R
#     C8204R
#     C8204R
#     C8204R
#     C8204R
#     C8204R
#     C8204R
#     C8204R
#     C8205
#     C8235L
#     C8235L
#     C8204L
#     C8204L
#     C8204L
#     C8204L
#     C8204L
#     C8235L
#     C8235L
#     C8235L
#     C8205
#     C8205
#     C8235L
#     C8235L
#     C8205
#     C8235R
#     C8235R
#     C8235R
#     C8204R
#     C8204R
#     C8204R
#     C8204R
#     C8204R
#     C8204R
#     C8235R
# /] );


my $output = $layout->render;
print $output;
