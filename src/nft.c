#include <stdio.h>
#include <stdlib.h>
#include <nftables/libnftables.h>

static FILE *output_fp = NULL;
static FILE *output_oldfp = NULL;
static FILE *error_fp = NULL;
static FILE *error_oldfp = NULL;

int mnft_ctx_set_output(struct nft_ctx *ctx, const char *filename)
{
  if((output_fp = fopen(filename, "w")) == NULL) return 0;
  output_oldfp = nft_ctx_set_output(ctx, output_fp);
  if(output_fp != NULL){
    return 1;
  }else{
    return 0;
  }
}

int mnft_ctx_reset_output(void)
{
  if(output_oldfp != NULL){
    output_fp = output_oldfp;
    return 1;
  }else{
    return 0;
  }
}

int mnft_ctx_set_error(struct nft_ctx *ctx, const char *filename)
{
  if((error_fp = fopen(filename, "w")) == NULL) return 0;
  error_oldfp = nft_ctx_set_error(ctx, error_fp);
  if(error_fp != NULL){
    return 1;
  }else{
    return 0;
  }
}

int mnft_ctx_reset_error(void)
{
  if(error_oldfp != NULL){
    error_fp = error_oldfp;
    return 1;
  }else{
    return 0;
  }
}
