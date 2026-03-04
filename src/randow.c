#include "randow.h"
#include <stdint.h>
#include "time.h"

uint8_t randu8(uint8_t c) {
    return (c * ticks) % 255;
}
