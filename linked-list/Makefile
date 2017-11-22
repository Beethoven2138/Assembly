list: main.o list.o
	gcc -o list main.o list.o -g

list.o: list.asm
	nasm -f elf64 -o list.o list.asm -g

main.o: main.c
	gcc -c main.c -g

clean:
	rm -rf *.o list
