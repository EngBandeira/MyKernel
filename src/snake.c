#include <stdint.h>

#include "drivers/vga_text.h"
#include "drivers/p2.h"
#include "randow.h"
#include "time.h"
#include "wait.h"
#include "snake.h"

#define MAX_SNAKE 100

typedef struct {
    int8_t x, y;
} Vec2;

typedef struct{
    Vec2 body[MAX_SNAKE];
    int length;
    Vec2 dir;
} Snake;

typedef struct{
    Vec2 pos;
} Fruit;

Snake snake;
Vec2 fruit;



void key_snake(char b) {
    switch (b) {
        case 'W': {
            snake.dir.x = 0;
            snake.dir.y = -1;
            break;
        }
        case 'S': {
            snake.dir.x = 0;
            snake.dir.y = 1;
            break;
        }
        case 'A': {
            snake.dir.x = -1;
            snake.dir.y = 0;
            break;
        }
        case 'D': {
            snake.dir.x = 1;
            snake.dir.y = 0;
            break;
        }
        default: {
            return;
        }
    }
}

void init_snake(int start_x, int start_y){
    set_callback(key_snake);
    snake.length = 3;

    snake.body[0].x = start_x;
    snake.body[0].y = start_y;

    snake.body[1].x = start_x - 1;
    snake.body[1].y = start_y;

    snake.body[2].x = start_x - 2;
    snake.body[2].y = start_y;

}

void move_snake(){
    if(snake.dir.x != 0 || snake.dir.y != 0){
        for(int i = snake.length -1; i > 0; i--){
            snake.body[i].x = snake.body[i-1].x;
            snake.body[i].y = snake.body[i-1].y;
        }
        snake.body[0].x += snake.dir.x;
        snake.body[0].y += snake.dir.y;
    }
}

bool check_colision(int width, int height){
    if (snake.body[0].x < 0) return true;
    if (snake.body[0].y < 0) return true;
    if (snake.body[0].x >= width) return true;
    if (snake.body[0].y >= height) return true;
    for(int i = 1; i < snake.length; i++){
        if(snake.body[0].x == snake.body[i].x && snake.body[0].y == snake.body[i].y ) return true;
    }
    return false;
}

void print_snake() {
    vga_clear(VGA_COLOR_CYAN);
    for(int i = snake.length - 1; i > 0; i--){
        vga_buffer[vga_indexing(snake.body[i].x, snake.body[i].y)] = vga_entry('O', vga_color(VGA_COLOR_RED, VGA_COLOR_RED));
        vga_buffer[vga_indexing(snake.body[i].x-1, snake.body[i].y)] = vga_entry('O', vga_color(VGA_COLOR_RED, VGA_COLOR_RED));
    }
    vga_buffer[vga_indexing(fruit.x, fruit.y)] = vga_entry('O', vga_color(VGA_COLOR_LIGHT_BLUE, VGA_COLOR_LIGHT_BLUE));
}


void check_fruit_colision() {
    if(snake.body[0].x == fruit.x && snake.body[0].y == fruit.y){
        if(snake.length < MAX_SNAKE)
            snake.length++;
        fruit.x = randu8(4) % VGA_WIDTH;
        fruit.y = randu8(7) % VGA_HEIGHT;
        move_snake();
        print_snake();
    }
}


void init_game(){
    init_snake(4, 5);
    snake.dir.x = 1;
    snake.dir.y = 0;
    fruit.x = VGA_WIDTH/2;
    fruit.y = VGA_HEIGHT/2;
    while(1) {
        move_snake();
        if(check_colision(VGA_WIDTH, VGA_HEIGHT)){
            return;
        }
        check_fruit_colision();
        print_snake();
        waitt(2);
    }
}
