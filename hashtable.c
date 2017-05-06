#include "hashtable.h"
#include <stddef.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>


static unsigned superhash(const char * value){
    asm(".intel_syntax noprefix\n\t"

    "xor	r8, r8\n\t"
    "xor	rbx, rbx\n\t"
    ".loop:\n\t"
    //"mov	rax, [rdi+r8]\n\t"
    "mov rsi, rdi\n\t"
    "lodsb\n\t"
    "test	al, al\n\t"
    "je	.break\n\t"
    "cmp	al, 10\n\t"
    "je	.break\n\t"
    "cmp	al, 32\n\t"
    "je	.break\n\t"
    "cmp 	al, 'A'\n\t"
    "jb	.break\n\t"
    "cmp	al, 'z'\n\t"
    "ja	.break\n\t"
    "cmp	al, 'Z'\n\t"
    "jb	.lbl\n\t"
    "cmp al, 'a'\n\t"
    "jb	.break\n\t"
    ".lbl:\n\t"
    "ror	rbx, 1\n\t"
    "xor	rbx, rax\n\t"
    //"inc	r8\n\t"
    "jmp	.loop\n\t"
    ".break:\n\t"
    "mov	rax, rbx\n\t"
    "xor    rdx, rdx\n\t"
    "mov    rbx, 0x1fff\n\t"
    "div    rbx\n\t"
    "mov    rax, rdx\n\t"




    ".att_syntax\n\t"
    :
    :
    : "%rax", "%r8", "%rdi", "%rbx", "%rbx");
}


static unsigned hash(const char* value) {
    int i = 0;
    int hashval = 0;
    while (1){
        if (value[i] == '\0') break;
        if (value[i] == '\n') break;
        if (value[i] == ' ') break;
        if (ispunct(value[i])) break;
        int a = (int) value[i];
        int b = hashval << 1;
        int c = hashval >> 31;
        hashval = b | c;
        hashval = hashval ^ a;
        i++;
    }

    return hashval % BUCKET_COUNT;
}



HtItem* ht_search(HashTable* ht, const char* s) {
    HtItem*  ptr  = NULL;
    unsigned h    = superhash(s);
    //printf("Hash %u\n", h);

    for (ptr = ht->buckets[h]; ptr != NULL; ptr = ptr->next)
        if (strcmp(s, ptr->str) == 0) {
            //printf("%s found!\n", s);
            return ptr;
        }
    return NULL;
}

HtItem* ht_supersearch(HashTable* ht, const char* s){
    asm(".intel_syntax noprefix\n\t"
    "push rsi\n\t"
    "push rdi\n\t"
    "mov	rdi, rsi\n\t"
    "call	superhash\n\t"
    "pop rdi\n\t"
    "pop rsi\n\t"//rdi - ht, rsi - string, rax - hash

    "mov r8, [r8*8+rdi]\n\t"//there is first elem with an appropriate hash
    ".loop_search:\n\t"
    "test r8, r8\n\t"
    "je .loop_search_end\n\t"
    "mov rbx, [r8+8]\n\t"//*(char*)
    "xor rcx, rcx\n\t"
    "cld\n\t"
    "mov rdi, rsi\n\t"
    "xor al, al\n\t"
    "mov rcx, 0x51\n\t"
    "repne scasb\n\t"
    "mov r9, rdi\n\t"
    "sub r9, rsi\n\t"//strlen1
    "mov rdi, rbx\n\t"
    "xor al, al\n\t"
    "mov rcx, 100\n\t"
    "repne scasb\n\t"
    "mov r10, rdi\n\t"
    "sub r10, rbx\n\t"    //strlen2
    "cmp r9, r10\n\t"
    "jne .not_equal\n\t"
    "cld\n\t"
    "mov rcx, r9\n\t"
    "mov rdi, r8\n\t"
    "repe cmpsb \n\t"
    "je .loop_search_end\n\t"



/*
    ".loop_strcmp:\n\t"
    "mov rdx, [rbx+rcx]\n\t"
    "test rdx, rdx\n\t"
    "je .value_end\n\t"
    "mov rdx, [rsi+rcx]\n\t"
    "test rdx, rdx\n\t"
    "je .not_equal\n\t"
    "inc rcx\n\t"
    "jmp .loop_strcmp\n\t"
    ".value_end:\n\t"
    "mov rdx, [rsi+rcx]\n\t"
    "test rdx, rdx\n\t"
    "je .loop_search_end\n\t"*/
    ".not_equal:\n\t"
    "mov r8, [r8]\n\t"
    "jmp .loop_search\n\t"
    ".loop_search_end:\n\t"

    ".att_syntax\n\t"
    :
    :
    : "%rax", "%rcx", "%rdi", "r8", "%rsi", "%rbx");
}

int ht_insert(HashTable* ht, const char* s) {
    if (ht_search(ht, s) == NULL) {
        HtItem* item = (HtItem*)calloc(1, sizeof(*item));
        unsigned h = superhash(s);
        item->next = ht->buckets[h];
        item->str  = s;
        ht->buckets[h] = item;
    }
    return 0;
}

