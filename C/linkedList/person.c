#include <stdlib.h>
#include <stdio.h>
#include "person.h"

person addPerson(int id){
	/* Attach element to end of list*/
	person self = (person) malloc(sizeof(person));
	self->id = id;
	self->next = NULL;
	self->prev = lastPerson;
	lastPerson = self;
	if(firstPerson == NULL){
		firstPerson = self;
	}else{
		self->prev->next = self;
	}
	return self;
}

person delPerson(person self){
	/* Remove element, link list*/
	if(self == NULL)
		return NULL;
	if(lastPerson == self){
		lastPerson = self->prev;
	}else{
		self->next->prev = self->prev;
	}
	if(firstPerson == self){
		firstPerson = self->next;
	}else{
		self->prev->next = self->next;
	}
	free(self);
	return NULL;
}

person findPerson(int id){
	/*findPersonById return pointer to person*/
	person node = firstPerson;
	while(node != NULL && node->id != id)
		node = node->next;
	return node;
}

void editPerson(person self, int id){
	self->id = id;
}

void displayPerson(person self){
	printf("Person:\n\tid:\t%d.\n",self->id);
}

void swapPerson(person A, person B){
	/*swap positions A and B */
	person tempA;
	if(A!=firstPerson)
		A->prev->next = B;
	if(A!=lastPerson)
		A->next->prev = B;
	if(B!=firstPerson)
		B->prev->next = A;
	if(B!=lastPerson)
		B->next->prev = A;

	tempA = A->prev;
	A->prev = B->prev;
	B->prev = tempA;

	tempA = A->next;
	A->next = B->next;
	B->next = tempA;
}
