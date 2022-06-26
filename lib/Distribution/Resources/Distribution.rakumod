use v6.d;
# This module is for testing purposes only
unit module Districution::Resources::Distribution;

sub dist() is export {
    return $?DISTRIBUTION;
}

sub rsrc() is export {
    return %?RESOURCES;
}
