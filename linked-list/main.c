#include <stdio.h>
#include <stdlib.h>

extern struct list_head
{
	struct list_head *next;
	struct list_head *prev;
};

extern void init_list(struct list_head *list);
extern void list_add(struct list_head *new, struct list_head *head);
extern void list_del(struct list_head *entry);

/*void list_add(struct list_head *new, struct list_head *head)
{
	new->next = head->next;
	new->prev = head;
	if (head->next)
		head->next->prev = new;
	head->next = new;
}*/

int main(void)
{
	struct list_head test;
	struct list_head test2;
	init_list(&test);
	list_add(&test2, &test);
	struct list_head test3;
	list_add(&test3, &test2);
	list_del(&test2);
	return 0;
}
