#!/usr/bin/env raku

use lib 'lib';
use Linux::NFTables;
use Linux::NFTables::Constants;

my Linux::NFTables $nft .= new;
$nft.flags: NFT_CTX_OUTPUT_HANDLE;

$nft.dry-run: True;    # safe setting: list commands will be executed, but no real action will be done

$nft.exec: 'list ruleset';
$nft.exec: 'add rule filter INPUT ip saddr 192.168.1.222/32 accept';
$nft.exec: 'list ruleset';
$nft.exec: 'delete rule filter INPUT handle 44';
$nft.exec: 'list ruleset';
