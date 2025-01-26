#BUILD := ./build
BUILD := $(TMPDIR)/libui-ng

CC := gcc
CPP := g++
AR := ar
STRIP := strip

INC:=
SRC:=
SRC_M:=
SRC_CPP:=

EXE_SUFFIX:=
STRIP_FLAGS:= -R .reloc -R .pdata -R .xdata

INC+=common/attrstr.h
INC+=common/controlsigs.h
INC+=common/table.h
INC+=common/uipriv.h
INC+=common/utf.h

#SRC=common/OLD_table.c
SRC+=common/areaevents.c
SRC+=common/attribute.c
SRC+=common/attrlist.c
SRC+=common/attrstr.c
SRC+=common/control.c
SRC+=common/debug.c
SRC+=common/matrix.c
SRC+=common/opentype.c
SRC+=common/shouldquit.c
SRC+=common/table.c
SRC+=common/tablemodel.c
SRC+=common/tablevalue.c
SRC+=common/userbugs.c
SRC+=common/utf.c

LIB_STATIC:=libui.a

ifeq ($(TARGET),)
	ifeq ($(shell uname),Darwin)
		TARGET=DARWIN
	else ifeq ($(shell uname),Windows)
		TARGET=WINDOWS
	else
		TARGET=UNIX
	endif
endif

ifeq ($(TARGET),DARWIN)
    BUILD := $(BUILD)_darwin
    LDFLAGS+=-framework Cocoa -framework IOKit -framework CoreFoundation
    LIB_SHARED=libui.dylib
#    SRC_M+=darwin/OLD2_table.m
    SRC_M+=darwin/aat.m
    SRC_M+=darwin/alloc.m
    SRC_M+=darwin/area.m
    SRC_M+=darwin/areaevents.m
    SRC_M+=darwin/attrstr.m
    SRC_M+=darwin/autolayout.m
    SRC_M+=darwin/box.m
    SRC_M+=darwin/button.m
    SRC_M+=darwin/checkbox.m
    SRC_M+=darwin/colorbutton.m
    SRC_M+=darwin/combobox.m
    SRC_M+=darwin/control.m
    SRC_M+=darwin/datetimepicker.m
    SRC_M+=darwin/debug.m
    SRC_M+=darwin/draw.m
    SRC_M+=darwin/drawtext.m
    SRC_M+=darwin/editablecombo.m
    SRC_M+=darwin/entry.m
    SRC_M+=darwin/event.m
    SRC_M+=darwin/fontbutton.m
    SRC_M+=darwin/fontmatch.m
    SRC_M+=darwin/fonttraits.m
    SRC_M+=darwin/fontvariation.m
    SRC_M+=darwin/form.m
    SRC_M+=darwin/future.m
    SRC_M+=darwin/graphemes.m
    SRC_M+=darwin/grid.m
    SRC_M+=darwin/group.m
    SRC_M+=darwin/image.m
    SRC_M+=darwin/label.m
    SRC_M+=darwin/main.m
    SRC_M+=darwin/menu.m
    SRC_M+=darwin/multilineentry.m
    SRC_M+=darwin/nstextfield.m
    SRC_M+=darwin/opentype.m
    SRC_M+=darwin/progressbar.m
    SRC_M+=darwin/radiobuttons.m
    SRC_M+=darwin/scrollview.m
    SRC_M+=darwin/separator.m
    SRC_M+=darwin/slider.m
    SRC_M+=darwin/spinbox.m
    SRC_M+=darwin/stddialogs.m
    SRC_M+=darwin/tab.m
    SRC_M+=darwin/table.m
    SRC_M+=darwin/tablecolumn.m
    SRC_M+=darwin/text.m
    SRC_M+=darwin/undocumented.m
    SRC_M+=darwin/util.m
    SRC_M+=darwin/window.m
    SRC_M+=darwin/winmoveresize.m

    INC+=darwin/attrstr.h
    INC+=darwin/draw.h
    INC+=darwin/sierra.h
    INC+=darwin/table.h
    INC+=darwin/uipriv_darwin.h
    INC+=ui_darwin.h

