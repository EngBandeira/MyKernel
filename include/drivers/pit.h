#ifndef DRIVERS_PIT
#define DRIVERS_PIT

#include <stdint.h>

void init_pit();
void set_count_pit(uint16_t hz);

#endif
