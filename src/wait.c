#include "wait.h"
#include "drivers/io.h"
#include "drivers/pit.h"
#include "time.h"
#include <stdint.h>

void wait(uint8_t s) {
    sti();
    uint32_t sa = ticks + s * 18;
    while(sa > ticks);
}
void waitt(uint8_t tick) {
    sti();
    uint32_t sa = ticks + tick;
    while(sa > ticks);
}
