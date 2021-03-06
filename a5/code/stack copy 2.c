#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct Element {
    char   *name;
    struct Element *next;
};

struct Element *top = 0;

void push (char* aName) {
    struct Element* e = malloc (sizeof (struct Element));    // Not the bug: sizeof (*e) == sizeof(struct Element)
    e->name = aName;
    e->next  = top;
    top = e;
}

char* pop() {
    struct Element* e = top;
    top = e->next;
    char *elementname = e->name;
    free (e);
    return elementname;
}

int main (int argc, char** argv) {
    push ("A");
    push ("B");
    char* w = pop();
    push ("C");
    push ("D");
    char* x = pop();
    char* y = pop();
    char* z = pop();
    printf ("%s %s %s %s\n", w, x, y, z);
}