else ifeq ($(TARGET),WINDOWS)
    BUILD:=$(BUILD)_windows
    CC:=x86_64-w64-mingw32-gcc
    CPP:=x86_64-w64-mingw32-g++
    AR:=x86_64-w64-mingw32-ar
    STRIP:=x86_64-w64-mingw32-strip

	EXE_SUFFIX:=.exe
	STRIP_FLAGS:=-g $(STRIP_FLAGS)

    LDFLAGS+= -luser32 -lkernel32 -lgdi32 -lcomctl32 -luxtheme -lmsimg32 -lcomdlg32 -ld2d1 -ldwrite -lole32 -loleaut32 -loleacc -luuid -lwindowscodecs
    LIB_SHARED:=libui.dll

    SRC_CPP+=windows/alloc.cpp
    SRC_CPP+=windows/area.cpp
    SRC_CPP+=windows/areadraw.cpp
    SRC_CPP+=windows/areaevents.cpp
    SRC_CPP+=windows/areascroll.cpp
    SRC_CPP+=windows/areautil.cpp
    SRC_CPP+=windows/attrstr.cpp
    SRC_CPP+=windows/box.cpp
    SRC_CPP+=windows/button.cpp
    SRC_CPP+=windows/checkbox.cpp
    SRC_CPP+=windows/colorbutton.cpp
    SRC_CPP+=windows/colordialog.cpp
    SRC_CPP+=windows/combobox.cpp
    SRC_CPP+=windows/container.cpp
    SRC_CPP+=windows/control.cpp
    SRC_CPP+=windows/d2dscratch.cpp
    SRC_CPP+=windows/datetimepicker.cpp
    SRC_CPP+=windows/debug.cpp
    SRC_CPP+=windows/draw.cpp
    SRC_CPP+=windows/drawmatrix.cpp
    SRC_CPP+=windows/drawpath.cpp
    SRC_CPP+=windows/drawtext.cpp
    SRC_CPP+=windows/dwrite.cpp
    SRC_CPP+=windows/editablecombo.cpp
    SRC_CPP+=windows/entry.cpp
    SRC_CPP+=windows/events.cpp
    SRC_CPP+=windows/fontbutton.cpp
    SRC_CPP+=windows/fontdialog.cpp
    SRC_CPP+=windows/fontmatch.cpp
    SRC_CPP+=windows/form.cpp
    SRC_CPP+=windows/graphemes.cpp
    SRC_CPP+=windows/grid.cpp
    SRC_CPP+=windows/group.cpp
    SRC_CPP+=windows/image.cpp
    SRC_CPP+=windows/init.cpp
    SRC_CPP+=windows/label.cpp
    SRC_CPP+=windows/main.cpp
    SRC_CPP+=windows/menu.cpp
    SRC_CPP+=windows/multilineentry.cpp
    SRC_CPP+=windows/opentype.cpp
    SRC_CPP+=windows/parent.cpp
    SRC_CPP+=windows/progressbar.cpp
    SRC_CPP+=windows/radiobuttons.cpp
    SRC_CPP+=windows/separator.cpp
    SRC_CPP+=windows/sizing.cpp
    SRC_CPP+=windows/slider.cpp
    SRC_CPP+=windows/spinbox.cpp
    SRC_CPP+=windows/stddialogs.cpp
    SRC_CPP+=windows/tab.cpp
    SRC_CPP+=windows/table.cpp
    SRC_CPP+=windows/tabledispinfo.cpp
    SRC_CPP+=windows/tabledraw.cpp
    SRC_CPP+=windows/tableediting.cpp
    SRC_CPP+=windows/tablemetrics.cpp
    SRC_CPP+=windows/tabpage.cpp
    SRC_CPP+=windows/text.cpp
    SRC_CPP+=windows/utf16.cpp
    SRC_CPP+=windows/utilwin.cpp
    SRC_CPP+=windows/window.cpp
    SRC_CPP+=windows/winpublic.cpp
    SRC_CPP+=windows/winutil.cpp

    INC+=windows/_uipriv_migrate.hpp
    INC+=windows/area.hpp
    INC+=windows/attrstr.hpp
    INC+=windows/compilerver.hpp
    INC+=windows/draw.hpp
    INC+=windows/resources.hpp
    INC+=windows/table.hpp
    INC+=windows/uipriv_windows.hpp
    INC+=windows/winapi.hpp
    INC+=ui_windows.h

else ifeq ($(TARGET),UNIX)
    BUILD:=$(BUILD)_unix
#    LDFLAGS+=
    LIB_SHARED=libui.so

#    SRC+=unix/OLD_table.c
    SRC+=unix/alloc.c
    SRC+=unix/area.c
    SRC+=unix/attrstr.c
    SRC+=unix/box.c
    SRC+=unix/button.c
    SRC+=unix/cellrendererbutton.c
    SRC+=unix/checkbox.c
    SRC+=unix/child.c
    SRC+=unix/colorbutton.c
    SRC+=unix/combobox.c
    SRC+=unix/control.c
    SRC+=unix/datetimepicker.c
    SRC+=unix/debug.c
    SRC+=unix/draw.c
    SRC+=unix/drawmatrix.c
    SRC+=unix/drawpath.c
    SRC+=unix/drawtext.c
    SRC+=unix/editablecombo.c
    SRC+=unix/entry.c
    SRC+=unix/fontbutton.c
    SRC+=unix/fontmatch.c
    SRC+=unix/form.c
    SRC+=unix/future.c
    SRC+=unix/graphemes.c
    SRC+=unix/grid.c
    SRC+=unix/group.c
    SRC+=unix/image.c
    SRC+=unix/label.c
    SRC+=unix/main.c
    SRC+=unix/menu.c
    SRC+=unix/multilineentry.c
    SRC+=unix/opentype.c
    SRC+=unix/progressbar.c
    SRC+=unix/radiobuttons.c
    SRC+=unix/separator.c
    SRC+=unix/slider.c
    SRC+=unix/spinbox.c
    SRC+=unix/stddialogs.c
    SRC+=unix/tab.c
    SRC+=unix/table.c
    SRC+=unix/tablemodel.c
    SRC+=unix/text.c
    SRC+=unix/util.c
    SRC+=unix/window.c

    INC+=unix/attrstr.h
    INC+=unix/draw.h
    INC+=unix/table.h
    INC+=unix/uipriv_unix.h
    INC+=ui_unix.h
