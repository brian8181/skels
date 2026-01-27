<?php
	/*
	*  @brief gnu make file targets
	*  @file makefile.php
	*  @date Fri, Dec 19, 2025 12:52:59 AM
	*  @version 0.0.1
	*/
    $APPNAME=$argv[1];
    $DATE=$argv[2];
	$VERSION=$argv[3];
    ?>
all: $(BLD)/<?= $APPNAME ?> $(BLD)/lib<?= $APPNAME ?>.so $(BLD)/lib<?= $APPNAME ?>.a

$(BLD)/<?= $APPNAME ?>: $(OBJ)/main.o $(OBJ)/<?= $APPNAME ?>.o
	 $(CXX) $(CXXFLAGS) $(OBJ)/main.o $(OBJ)/<?= $APPNAME ?>.o -o $(BLD)/<?= $APPNAME ?>

$(BLD)/lib<?= $APPNAME ?>.so: $(OBJ)/main.o $(BLD)/<?= $APPNAME ?>.o
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) --shared $(OBJ)/main.o $(BLD)/<?= $APPNAME ?>.o -o $(BLD)/lib<?= $APPNAME ?>.so
	-chmod 755 $(BLD)/lib<?= $APPNAME ?>.so

$(BLD)/lib<?= $APPNAME ?>.a: $(OBJ)/main.o $(BLD)/<?= $APPNAME ?>.o
	-ar rvs $(BLD)/lib<?= $APPNAME ?>.a $(OBJ)/main.o $(BLD)/<?= $APPNAME ?>.o
	-chmod 755 $(BLD)/lib<?= $APPNAME ?>.a

$(OBJ)/<?= $APPNAME ?>.o: $(SRC)/<?= $APPNAME ?>.cpp
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) -c $(SRC)/<?= $APPNAME ?>.cpp -o $(OBJ)/<?= $APPNAME ?>.o

$(BLD)/<?= $APPNAME ?>_test: $(SRC)/<?= $APPNAME ?>_test.cpp
	$(CXX) $(CXXFLAGS) $^ $(LDFLAGS) -o $@

# rules <?= '<?= "\nTEST\n ?>' ?>

# copy header to build dir
$(BLD)/%.hpp: $(SRC)/%.hpp
	-cp $^ $@

$(OBJ)/%.o: ./$(SRC)/%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

#<?php '<?php echo "rule\n"; include "make.class.rule.php" ?>' ?>

.PHONY: all clean install unintsall rebuild help

rebuild: clean all

install:
	cp ./$(BLD)/<?= $APPNAME ?> ./$(prefix)/bin/<?= $APPNAME ?>

uninstall:
	-rm ./$(prefix)/bin/<?= $APPNAME ?>

clean:
	@ECHO "removing files ..."
	-rm -f $(OBJ)/*
	-rm -f $(BLD)/*

help:
	@echo
	@echo  'Project: <?= "$APPNAME : $VERSION : $DATE" ?> simple "<?= $APPNAME ?>" framework.'
	@echo
	@echo  '    make [-f] [target]'
	@echo
	@echo  '   -Make Targets ...'
	@echo
	@echo  '        * all                              - build all'
	@echo  '        * $(BLD)/<?= $APPNAME ?>:          - re/build <?= $APPNAME ?>'
	@echo  '        * $(BLD)/<?= $APPNAME ?>_utest:    - re/build <?= $APPNAME ?>_utest, unit testing'
	@echo  '        * clean                            - remove most generated files but keep the config'
	@echo
