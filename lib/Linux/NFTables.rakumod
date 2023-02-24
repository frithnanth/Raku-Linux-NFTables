unit class Linux::NFTables:ver<0.0.1>:auth<zef:FRITH>;

use Linux::NFTables::Raw;
use Linux::NFTables::Constants;
use NativeCall;

has nft_ctx   $.ctx;

submethod BUILD { $!ctx = nft_ctx_new(NFT_CTX_DEFAULT) }

submethod DESTROY { nft_ctx_free($!ctx) }

multi method dry-run(Bool $active!)              { nft_ctx_set_dry_run($!ctx, $active ?? 1 !! 0) }
multi method dry-run(--> Bool)                   { so nft_ctx_get_dry_run($!ctx) }

multi method flags(UInt $flags!)                 { nft_ctx_output_set_flags($!ctx, $flags) }
multi method flags(--> UInt)                     { nft_ctx_output_get_flags($!ctx) }

multi method debug(UInt $flags!)                 { nft_ctx_output_set_debug($!ctx, $flags) }
multi method debug(--> UInt)                     { nft_ctx_output_get_debug($!ctx) }

multi method set-output(Str $filename! --> Bool) { so mnft_ctx_set_output($!ctx, $filename) }
multi method set-output(--> Bool)                { so mnft_ctx_reset_output() }

multi method set-error(Str $filename! --> Bool)  { so mnft_ctx_set_error($!ctx, $filename) }
multi method set-error(--> Bool)                 { so mnft_ctx_reset_error() }

multi method buffer-output(Bool $active where so * --> Bool)  { !so nft_ctx_buffer_output($!ctx) }
multi method buffer-output(Bool $active where !so * --> Bool) { !so nft_ctx_unbuffer_output($!ctx) }
multi method buffer-output(--> Bool)                          { !so nft_ctx_unbuffer_output($!ctx) }
method get-output-buffer(--> Str)                             { nft_ctx_get_output_buffer($!ctx) }

multi method buffer-error(Bool $active where so * --> Bool)   { !so nft_ctx_buffer_error($!ctx) }
multi method buffer-error(Bool $active where !so * --> Bool)  { !so nft_ctx_unbuffer_error($!ctx) }
multi method buffer-error(--> Bool)                           { !so nft_ctx_unbuffer_error($!ctx) }
method get-error-buffer(--> Str)                              { nft_ctx_get_error_buffer($!ctx) }

method add-path(Str $path! --> Bool) { !so nft_ctx_add_include_path($!ctx, $path) }
method clear-path(--> Bool)          { !so nft_ctx_clear_include_paths($!ctx) }

method add-var(Str $var! --> Bool)    { !so nft_ctx_add_var($!ctx, $var) }
method clear-vars()                   { nft_ctx_clear_vars($!ctx) }

method exec(Str $command! --> Bool)            { !so nft_run_cmd_from_buffer($!ctx, $command) }
method exec-from-file(Str $filename! --> Bool) { !so nft_run_cmd_from_filename($!ctx, $filename) }

=begin pod

=head1 NAME

Linux::NFTables - An interface to libnftables, a library to interact with Linux NFTables

=head1 SYNOPSIS

=begin code :lang<raku>

use Linux::NFTables;

my Linux::NFTables $nft .= new;
$nft.exec('list ruleset');

=end code

=head1 DESCRIPTION

Linux::NFTables is an interface to libnftables, a library to interact with Linux NFTables

=head2 Return values

Many methods return a Bool value to indicate whether the action has been successfully performed.

=head3 new()

The constructor takes no arguments.

=head3 multi method dry-run(Bool $active!)
=head3 multi method dry-run(--> Bool)

The first method sets the operations for a dry run, the second returns the state of the dry-run flag.

List commands produce output, but no real action will be performed on the firewall rules.

=head3 flags(UInt $flags!)
=head3 flags(--> UInt)

The first method allows to add bit-mapped flags to modify the library's behavior, the second returns the value of
the flags.

The available flags are:

=item B<NFT_CTX_OUTPUT_NONE>
=item B<NFT_CTX_OUTPUT_REVERSEDNS>
=item B<NFT_CTX_OUTPUT_SERVICE>
=item B<NFT_CTX_OUTPUT_STATELESS>
=item B<NFT_CTX_OUTPUT_HANDLE>
=item B<NFT_CTX_OUTPUT_JSON>
=item B<NFT_CTX_OUTPUT_ECHO>
=item B<NFT_CTX_OUTPUT_GUID>
=item B<NFT_CTX_OUTPUT_NUMERIC_PROTO>
=item B<NFT_CTX_OUTPUT_NUMERIC_PRIO>
=item B<NFT_CTX_OUTPUT_NUMERIC_SYMBOL>
=item B<NFT_CTX_OUTPUT_NUMERIC_TIME>
=item B<NFT_CTX_OUTPUT_NUMERIC_ALL>
=item B<NFT_CTX_OUTPUT_TERSE>


=head3 debug(UInt $flags!)
=head3 debug(--> UInt)

The first method sets, the second reads the debug level.

The available levels are:

=item B<NFT_DEBUG_NONE>
=item B<NFT_DEBUG_SCANNER>
=item B<NFT_DEBUG_PARSER>
=item B<NFT_DEBUG_EVALUATION>
=item B<NFT_DEBUG_NETLINK>
=item B<NFT_DEBUG_MNL>
=item B<NFT_DEBUG_PROTO_CTX>
=item B<NFT_DEBUG_SEGTREE>

=head3 set-output(Str $filename! --> Bool)
=head3 set-output(--> Bool)

These methods redirect the command output to a file or to stdout.

=head3 set-error(Str $filename! --> Bool)
=head3 set-error(--> Bool)

These methods redirect the command errors to a file or to stderr.

=head3 buffer-output(Bool $active --> Bool)
=head3 buffer-output(--> Bool)
=head3 buffer-error(Bool $active --> Bool)
=head3 buffer-error(--> Bool)

These methods ask to send the command outout or error to a buffer. They take one Bool parameter; when invoked without
parameter they default to False.

=head3 get-output-buffer(--> Str)
=head3 get-error-buffer(--> Str)

These methods return the output or error buffer content (if the the system was asked to buffer its output)

=head3 add-path(Str $path! --> Bool)
=head3 clear-path(--> Bool)

The first method adds a search path for the B<include> command in nftables, the second one removes all the
include paths.

=head3 add-var(Str $var! --> Bool)
=head3 clear-vars()

The first method defines a variable, the second removes all variables.

=head3 exec(Str $command! --> Bool)

This method executes a nftables command.

=head3 exec-from-file(Str $filename! --> Bool)

This method reads and executes nftables comands from a file.

=head1 C Library Documentation

For more details on libnftables see C<man 3 libnftables>.

For more details on nftables see L<https://wiki.nftables.org/wiki-nftables/index.php/Main_Page>.

=head1 Prerequisites

This module requires the libnftables library to be installed.

On Debian-like systems install both libnftables1 and libnftables-dev.

=head1 Installation

To install it using zef (a module management tool):

=begin code
$ zef install Linux::NFTables
=end code

=head1 AUTHOR

Fernando Santagata <nando.santagata@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2023 Fernando Santagata

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
