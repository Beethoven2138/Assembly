heap: main.o heap.o
	gcc -o heap main.o heap.o -g

heap.o: heap.asm
	nasm -f elf64 -o heap.o heap.asm

main.o: main.c
	gcc -c main.c -g

clean:
	rm -rf *.o heap
