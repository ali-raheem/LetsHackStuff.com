#ifndef LINKEDLIST_H
#define LINKEDLIST_H

typedef struct _element *element;
struct _element{
        element next;
        element prev;
        int id;
};

typedef struct _list *list;
struct _list{
	element firstElement;
	element lastElement;
};

element addElement(list List);
void unlinkElement(list List, element Element);
void editElement(element Element, int id);
element delElement(element Element);
element findElement(list List, int id);
void printList(list List);
void printElement(element Element);

#endif
