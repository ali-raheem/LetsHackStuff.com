#include <stdio.h>
#include "linkedList.h"
/*
uses linkedList to create a doubly linked list.
*/
int main(){
	list List = newList();
	element Element;
	Element = addElement(List);
	editElement(Element, 0);
	Element = addElement(List);
	editElement(Element, 1);
	Element = addElement(List);
	editElement(Element, 2);
	Element = addElement(List);
	editElement(Element, 3);
	printList(List);
	unlinkElement(List, Element);
	delElement(Element);
	Element = addElement(List);
	editElement(Element, 3);
	printList(List);
	element first = findElement(List, 0);
	if(first != NULL) unlinkElement(List, first);
	delElement(Element);
	printList(List);
	editElement(Element, 56);
	printList(List);
	printf("Create a second list\n");
	list List2 = newList();
	Element = addElement(List2);
	editElement(Element,32);
	Element = addElement(List2);
	editElement(Element,3);
	Element = addElement(List2);
	editElement(Element,2);
	printList(List2);
}
