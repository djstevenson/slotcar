package Slotcar::Track::Moose;
use Moose;
use namespace::autoclean;

use Slotcar::Track::Part;

use Moose::Exporter;
use Moose::Util::MetaRole;
use Moose::Util;

# Exporting sugar methods
Moose::Exporter->setup_import_methods(
    with_meta => [qw/
        has_part
    /],
    also => 'Moose',
);

sub init_meta {
    my ($class, %options) = @_;

    # Setting up the moose stuff
    my $meta = Moose->init_meta(%options);

    # Apply the role to the caller class's metaclass object
    Moose::Util::MetaRole::apply_metaroles(
        for             => $options{for_class},
        class_metaroles => { class => ['Slotcar::Track::Meta::Part'] },
    );
}

sub has_part {
    my ($meta, $sku, %options) = @_;

    my $traits = delete $options{traits};
    my $trait_classes = [ map { "Slotcar::Track::Part::Role::$_" } @$traits ];

    my $part = Slotcar::Track::Part->new_with_traits(
        sku => $sku,
        %options,
        traits => $trait_classes,
    );

    $meta->add_part($sku => $part);
    return $part;
}

1;
