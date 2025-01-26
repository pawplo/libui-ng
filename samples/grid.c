#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ui.h>
#include <stdbool.h>

uiWindow *mainwin;

static int onClosing(uiWindow *w, void *data)
{
	uiControlDestroy(uiControl(mainwin));
	uiQuit();
	return 0;
}

static int shouldQuit(void *data)
{
	uiControlDestroy(uiControl(mainwin));
	return 1;
}

int main(void)
{
	uiInitOptions o;
	const char *err;

	memset(&o, 0, sizeof (uiInitOptions));
	err = uiInit(&o);
	if (err != NULL) {
		fprintf(stderr, "error initializing ui: %s\n", err);
		uiFreeInitError(err);
		return 1;
	}

	uiOnShouldQuit(shouldQuit, NULL);

	mainwin = uiNewWindow("libui Histogram Example", 10, 10, 1);
    uiWindowSetPosition(mainwin, 300, 300);
    uiWindowSetResizeable(mainwin, 0);

	uiWindowOnClosing(mainwin, onClosing, NULL);

    uiGrid *grid = uiNewGrid();
	uiWindowSetChild(mainwin, uiControl(grid));

#define GRID(n, T, left, top, xspan, yspan, hexpand, halign, vexpand, valign) \
    uiButton *b ## n = uiNewButton(T); \
    uiGridAppend(grid, uiControl(b ## n), left, top, xspan, yspan, hexpand, halign, vexpand, valign);

    GRID(1,       "1", 0, 0, 1, 1, false, uiAlignFill, false, uiAlignFill);
    GRID(2,	      "2", 1, 0, 1, 1, false, uiAlignFill, false, uiAlignFill);
    GRID(3,	      "3", 2, 0, 1, 1, false, uiAlignFill, false, uiAlignFill);
    GRID(_plus,   "+", 3, 0, 1, 1, false, uiAlignFill, false, uiAlignFill);

    GRID(4,	      "4", 0, 1, 1, 1, false, uiAlignFill, false, uiAlignFill);
    GRID(5,	      "5", 1, 1, 1, 1, false, uiAlignFill, false, uiAlignFill);
    GRID(6,	      "6", 2, 1, 1, 1, false, uiAlignFill, false, uiAlignFill);
    GRID(_minus,  "-", 3, 1, 1, 1, false, uiAlignFill, false, uiAlignFill);

    GRID(7,	      "7", 0, 2, 1, 1, false, uiAlignFill, false, uiAlignFill);
    GRID(8,	      "8", 1, 2, 1, 1, false, uiAlignFill, false, uiAlignFill);
    GRID(9,	      "9", 2, 2, 1, 1, false, uiAlignFill, false, uiAlignFill);
    GRID(_mul,	  "*", 3, 2, 1, 1, false, uiAlignFill, false, uiAlignFill);

    GRID(_colon,  ",", 0, 3, 1, 1, false, uiAlignFill, false, uiAlignFill);
    GRID(0,       "0", 1, 3, 1, 1, false, uiAlignFill, false, uiAlignFill);
    GRID(_assign, "=", 2, 3, 1, 1, false, uiAlignFill, false, uiAlignFill);
    GRID(_div,    "/", 3, 3, 1, 1, false, uiAlignFill, false, uiAlignFill);

	uiControlShow(uiControl(mainwin));
	uiMain();
	uiUninit();
	return 0;
}
