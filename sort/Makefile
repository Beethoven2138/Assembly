bubble: main.o bubble.o
	gcc -o bubble main.o bubble.o -m32 -g

bubble.o: bubble.asm
	nasm -f elf -o bubble.o bubble.asm

main.o: main.c
	gcc -m32 -c main.c -g

clean:
	rm -rf *.o bubble
