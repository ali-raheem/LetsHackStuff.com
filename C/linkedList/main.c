#include <stdio.h>
#include "person.h"

int main(){
	addPerson(0);
	addPerson(1);
	addPerson(2);
	person Person = findPerson(2);
	Person = delPerson(Person);
	delPerson(Person);
	Person = findPerson(2);
	if(Person != NULL){
		displayPerson(Person);
	}else{
		printf("Person not found!\n");
	}
	addPerson(101);
	Person = findPerson(101);
	person B = findPerson(1);
	if(Person != NULL)
		displayPerson(Person);
	editPerson(Person,51);
	displayPerson(Person);
	swapPerson(Person, B);
	displayPerson(B);
	displayPerson(Person);
}
