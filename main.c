#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>
#include "hashtable.h"

static const char* FILENAME = "onegin.txt";

enum {
    MAX_WORD_COUNT = 64000,
    MAX_WORD_SIZE  = 64
};

enum {
    ERR_OK    = 0,
    ERR_FOPEN = 1
};

static int load_wordbuf(const char* filename, char buf[][MAX_WORD_SIZE], size_t* cnt);

HtItem * ht_supersearch(HashTable * hashTable, const char * str);

#define $timed(code) \
    {\
    clock_t begin = clock();\
    { code; }\
    clock_t end = clock();\
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;\
    printf("Total run time: %lg\n", time_spent);\
    }

int main() {

$timed (
    char buf[MAX_WORD_COUNT][MAX_WORD_SIZE] = {};
    HashTable ht  = {};
    size_t    cnt = 0;
    srand(time(NULL));

    if (load_wordbuf(FILENAME, buf, &cnt) != ERR_OK) {
        puts("Zhpa\n");
        getchar();
    }

    for (size_t i = 0; i < cnt; i++)
        ht_insert(&ht, buf[i]);

    for (unsigned i = 0; i < 1000000; i++){
	    char * s = buf[rand() % BUCKET_COUNT];
	    //printf("My %s ", s);
        HtItem* elem = ht_supersearch(&ht, s);
        //printf("Found %s\n", elem->str);
    }
    )

    return 0;
}

int load_wordbuf(const char* filename, char buf[][MAX_WORD_SIZE], size_t* cnt) {
    assert(filename);
    assert(buf);

    FILE* f = fopen(filename, "r");
    if (!f)
        return ERR_FOPEN;

    size_t i = 0;
    while (i < MAX_WORD_COUNT && fscanf(f, "%63s", buf[i]) == 1) {
        i++;
    }
    *cnt = i;

    fclose(f);

    return ERR_OK;
}
