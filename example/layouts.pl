#!/usr/bin/env perl

use strict;
use warnings;

use FindBin::libs;
use List::Util qw( sum );

use Slotcar::Layout;
use File::Path qw/ make_path remove_tree /;

my $layouts = [
    {
        name => '20200516b',
        base => { width => 3_500, height => 2_000, grid => 1, start_x => 610, start_y => 160 },
        pieces =>[qw/
            C8235R C8235L C8207 C7036 C7018 C7018 C7018 C8435
            C8235R C8235R C8235R C8235R
            C8205
            C8235R C8235R C8235R C8200 C8235R
            C8205  C7036
            C8235R C8235R C8204R C8204R C8204R C8204R C8204R C8204R C8204R C8204R
            C8205  C8235L C8235L C8204L C8204L C8204L C8204L C8204L
            C8235L C8235L C8235L
            C8205  C8205
            C8235L C8235L
            C8205
            C8235R C8235R C8235R C8204R C8204R C8204R C8204R C8204R C8204R C8235R
        /],
    },

    {
        name => '20200516a',
        base => { width => 3_500, height => 2_000, grid => 1, start_x => 1460, start_y => 90 },
        pieces =>[qw/
            C8205 C7036 C8205
            C8235R C8235R C8235R C8235R
            C8205
            C8235R C8235R C8235R C8236 C8235R
            C8207 C8205 C8207 C7018 C7018 C7018 C8435 C8205
            C8235R C8235R C8204R C8204R C8204R C8204R C8204R C8204R C8204R C8204R
            C8205 C8235L C8235L C8207 C7036 C8207
            C8235L C8235L C8235L C8204L C8204L C8204L C8204L C8204L C8204L C8204L 
            C8207 C8205
            C8235R C8235R C8204R C8204R C8204R C8204R C8204R C8204R C8204R C8204R
        /],
    },

    {
        name => '20200108 2.5x1.8',
        base => { width => 2_560, height => 1_800, grid => 1, start_x => 400, start_y => 90 },
        pieces =>[qw/
            C8205 C7036 C8205 C8205
            C8529R C8529R C8206R C8207 C8206L
            C8205 C8278L C8202R C8278L C8207
            C8206L C8206L C8206L C8206L 
            C8207 C8278R C8202L C8278R
            C8205 C7036 C8207
            C8206R C8206R C8206R C8206R 
            C8205 C8205 C8207 C7018 C7018 C7018 C8435
            C8529R C8207 C8205 C8205 C8529R
        /],
    },

    {
        name => '20200115 2.65x1.65',
        base => { width => 2_700, height => 1_800, grid => 1, start_x => 400, start_y => 90 },
        pieces =>[qw/
            C8205 C8205 C8207 C8206R C8205 C8529R C8529R
            C7036 C8529L C8529L C8206L C8206R C8206L C8205 C8205
            C8529L C8206L C8206R C8529R C8529R C8205 C8205
            C8206R C8207 C8206R C8205 C8207 C7018 C7018 C7018 C8435 C8205
            C8529R C7036 C8205 C8529R
        /],
    },

    {
        name => '20200125 2.65x1.65 transition curves',
        base => { width => 2_700, height => 1_800, grid => 1, start_x => 400, start_y => 90 },
        pieces =>[qw/
            C8205 C8205 C8207
            C8235R C8204R C8206R C8205
            C8235R C8204R C8206R C8206R C8204R C8235R
            C8235L C8204L C8206L C8206L C8204L C8235L C8207
            C8235L C8204L C8206L 
            C8205 C7036 C8207
            C8235L C8204L C8206L 
            C8204L C8204L C8204R C8204R C8204R C8204R C8206R
            C8206R C8204R C8204R C8205 C8205
            C8235R C8204R C8206R C8205 C8205
            C8207 C7018 C7018 C7018 C8435
            C8235R C8204R C8206R C8207 C7036
            C8235R C8204R C8206R
        /],
    },

    {
        name => '20200125b 2.8x1.9 transition curves',
        base => { width => 2_800, height => 1_800, grid => 1, start_x => 440, start_y => 90 },
        pieces =>[qw/
            C8205 C8205 C8207
            C8204R C8204R C8204R C8204R C8207
            C8206R C8206R C8204R C8204R C8205
            C8204L C8204L C8206L C8206L C8206L C8206L C8206R
            C8205 C8204L C8204L
            C7036
            C8204L C8204L C8206L C8204L C8204L 
            C8204R C8204R C8204R C8204R C8206R C8206R C8236 C8206R C8206R C8206L
            C8207 C8236 C8204R C8204R C8207 C8206R
            C8207 C8205 C8207 C7018 C7018 C7018 C8435
            C8204R C8204R C8206R C8205 C7036 C8204R C8204R C8206R
        /],
    },

    {
        name => '20200306 3x1.85',
        base => { width => 3_000, height => 1_920, grid => 1, start_x => 1_500, start_y => 120 },
        pieces =>[qw/
            C8204R C8234L C8207 C8235L C8235R C8204R C8204R C8235R C8235R C7036 
            C8235R C8235R C8204R  C8204R 
            C8205 C8205 C8207 C7018 C7018 C7018 C8435
            C8235R C8235R C8297R C8297R C8297R C8297R
            C8205
            C8235L C8235L 
            C7036 C8207
            C8235L C8204L C8204L C8204L C8204L C8204L C8204L C8204L C8204L C8204L C8204L
            C8235R C8204R C8204R C8204R C8204R C8204R C8204R C8204R C8204R C8204R C8235R
        /],
    },

    {
        name => '20200321 3.15x2.05',
        base => { width => 3_200, height => 2_100, grid => 1, start_x => 1_700, start_y => 120 },
        pieces =>[qw/
            C8204R C7018 C7018 C7018 C8435 
            C8235R C8235R C8235R C8205
            C8235R C8235R C8235R C8235R
            C8205 C8207 C8205 C7036 C8205 
            C8235R C8235R C8235R C8235R
            C8205 C8205 
            C8235R C8235R C8204R C8204R C8204R C8204R C8204R C8204R C8204R C8235R
            C8235L C8204L C8204L C8204L C8204L C8204L 
            C8207 C7036 C8205 C8235L C8235L C8204L C8204L C8204L C8204L C8204L C8204L C8204L 
            C8207
            C8235R C8204R C8204R C8204R C8204R C8204R C8204R C8204R C8204R 
        /],
    },
];

my $output = './output';
if ( -d $output ) {
    remove_tree($output, { keep_root => 1 });
}
else {
    mkpath($output);
}

for my $layout ( @{ $layouts } ) {
    my $name = $layout->{name};
    print "$name\n";
    make_path "$output/$name";

    my $base = Slotcar::Layout->new( %{ $layout->{base} } );

    $base->add_pieces( $layout->{pieces} );

    {
        my $svg_file = "$output/$name/layout.svg";
        open(my $fh, '>', $svg_file)
            or die "Can't open > $svg_file: $!";

        print $fh $base->render;
        $fh->close;
    }

    {
        my $part_file = "$output/$name/parts.txt";
        open(my $fh, '>', $part_file)
            or die "Can't open > $part_file: $!";

        my $parts = $base->part_list;

        for my $sku ( sort keys %{ $parts } ) {
            print $fh $sku, ' x ', $parts->{$sku}, "\n";
        }
        $fh->close;
    }

}
