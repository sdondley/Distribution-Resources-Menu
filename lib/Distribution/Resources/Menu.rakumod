use Menu::HashToMenu;
unit class Distribution::Resources::Menu;

class ResourceMenu is export {
    has CompUnit::Repository::Distribution $.distribution is required;
    has Distribution::Resources $.resources is required;
    has HashToMenu $.menu is rw;
    has Str @.paths;
    has $.file is rw;
    has Str $.file-content is rw;
    has Str $.file-path is rw;


    method build-menu($hash) {
        # following code may be useful in future versions
        #my &action = sub ($path) { $.resources{$path}.slurp };
        #my &processor = sub ($str) { flip $str };
        #self.menu = HashToMenu.new($hash, &action, &processor);
        #self.menu = HashToMenu.new($hash, &action);
        self.menu = HashToMenu.new($hash, :strip-sort-num;
    }

    method menu-populate() {
        my @paths;
        push @paths, (.split: '/').Array for self.paths;
        my %hash;
        for @paths {
            postcircumfix:<{; }>(%hash, $_) = $_.join('/');
        }
        self.build-menu: %hash;
    }

    method init() {
        self.paths = self.distribution.meta<resources>.sort;
        self.menu-populate;
    }

    method execute() {
        self.init if !self.menu;
        my $option = self.menu.execute;
        my $file = $.resources{$option.option-value};
        $.file = $file;
        $.file-content = $file.slurp;
        $.file-path = $file.absolute;
        return self;
    }
}

=begin pod

=head1 NAME

Distribution::Resources::Menu - Navigate the files in the resources directory
of your Raku distribution from the command line

=head1 SYNOPSIS

Place something like the following code into a module in your distribution:
=begin code :lang<raku>
use Distribution::Resources::Menu;
unit module Your::Module;

my $rsm = ResourceMenu.new(
    distribution => $?DISTRIBUTION,
    resources    => %?RESOURCES);

sub execute-resource-menu is export {
    $rsm.execute;
}

=end code

And now you can execute the menu with something like this:

=begin code :lang<raku>
use Your::Module;

# Display a menu on the command line and prompt the user
# to select a file from the "resources" directory of the distribution
my $resource = execute-resource-menu();

say $resource.file-path;
say $resource.file-content;

=end code

=head1 DESCRIPTION

Distribution::Resources::Menu generates and executes a menu
for navigating and selecting files located in a distribution's C<resources> directory.

=head1 METHODS

=head2 execute

Executes the interactive command-line menu for selecting a file from
the resources directory of the distribution.

=head2 file-content

Returns the string value of the content of the file.

=head2 file-path

Returns the string value of the path to the file contained in the C<$%RESOURCES>
variable.

=head1 AUTHOR

Steve Dondley <s@dondley.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2022 Steve Dondley

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
