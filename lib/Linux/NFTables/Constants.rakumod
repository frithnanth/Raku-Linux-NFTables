use v6;

unit module Linux::NFTables::Constants:ver<0.0.2>:auth<zef:FRITH>;

enum nft_debug_level is export (
  NFT_DEBUG_NONE       => 0x0,
  NFT_DEBUG_SCANNER    => 0x1,
  NFT_DEBUG_PARSER     => 0x2,
  NFT_DEBUG_EVALUATION => 0x4,
  NFT_DEBUG_NETLINK    => 0x8,
  NFT_DEBUG_MNL        => 0x10,
  NFT_DEBUG_PROTO_CTX  => 0x20,
  NFT_DEBUG_SEGTREE    => 0x40,
);

enum nft_output is export (
  NFT_CTX_OUTPUT_NONE           => 0,
  NFT_CTX_OUTPUT_REVERSEDNS     => (1 +< 0),
  NFT_CTX_OUTPUT_SERVICE        => (1 +< 1),
  NFT_CTX_OUTPUT_STATELESS      => (1 +< 2),
  NFT_CTX_OUTPUT_HANDLE         => (1 +< 3),
  NFT_CTX_OUTPUT_JSON           => (1 +< 4),
  NFT_CTX_OUTPUT_ECHO           => (1 +< 5),
  NFT_CTX_OUTPUT_GUID           => (1 +< 6),
  NFT_CTX_OUTPUT_NUMERIC_PROTO  => (1 +< 7),
  NFT_CTX_OUTPUT_NUMERIC_PRIO   => (1 +< 8),
  NFT_CTX_OUTPUT_NUMERIC_SYMBOL => (1 +< 9),
  NFT_CTX_OUTPUT_NUMERIC_TIME   => (1 +< 10),
  NFT_CTX_OUTPUT_NUMERIC_ALL    => (1 +< 7 +| 1 +< 8 +| 1 +< 9 +| 1 +< 10),
  NFT_CTX_OUTPUT_TERSE          => (1 +< 11),
);

constant NFT_OPTIMIZE_ENABLED is export = 1;
constant NFT_CTX_DEFAULT      is export = 0;
