[![Actions Status](https://github.com/sdondley/Distribution-Resources-Menu/actions/workflows/test.yml/badge.svg)](https://github.com/sdondley/Distribution-Resources-Menu/actions)

NAME
====

Distribution::Resources::Menu - Navigate the files in the resources directory of your Raku distribution from the command line

SYNOPSIS
========

Place something like the following code into a module in your distribution:

```raku
use Distribution::Resources::Menu;
unit module Your::Module;

my $rsm = ResourceMenu.new(
    distribution => $?DISTRIBUTION,
    resources    => $%RESOURCES);

sub execute-resource-menu is export {
    $rsm.execute;
}
```

And now you can execute the menu with something like this:

```raku
use Your::Module;

# Display a menu on the command line and prompt the user
# to select a file from the "resources" directory of the distribution
my $resource = execute-resource-menu();

say $resource.file-path;
say $resource.file-content;
```

DESCRIPTION
===========

Distribution::Resources::Menu generates and executes a menu for navigating and selecting files located in a distribution's `resources` directory.

METHODS
=======

execute
-------

Executes the interactive command-line menu for selecting a file from the resources directory of the distribution.

file-content
------------

Returns the string value of the content of the file.

file-path
---------

Returns the string value of the path to the file contained in the `$%RESOURCES` variable.

AUTHOR
======

Steve Dondley <s@dondley.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Steve Dondley

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

