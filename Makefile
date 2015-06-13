CC := rustc
TARGET := thumbv6m
TARGET_TRIPLE := $(TARGET)-none-eabi
RUSTCFLAGS = -C opt-level=2 -Z no-landing-pads --target $(TARGET_TRIPLE) -g --emit obj -L libcore-$(TARGET)

SRC_DIR = src
OBJ_DIR = out

SOURCES := $(wildcard $(SRC_DIR)/*.rs)
OBJECTS := $(SOURCES:$(SRC_DIR)/%.rs=$(OBJ_DIR)/%.o)

default: obj_dir all
	
obj_dir:
	mkdir -p $(OBJ_DIR)

all: $(OBJECTS)
$(OBJECTS): $(OBJ_DIR)/%.o : $(SRC_DIR)/%.rs
	@$(CC) $(RUSTCFLAGS) -o $@ $<
	@echo "Compiled "$<" successfully!"
	
clean:
	rm -r $(OBJ_DIR)
	
###### Library #######
LIB_DIR := libcore-$(TARGET)

lib:
	mkdir -p $(LIB_DIR)
	rustc -C opt-level=2 -Z no-landing-pads --target $(TARGET)-none-eabi -g ../rust/src/libcore/lib.rs --out-dir libcore-thumbv6m

cleanlib:
	rm -r $(LIB_DIR)