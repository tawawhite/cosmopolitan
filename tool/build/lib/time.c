/*-*- mode:c;indent-tabs-mode:nil;c-basic-offset:2;tab-width:8;coding:utf-8 -*-│
│vi: set net ft=c ts=2 sts=2 sw=2 fenc=utf-8                                :vi│
╞══════════════════════════════════════════════════════════════════════════════╡
│ Copyright 2020 Justine Alexandra Roberts Tunney                              │
│                                                                              │
│ Permission to use, copy, modify, and/or distribute this software for         │
│ any purpose with or without fee is hereby granted, provided that the         │
│ above copyright notice and this permission notice appear in all copies.      │
│                                                                              │
│ THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL                │
│ WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED                │
│ WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE             │
│ AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL         │
│ DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR        │
│ PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER               │
│ TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR             │
│ PERFORMANCE OF THIS SOFTWARE.                                                │
╚─────────────────────────────────────────────────────────────────────────────*/
#include "libc/calls/calls.h"
#include "libc/nexgen32e/rdtsc.h"
#include "libc/sysv/consts/clock.h"
#include "libc/time/time.h"
#include "tool/build/lib/endian.h"
#include "tool/build/lib/modrm.h"
#include "tool/build/lib/time.h"

/**
 * @fileoverview i am the timelorde
 */

void OpPause(struct Machine *m, uint32_t rde) {
  sched_yield();
}

void OpRdtsc(struct Machine *m, uint32_t rde) {
  uint64_t c;
  struct timespec ts;
  clock_gettime(CLOCK_MONOTONIC, &ts);
  c = ts.tv_sec * 1000000000 + ts.tv_nsec;
  Write64(m->ax, (c >> 000) & 0xffffffff);
  Write64(m->dx, (c >> 040) & 0xffffffff);
}

static int64_t GetTscAux(struct Machine *m) {
  uint32_t core, node;
  core = 0;
  node = 0;
  return (node & 0xfff) << 12 | (core & 0xfff);
}

void OpRdtscp(struct Machine *m, uint32_t rde) {
  OpRdtsc(m, rde);
  Write64(m->cx, GetTscAux(m));
}

void OpRdpid(struct Machine *m, uint32_t rde) {
  Write64(RegRexbRm(m, rde), GetTscAux(m));
}
