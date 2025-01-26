#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#include <ui.h>

uiWindow *mainwin;
uiLabel *l;
uiLabel *l_operator;

#define L_LEN_MAX 255
char l_text[L_LEN_MAX + 1];
int l_index = 0;

char operator;
double operands[2];
bool save_reset = false;

bool last_operator = false;
bool last_assign = false;

bool has_colon = false;

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


void save_operand(int i)
{
    operands[i] = strtod(l_text, NULL);
    printf("operand[%d] == %lf\n", i, operands[i]);
}

void save(void)
{
	save_operand(1);
	if (!save_reset) {
    	save_operand(0);
		save_reset = true;
	}
}

void clear(void)
{
	for (int i = 0; i < L_LEN_MAX; i++) {
		l_text[i] = 0;
	}
	l_index = 0;
	has_colon = false;
}

void add(char *c)
{
	if (l_index == L_LEN_MAX) return;
	if (*c == ',') {
		if (has_colon) return;
		if (l_index == 0) return;
		has_colon = true;
	}
	l_text[l_index] = *(char *)c;
    l_index++;
    uiLabelSetText(l, l_text);
}

static void clicked(uiButton *b, void *c)
{
	if (*(char *)c == ',' || (*(char *)c >= '0' && *(char *)c <= '9')) {
		if (last_operator || last_assign) {
			clear();
			last_operator = false;
		    last_assign = false;
		}
		add((char *)c);
		return;
	}

    switch (*(char *)c) {
		case '+':
		case '-':
		case '*':
		case '/':
		    operator = *(char *)c;
		    if (!last_assign && !last_assign) {
				save_reset = false;
    			save();
			}
			last_operator = true;
		    break;
		case '=':
		    if (!last_assign && !last_assign) {
    			save();
			}
            clear();
    		switch (operator) {
            	case '+':
    			    operands[0] += operands[1];
            	    break;
            	case '-':
    			    operands[0] -= operands[1];
            	    break;
            	case '*':
    			    operands[0] *= operands[1];
            	    break;
            	case '/':
    			    operands[0] /= operands[1];
            	    break;
    		}
    		printf("value = %lg\n", operands[0]);
    		sprintf(l_text, "%lg", operands[0]);
            uiLabelSetText(l, l_text);
			last_assign = true;
		    break;
	}
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

    operator = 'n';

	mainwin = uiNewWindow("libui Histogram Example", 10, 10, 1);
    uiWindowSetPosition(mainwin, 300, 300);
    uiWindowSetResizeable(mainwin, 0);

	uiWindowOnClosing(mainwin, onClosing, NULL);

	uiBox *vbox = uiNewVerticalBox();
	uiWindowSetChild(mainwin, uiControl(vbox));

        l = uiNewLabel("");
	    uiBoxAppend(vbox, uiControl(l), 1);

#define HBOX(h) \
	    uiBox *hbox ## h = uiNewHorizontalBox(); \
	    uiBoxAppend(vbox, uiControl(hbox ## h), 1);


#define BUTTON(h, B, T) \
            uiButton *b ## B = uiNewButton(T); \
			uiButtonOnClicked(b ## B, clicked, (void *)T); \
	        uiBoxAppend(hbox ## h, uiControl(b ## B), 1);

        HBOX(1)
			BUTTON(1,1,"1")
			BUTTON(1,2,"2")
			BUTTON(1,3,"3")
			BUTTON(1,_plus,"+")


        HBOX(2)
			BUTTON(2,4,"1")
			BUTTON(2,5,"5")
			BUTTON(2,6,"6")
			BUTTON(2,_minus,"-")


        HBOX(3)
			BUTTON(3,7,"7")
			BUTTON(3,8,"8")
			BUTTON(3,9,"9")
			BUTTON(3,_mul,"*")

        HBOX(4)
			BUTTON(4,_colon,",")
			BUTTON(4,0,"0")
			BUTTON(4,_assign,"=")
			BUTTON(4,_div,"/")

	uiControlShow(uiControl(mainwin));
	uiMain();
	uiUninit();
	return 0;
}
