#!/usr/bin/env perl
use strict;
use warnings;
use SVG;

use SVG (-inline => 1, -nocredits => 1);

# a 10-pointsaw-tooth pattern drawn with a path definition
my $xv = [0,1,2,3,4,5,6,7,8,9];
my $yv = [0,1,0,1,0,1,0,1,0,1];
 
 my $svg = SVG->new(
    width  => 20,
    height => 10,
);

my $points = $svg->get_path(
    x => $xv,
    y => $yv,
    -type   => 'path',
    -closed => 'true'  #specify that the polyline is closed
);

use Data::Dumper;
print Dumper($points);
my $tag = $svg->path(
    %$points,
    id    => 'pline_1',
    style => {
        'fill-opacity' => 0,
        'fill'   => 'green',
        'stroke' => 'rgb(250,123,23)'
    }
);

print $svg->xmlify;
