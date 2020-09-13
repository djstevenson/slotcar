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
    start_x => 600,
    start_y => 100,
);

$layout->add_pieces( [qw/
    C8235
    C8235-
    C8205
    C7036
    C7018
    C7018
    C8435
    C8235
    C8235
    C8235
    C8235
    C8205
    C8235
    C8235
    C8235
    C8200
    C8235
    C8205
    C7036
    C8235
    C8235
    C8204
    C8204
    C8204
    C8204
    C8204
    C8204
    C8204
    C8204
    C8205
    C8235-
    C8235-
    C8204-
    C8204-
    C8204-
    C8204-
    C8204-
    C8235-
    C8235-
    C8235-
    C8205
    C8205
    C8235-
    C8235-
    C8205
    C8235
    C8235
    C8235
    C8204
    C8204
    C8204
    C8204
    C8204
    C8204
    C8235
/] );


my $output = $layout->render;
print $output;
