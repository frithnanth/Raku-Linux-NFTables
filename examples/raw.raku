#!/usr/bin/env raku

use NativeCall;
use lib 'lib';
use Linux::NFTables::Raw;
use Linux::NFTables::Constants;

my $ctx = nft_ctx_new(NFT_CTX_DEFAULT);
nft_run_cmd_from_buffer($ctx, 'list ruleset');

nft_ctx_free($ctx);
