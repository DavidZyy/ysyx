#ifndef __COMMON_H__
#define __COMMON_H__

#include <stdint.h>
#include "conf.h"
#include "macro.h"
#include <inttypes.h>

typedef MUXDEF(CONFIG_ISA64, uint64_t, uint32_t) word_t;
typedef MUXDEF(CONFIG_ISA64, int64_t, int32_t)  sword_t;

typedef word_t vaddr_t;
typedef word_t paddr_t;

#define FMT_WORD  MUXDEF(CONFIG_ISA64, "0x%016"PRIx64, "0x%08"PRIx32)
#define FMT_PADDR MUXDEF(CONFIG_ISA64, "0x%016"PRIx64, "0x%08"PRIx32)


#endif
