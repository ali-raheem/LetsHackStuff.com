#include <stdlib.h>
#include <stdio.h>
#include "element.h"

element addElement(list List){
	element newElement = (element) malloc(sizeof(element));
	newElement->prev = List->lastElement;
	newElement->next = NULL;
	List->lastElement = newElement;
	if(List->firstElement == NULL){
		List->firstElement = newElement;
	}else{
		newElement->prev->next = newElement;
	}
	return newElement;
}

void unlinkElement(list List, element Element){
	if(Element == NULL)
		return;
	if(List->firstElement != Element){
		Element->prev->next = Element->next;
	}else{
		List->firstElement = Element->next;
	}
	if(List->lastElement != Element){
		Element->next->prev = Element->prev;
	}else{
		List->lastElement = Element->prev;
	}
}

element delElement(element Element){
	free(Element);
	return NULL;
}

void editElement(element Element, int id){
	if(Element != NULL)
		Element->id = id;
}

element findElement(list List, int id){
	element Element = List->firstElement;
	while(Element != NULL){
		if(Element->id == id)
			break;
		Element = Element->next;
	}
	return Element;
}

void printList(list List){
	element Element = List->firstElement;
	while(Element != NULL){
		printElement(Element);
		Element = Element->next;
	}
}

void printElement(element Element){
	if(Element == NULL)
		return;
	printf("Element: 0x%x\n",Element);
	printf("\tNext: 0x%x\n",Element->next);
	printf("\tPrev: 0x%x\n",Element->prev);
	printf("\tID: %i\n\n",Element->id);
}

list newList(){
        list List = (list) malloc(sizeof(list));
        List->firstElement = NULL;
        List->lastElement = NULL;
        return List;
}

list delList(list List){
	/*Memory leak if you don't free the elements first!
	But now all the elements are dangling :/ */
	element Element = List->firstElement;
	while(Element != NULL){
		delElement(Element);
		Element = Element->next;
	}
	free(List);
	return NULL;
}
