#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ui.h>

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

static void clicked(uiButton *b, void *c)
{
	printf("clicked [%c]\n", *(char *)c);
}

int main(void)
{
	uiInitOptions o;
	const char *err;

	memset(&o, 0, sizeof (uiInitOptions));
	err = uiInit(&o);
//	err = uiInit(NULL);
	if (err != NULL) {
		fprintf(stderr, "error initializing ui: %s\n", err);
		uiFreeInitError(err);
		return 1;
	}

	uiOnShouldQuit(shouldQuit, NULL);

	mainwin = uiNewWindow("libui Histogram Example", 10, 10, 1);
//	uiWindowSetMargined(mainwin, 1);
    uiWindowSetResizeable(mainwin, 0);

	uiWindowOnClosing(mainwin, onClosing, NULL);

//    uiWindowOnKey()

	uiBox *vbox = uiNewVerticalBox();
//	uiBoxSetPadded(vbox, 1);
	uiWindowSetChild(mainwin, uiControl(vbox));

        uiLabel *l = uiNewLabel("1234567890");
	    uiBoxAppend(vbox, uiControl(l), 1);

	    uiBox *hbox = uiNewHorizontalBox();
//	    uiBoxSetPadded(hbox, 1);
	    uiBoxAppend(vbox, uiControl(hbox), 1);

            uiButton *b1 = uiNewButton("1");
			uiButtonOnClicked(b1, clicked, (void *)"1");
	        uiBoxAppend(hbox, uiControl(b1), 1);

            uiButton *b2 = uiNewButton("2");
			uiButtonOnClicked(b2, clicked, (void *)"2");
	        uiBoxAppend(hbox, uiControl(b2), 1);

	        uiButton *b3 = uiNewButton("3");
			uiButtonOnClicked(b3, clicked, (void *)"3");
	        uiBoxAppend(hbox, uiControl(b3), 1);

	        uiButton *b_div = uiNewButton("/");
			uiButtonOnClicked(b_div, clicked, (void *)"/");
	        uiBoxAppend(hbox, uiControl(b_div), 1);

	    uiBox *hbox2 = uiNewHorizontalBox();
//	    uiBoxSetPadded(hbox2, 1);
	    uiBoxAppend(vbox, uiControl(hbox2), 1);

            uiButton *b4 = uiNewButton("4");
			uiButtonOnClicked(b4, clicked, (void *)"4");
	        uiBoxAppend(hbox2, uiControl(b4), 1);

            uiButton *b5 = uiNewButton("5");
			uiButtonOnClicked(b5, clicked, (void *)"5");
	        uiBoxAppend(hbox2, uiControl(b5), 1);

	        uiButton *b6 = uiNewButton("6");
			uiButtonOnClicked(b6, clicked, (void *)"6");
	        uiBoxAppend(hbox2, uiControl(b6), 1);

	        uiButton *b_mul = uiNewButton("*");
			uiButtonOnClicked(b_mul, clicked, (void *)"*");
	        uiBoxAppend(hbox2, uiControl(b_mul), 1);

	    uiBox *hbox3 = uiNewHorizontalBox();
//	    uiBoxSetPadded(hbox3, 1);
	    uiBoxAppend(vbox, uiControl(hbox3), 1);

            uiButton *b7 = uiNewButton("7");
			uiButtonOnClicked(b7, clicked, (void *)"7");
	        uiBoxAppend(hbox3, uiControl(b7), 1);

            uiButton *b8 = uiNewButton("8");
			uiButtonOnClicked(b8, clicked, (void *)"8");
	        uiBoxAppend(hbox3, uiControl(b8), 1);

	        uiButton *b9 = uiNewButton("9");
			uiButtonOnClicked(b9, clicked, (void *)"9");
	        uiBoxAppend(hbox3, uiControl(b9), 1);

	        uiButton *b_plus = uiNewButton("+");
			uiButtonOnClicked(b_plus, clicked, (void *)"+");
	        uiBoxAppend(hbox3, uiControl(b_plus), 1);

	    uiBox *hbox4 = uiNewHorizontalBox();
//	    uiBoxSetPadded(hbox4, 1);
	    uiBoxAppend(vbox, uiControl(hbox4), 1);

            uiButton *b_colon = uiNewButton(",");
			uiButtonOnClicked(b_colon, clicked, (void *)",");
	        uiBoxAppend(hbox4, uiControl(b_colon), 1);

            uiButton *b0 = uiNewButton("0");
			uiButtonOnClicked(b0, clicked, (void *)"0");
	        uiBoxAppend(hbox4, uiControl(b0), 1);

	        uiButton *b_assign = uiNewButton("=");
			uiButtonOnClicked(b_assign, clicked, (void *)"=");
	        uiBoxAppend(hbox4, uiControl(b_assign), 1);

	        uiButton *b_minus = uiNewButton("-");
			uiButtonOnClicked(b_minus, clicked, (void *)"-");
	        uiBoxAppend(hbox4, uiControl(b_minus), 1);

	uiControlShow(uiControl(mainwin));
	uiMain();
	uiUninit();
	return 0;
}
