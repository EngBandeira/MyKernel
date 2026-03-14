#include <stdint.h>
#include <stdio.h>
#include "drivers/io.h"
#include "drivers/memory.h"
#include "drivers/tables.h"

extern void _PG_DIR;

void _int_callback0(){}
void _int_callback1(){}
void _int_callback2(){}
void _int_callback3(){}
void _int_callback4(){}
void _int_callback5(){}
void _int_callback6(){}
void _int_callback7(){}
void _int_callback8(){}
void _int_callback9(){}
void _int_callback10(){}
void _int_callback11(){}
void _int_callback12(){}
void _int_callback13(){}

// PAGE FAULT
void _int_callback14(){
    char *addr = (char*)read_cr2();
    uint32_t pg_dir_i, pg_tbl_i, offset;
    char *p_addr;
    v_addr_get_is(addr, &pg_dir_i, &pg_tbl_i, &offset);
    uint32_t *pg_dir_entry = ((uint32_t *)&_PG_DIR) + pg_dir_i;

    if(!(*pg_dir_entry & PAGE_DIR_PRESENT)) {
        uint32_t *p = (uint32_t*)malloc(4096);
        set_page_table_entry(0, (char*)p, PAGE_TABLE_GLOBAL | PAGE_TABLE_PRESENT | PAGE_TABLE_READ_WRITE);
        set_pg_dir_entry(pg_dir_i,  p, PAGE_DIR_PRESENT | PAGE_DIR_READ_WRITE | PAGE_DIR_USER);
    }



        // uint32_t *pg_table = (uint32_t*)(pg_dir[pg_dir_index] & (~0xFFF));
        // char *page = (char*)(pg_table[pg_table_index] & (~0xFFF));
        // return page + offset;


    uint32_t *pg_table = (uint32_t*)(*pg_dir_entry & (~0xFFF));
    uint32_t pg_table_entry = pg_table[pg_tbl_i];

    if(!(pg_table_entry & PAGE_TABLE_PRESENT)) {
        set_page_table_entry(, p_addr, PAGE_TABLE_GLOBAL | PAGE_TABLE_PRESENT | PAGE_TABLE_READ_WRITE);
    }

    if((*pg_dir_entry & PAGE_DIR_PRESENT) && (pg_table_entry & PAGE_TABLE_PRESENT))
        send_error();
}
void _int_callback15(){}
void _int_callback16(){}
void _int_callback17(){}
void _int_callback18(){}
void _int_callback19(){}
void _int_callback20(){}
void _int_callback21(){}
void _int_callback22(){}
void _int_callback23(){}
void _int_callback24(){}
void _int_callback25(){}
void _int_callback26(){}
void _int_callback27(){}
void _int_callback28(){}
void _int_callback29(){}
void _int_callback30(){}
void _int_callback31(){}
