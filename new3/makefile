# @name     new3
# @file:    makefile
# @date:    Tue Dec 30 20:45:31 CST 2025
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

APP=new3
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

all: $(BLD)/new3 $(BLD)/libnew3.so $(BLD)/libnew3.a

$(BLD)/new3: $(OBJ)/main.o $(OBJ)/new3.o
	 $(CXX) $(CXXFLAGS) $(OBJ)/main.o $(OBJ)/new3.o -o $(BLD)/new3

$(BLD)/libnew3.so: $(OBJ)/main.o $(BLD)/new3.o
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) --shared $(OBJ)/main.o $(BLD)/new3.o -o $(BLD)/libnew3.so
	-chmod 755 $(BLD)/libnew3.so

$(BLD)/libnew3.a: $(OBJ)/main.o $(BLD)/new3.o
	-ar rvs $(BLD)/libnew3.a $(OBJ)/main.o $(BLD)/new3.o
	-chmod 755 $(BLD)/libnew3.a

$(OBJ)/new3.o: $(SRC)/new3.cpp
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) -c $(SRC)/new3.cpp -o $(OBJ)/new3.o

$(BLD)/TEST_new3: $(TST)/TEST_config.cpp $(TST)/TEST_new3.cpp $(TST)/main.cpp
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
	cp ./$(BLD)/new3 ./$(prefix)/bin/new3
uninstall:
	-rm ./$(prefix)/bin/new3
clean:
	@ECHO "removing files ..."
	-rm -f $(OBJ)/*
	-rm -f $(BLD)/*

help:
	@echo
	@echo  'Project: new3 : version 0.0.1 : Tue Dec 30 20:45:31 CST 2025 simple "new3" framework.'
	@echo
	@echo  '    make [-f] [target]'
	@echo
	@echo  '   -Make Targets ...'
	@echo
	@echo  '*        all                                     - build all'
	@echo  '*        $(BLD)/new3:         - re/build new3'
	@echo  '*        $(BLD)/new3_utest:   - re/build new3_utest, unit testing'
	@echo  '*        clean                                   - remove most generated files but keep the config'
