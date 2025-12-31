# @name     new
# @file:    makefile
# @date:    Tue Dec 30 20:45:27 CST 2025
# @version: version 0.0.1

# g++ warnings
#-Wall -Wextra -Wpedantic -Wshadow -Wconversion -Werror -Wundef
#-fsanitize=undefined,address -Wfloat-equal -Wformat-nonliteral
#-Wformat-security -Wformat-y2k -Wformat=2 -Wimport -Winvalid-pch
#-Wlogical-op -Wmissing-declarations -Wmissing-field-initializers
#-Wmissing-format-attribute -Wmissing-include-dirs -Wmissing-noreturn
#-Wnested-externs -Wpacked -Wpointer-arith -Wredundant-decls
#-Wstack-protector -Wstrict-null-sentinel -Wswitch-enum -Wwrite-strings

SHELL:=bash

APP=new
CXX=g++
CXXFLAGS=-Wall -std=c++20 -fPIC
CXXEXTRA=-Wno-template-body
CXXCPP?=
LDFLAGS?=
LIBS?=

SRC?=src
BLD?=build
OBJ?=build

# lib settings
LIBS=-L/usr/lib -L/usr/lib64 -L/usr/local/lib -L/usr/local/lib64
INCLUDES=-I/usr/local/include/cppunit/
LDFLAGS=$(INCLUDES) $(LIBS)

ifndef RELEASE
	CXXFLAGS +=-g -DDEBUG
endif

ifdef CYGWIN
	CXXFLAGS +=-DCYGWIN
	LDFLAGS += -lfmt -lcppunit.dll
else
	LDFLAGS += -lfmt -lcppunit
endif

all: $(BLD)/new $(BLD)/libnew.so $(BLD)/libnew.a

$(BLD)/new: $(OBJ)/main.o $(OBJ)/new.o
	 $(CXX) $(CXXFLAGS) $(OBJ)/main.o $(OBJ)/new.o -o $(BLD)/new

$(BLD)/libnew.so: $(OBJ)/main.o $(BLD)/new.o
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) --shared $(OBJ)/main.o $(BLD)/new.o -o $(BLD)/libnew.so
	-chmod 755 $(BLD)/libnew.so

$(BLD)/libnew.a: $(OBJ)/main.o $(BLD)/new.o
	-ar rvs $(BLD)/libnew.a $(OBJ)/main.o $(BLD)/new.o
	-chmod 755 $(BLD)/libnew.a

$(OBJ)/new.o: $(SRC)/new.cpp
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) -c $(SRC)/new.cpp -o $(OBJ)/new.o

$(BLD)/TEST_new: $(TST)/TEST_config.cpp $(TST)/TEST_new.cpp $(TST)/main.cpp
	$(CXX) $(CXXFLAGS) $^ $(LDFLAGS) -o $@

# rules <?= "\nTEST\n ?>
# copy header to build dir
$(BLD)/%.hpp: $(SRC)/%.hpp
	-cp $^ $@

$(OBJ)/%.o: ./$(SRC)/%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

#
.PHONY: all clean install unintsall rebuild help

rebuild: clean all

install:
	cp ./$(BLD)/new ./$(prefix)/bin/new
uninstall:
	-rm ./$(prefix)/bin/new
clean:
	@ECHO "removing files ..."
	-rm -f $(OBJ)/*
	-rm -f $(BLD)/*

help:
	@echo
	@echo  'Project: new : version 0.0.1 : Tue Dec 30 20:45:27 CST 2025 simple "new" framework.'
	@echo
	@echo  '    make [-f] [target]'
	@echo
	@echo  '   -Make Targets ...'
	@echo
	@echo  '*        all                                     - build all'
	@echo  '*        $(BLD)/new:         - re/build new'
	@echo  '*        $(BLD)/new_utest:   - re/build new_utest, unit testing'
	@echo  '*        clean                                   - remove most generated files but keep the config'