else
    $(error echo TARGET != DARWIN | WINDOWS | UNIX)
endif

CFLAGS+=-I./
CFLAGS+=-Os

ifneq ($(TARGET),WINDOWS)
	CFLAGS+=-flto
	LDFLAGS+=-flto
endif

CFLAGS+=-ffunction-sections -fdata-sections

CC_VERSION := $(shell $(CC) --version)
ifeq ($(findstring clang,$(CC_VERSION)),)
    LDFLAGS+=-Wl,--gc-sections
else
    LDFLAGS+=-Wl,-dead_strip
endif

$(shell mkdir -p $(BUILD)/common)
$(shell mkdir -p $(BUILD)/darwin)
$(shell mkdir -p $(BUILD)/windows)
$(shell mkdir -p $(BUILD)/samples)

INC_API=ui.h

SRC_SAMPLES=$(shell ls samples/*.c)

OBJ := $(SRC:.c=.o)
OBJ_M := $(SRC_M:.m=.o_m)
OBJ_CPP := $(SRC_CPP:.cpp=.o_cpp)
OBJS = $(OBJ) $(OBJ_M) $(OBJ_CPP)
SAMPLES := $(SRC_SAMPLES:.c=$(EXE_SUFFIX))
SAMPLES_STATIC := $(SRC_SAMPLES:.c=_static$(EXE_SUFFIX))

BUILD_OBJ := $(addprefix $(BUILD)/, $(OBJ))
BUILD_OBJ_M := $(addprefix $(BUILD)/, $(OBJ_M))
BUILD_OBJ_CPP := $(addprefix $(BUILD)/, $(OBJ_CPP))
BUILD_OBJS = $(BUILD_OBJ) $(BUILD_OBJ_M) $(BUILD_OBJ_CPP)
BUILD_SAMPLES := $(addprefix $(BUILD)/, $(SAMPLES))
BUILD_SAMPLES_STATIC := $(addprefix $(BUILD)/, $(SAMPLES_STATIC))

$(BUILD)/darwin/%.o_m: darwin/%.m $(INC)
	$(CC) $(CFLAGS) -c -x objective-c $< -o $@

$(BUILD)/windows/%.o_cpp: windows/%.cpp $(INC)
	$(CPP) $(CFLAGS) -c $< -o $@

$(BUILD)/unix/%.o: unix/%.c $(INC)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD)/common/%.o: common/%.c $(INC)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD)/samples/%.o: samples/%.c $(INC)
	$(CC) $(CFLAGS) -c $< -o $@


.PHONE: all
ifeq ($(TARGET),WINDOWS)
all: $(BUILD)/$(LIB_STATIC)
else
all: $(BUILD)/$(LIB_STATIC) $(BUILD)/$(LIB_SHARED)
endif

$(BUILD)/samples/%$(EXE_SUFFIX): samples/%.c $(INC_API)
	$(CC) $< -o $@ $(CFLAGS) $(LDFLAGS) -L$(BUILD)/ -lui
	$(STRIP) $(STRIPFLAGS) $@

$(BUILD)/samples/%_static$(EXE_SUFFIX): samples/%.c $(INC_API) $(BUILD)/$(LIB_STATIC)
ifeq ($(TARGET),WINDOWS)
	$(CPP) -static -o $@ $< $(BUILD)/$(LIB_STATIC) $(CFLAGS) $(LDFLAGS)
else
	$(CC) -o $@ $< $(BUILD)/$(LIB_STATIC) $(CFLAGS) $(LDFLAGS)
endif
	$(STRIP) $(STRIPFLAGS) $@

$(BUILD)/$(LIB_SHARED): $(BUILD_OBJS) $(SRC) $(SRC_M) $(SRC_CPP) $(INC) $(INC_API)
	$(CC) -shared $(BUILD_OBJS) $(LDFLAGS) -o $@

$(BUILD)/$(LIB_STATIC): $(BUILD_OBJS) $(SRC) $(SRC_M) $(SRC_CPP) $(INC) $(INC_API)
	$(AR) rcs $@ $(BUILD_OBJS)

.PHONE: samples
samples: $(BUILD_SAMPLES)

.PHONE: samples_static
samples_static: $(BUILD_SAMPLES_STATIC)

.PHONE: clean
clean:
	rm $(BUILD)/$(LIB_STATIC) $(BUILD)/$(LIB_SHARED) $(BUILD_OBJS) $(BUILD_SAMPLES) $(BUILD_SAMPLES_STATIC)

.PHONE: clean_samples
clean_samples:
	rm $(BUILD_SAMPLES)

.PHONE: clean_samples_static
clean_samples_static:
	rm $(BUILD_SAMPLES_STATIC)
