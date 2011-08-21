#ifndef PERSON_H
#define PERSON_H

typedef struct _person *person;
struct _person{
        person  next;
        person  prev;
        int     id;
};

static person lastPerson, firstPerson = NULL;
person addPerson(int id);
person delPerson();
person findPerson(int id);
void editPerson(person self, int newId);
void displayPerson(person self);
void swapPerson(person A, person B);

#endif
