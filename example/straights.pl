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

# $layout->add_pieces( [qw/
#     C8205
#     C8207
#     C8206
#     C8206
#     C8206
#     C8206
#     C7036
#     C8206
#     C8206
#     C8206
#     C8206
# /] );
$layout->add_pieces( [qw/
    C8205
    C8207
    C8200
    C8236
/] );


my $output = $layout->render;
print $output;
