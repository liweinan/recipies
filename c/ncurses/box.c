#include <ncurses.h>

int main(void) {
	initscr();
	box(stdscr, '|','-');
	refresh();
	getch();
	endwin();
	return 0;
}
