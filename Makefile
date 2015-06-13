CC := rustc
TARGET := thumbv6m
RUSTCFLAGS = -C opt-level=2 -Z no-landing-pads --target $(TARGET)-none-eabi -g --emit obj -L libcore-$(TARGET)

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
library:
	mkdir -p libcore-$(TARGET)
	rustc -C opt-level=2 -Z no-landing-pads --target $(TARGET)-none-eabi -g ../rust/src/libcore/lib.rs --out-dir libcore-thumbv6m

