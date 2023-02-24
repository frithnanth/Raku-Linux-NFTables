NAME
====

Linux::NFTables - An interface to libnftables, a library to interact with Linux NFTables

SYNOPSIS
========

```raku
use Linux::NFTables;

my Linux::NFTables $nft .= new;
$nft.exec('list ruleset');
```

DESCRIPTION
===========

Linux::NFTables is an interface to libnftables, a library to interact with Linux NFTables

Return values
-------------

Many methods return a Bool value to indicate whether the action has been successfully performed.

### new()

The constructor takes no arguments.

### multi method dry-run(Bool $active!)

### multi method dry-run(--> Bool)

The first method sets the operations for a dry run, the second returns the state of the dry-run flag.

List commands produce output, but no real action will be performed on the firewall rules.

### flags(UInt $flags!)

### flags(--> UInt)

The first method allows to add bit-mapped flags to modify the library's behavior, the second returns the value of the flags.

The available flags are:

  * **NFT_CTX_OUTPUT_NONE**

  * **NFT_CTX_OUTPUT_REVERSEDNS**

  * **NFT_CTX_OUTPUT_SERVICE**

  * **NFT_CTX_OUTPUT_STATELESS**

  * **NFT_CTX_OUTPUT_HANDLE**

  * **NFT_CTX_OUTPUT_JSON**

  * **NFT_CTX_OUTPUT_ECHO**

  * **NFT_CTX_OUTPUT_GUID**

  * **NFT_CTX_OUTPUT_NUMERIC_PROTO**

  * **NFT_CTX_OUTPUT_NUMERIC_PRIO**

  * **NFT_CTX_OUTPUT_NUMERIC_SYMBOL**

  * **NFT_CTX_OUTPUT_NUMERIC_TIME**

  * **NFT_CTX_OUTPUT_NUMERIC_ALL**

  * **NFT_CTX_OUTPUT_TERSE**

### debug(UInt $flags!)

### debug(--> UInt)

The first method sets, the second reads the debug level.

The available levels are:

  * **NFT_DEBUG_NONE**

  * **NFT_DEBUG_SCANNER**

  * **NFT_DEBUG_PARSER**

  * **NFT_DEBUG_EVALUATION**

  * **NFT_DEBUG_NETLINK**

  * **NFT_DEBUG_MNL**

  * **NFT_DEBUG_PROTO_CTX**

  * **NFT_DEBUG_SEGTREE**

### set-output(Str $filename! --> Bool)

### set-output(--> Bool)

These methods redirect the command output to a file or to stdout.

### set-error(Str $filename! --> Bool)

### set-error(--> Bool)

These methods redirect the command errors to a file or to stderr.

### buffer-output(Bool $active --> Bool)

### buffer-output(--> Bool)

### buffer-error(Bool $active --> Bool)

### buffer-error(--> Bool)

These methods ask to send the command outout or error to a buffer. They take one Bool parameter; when invoked without parameter they default to False.

### get-output-buffer(--> Str)

### get-error-buffer(--> Str)

These methods return the output or error buffer content (if the the system was asked to buffer its output)

### add-path(Str $path! --> Bool)

### clear-path(--> Bool)

The first method adds a search path for the **include** command in nftables, the second one removes all the include paths.

### add-var(Str $var! --> Bool)

### clear-vars()

The first method defines a variable, the second removes all variables.

### exec(Str $command! --> Bool)

This method executes a nftables command.

### exec-from-file(Str $filename! --> Bool)

This method reads and executes nftables comands from a file.

C Library Documentation
=======================

For more details on libnftables see `man 3 libnftables`.
For more details on nftables see [https://wiki.nftables.org/wiki-nftables/index.php/Main_Page](https://wiki.nftables.org/wiki-nftables/index.php/Main_Page).

Prerequisites
=============

This module requires the libnftables library to be installed.

Installation
============

To install it using zef (a module management tool):

    $ zef install Linux::NFTables

AUTHOR
======

Fernando Santagata <nando.santagata@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2023 Fernando Santagata

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

