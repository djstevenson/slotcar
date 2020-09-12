#!/usr/bin/env perl

use strict;
use warnings;

use FindBin::libs;
use List::Util qw( sum );

use Slotcar::Layout;

my $layout = Slotcar::Layout->new(
    width  => 2_000,
    height => 1_000,
    grid   => 1,
);

$layout->add_pieces( [qw/
    C8207
    C8235
    C8204
    C8206
    C8206
    C8204
    C8235
    C8207
    C8235
    C8204
    C8206
    C8206
    C8204
    C8235
/] );


my $output = $layout->render;
print $output;
