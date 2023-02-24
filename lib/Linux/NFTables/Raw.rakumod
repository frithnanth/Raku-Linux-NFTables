use v6;

unit module Linux::NFTables::Raw:ver<0.0.1>:auth<zef:FRITH>;

use NativeCall;

constant NFTHELPER = %?RESOURCES<libraries/nfthelper>.absolute;

sub LIB {
  run('/sbin/ldconfig', '-p', :chomp, :out)
    .out
    .slurp(:close)
    .split("\n")
    .grep(/^ \s+ libnftables\.so\. \d+ /)
    .sort
    .head
    .comb(/\S+/)
    .head;
}

class nft_ctx is repr('CPointer') is export { * } # libnftables private struct

sub nft_ctx_new(int32 $flags --> nft_ctx) is native(LIB) is export { * }
sub nft_ctx_free(nft_ctx $ctx) is native(LIB) is export { * }
sub nft_ctx_get_dry_run(nft_ctx $ctx --> int32) is native(LIB) is export { * }
sub nft_ctx_set_dry_run(nft_ctx $ctx, int32 $dry) is native(LIB) is export { * }
sub nft_ctx_get_optimize(nft_ctx $nft --> uint32) is native(LIB) is export { * }
sub nft_ctx_set_optimize(nft_ctx $nft, uint32 $flags) is native(LIB) is export { * }
sub nft_ctx_output_get_flags(nft_ctx $nft --> uint32) is native(LIB) is export { * }
sub nft_ctx_output_set_flags(nft_ctx $nft, uint32 $flags) is native(LIB) is export { * }
sub nft_ctx_output_get_debug(nft_ctx $nft --> uint32) is native(LIB) is export { * }
sub nft_ctx_output_set_debug(nft_ctx $nft, uint32 $mask) is native(LIB) is export { * }
sub mnft_ctx_set_output(nft_ctx $nft, Str $filename --> int32) is native(NFTHELPER) is export { * }
sub mnft_ctx_reset_output(--> int32) is native(NFTHELPER) is export { * }
sub nft_ctx_buffer_output(nft_ctx $nft --> int32) is native(LIB) is export { * }
sub nft_ctx_unbuffer_output(nft_ctx $nft --> int32) is native(LIB) is export { * }
sub nft_ctx_get_output_buffer(nft_ctx $nft --> Str) is native(LIB) is export { * }
sub mnft_ctx_set_error(nft_ctx $nft, Str $filename --> int32) is native(NFTHELPER) is export { * }
sub mnft_ctx_reset_error(--> int32) is native(NFTHELPER) is export { * }
sub nft_ctx_buffer_error(nft_ctx $nft --> int32) is native(LIB) is export { * }
sub nft_ctx_unbuffer_error(nft_ctx $nft --> int32) is native(LIB) is export { * }
sub nft_ctx_get_error_buffer(nft_ctx $nft --> Str) is native(LIB) is export { * }
sub nft_ctx_add_include_path(nft_ctx $nft, Str $path --> int32) is native(LIB) is export { * }
sub nft_ctx_clear_include_paths(nft_ctx $nft) is native(LIB) is export { * }
sub nft_ctx_add_var(nft_ctx $nft, Str $var --> int32) is native(LIB) is export { * }
sub nft_ctx_clear_vars(nft_ctx $nft) is native(LIB) is export { * }
sub nft_run_cmd_from_buffer(nft_ctx $nft, Str $buf --> int32) is native(LIB) is export { * }
sub nft_run_cmd_from_filename(nft_ctx $nft, Str $filename --> int32) is native(LIB) is export { * }
