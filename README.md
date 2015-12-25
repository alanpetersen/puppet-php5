# php5

## Overview

The purpose of this module is to provide an easy way to install PHP 5.5 on RedHat/CentOS 6 boxes. I originally started working on this module because I am working on a moodle module, and the latest version of moodle requires PHP 5.4 or higher and I was getting tired installing PHP repeatedly on my CentOS 6 systems.

## Module Description

To use this module, simply classify your node with the php5 class:

`include php5`

You probably only want to do this on nodes where the PHP version (see the `$::phpversion` fact below).

The class provides parameters to override the target directory (where the source will get unpacked and built) and the PHP version to install.

~~~
class { 'php5':
    $targetdir     = '/tmp/src',
    $php_version   = '5.5.30,
) 
~~~

## Custom Facts

* `phplist` - returns a hash of all the php installations on the system (in the PATH -- including /usr/local/bin). This can be useful to see what is currently on a system and deciding which PHP instance you want to use.

~~~
{
	"/usr/bin/php"       => "5.3.3", 
	"/usr/local/bin/php" => "5.5.30"
}
~~~

* `phpversion` -- of the versions installed, returns the 'highest' (determined by string comparison)


## What php5 affects

* This module installs a set of `*-devel` packages and builds and installs PHP. PHP is installed into `/usr/local/bin`. This location is not currently configurable.

## Limitations

This module is only meant to work with RedHat/CentOS 6. If you try to use it with something else, it will fail.
