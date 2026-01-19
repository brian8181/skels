<?php
	/*
    *  @brief app skeleton header
	*  @file app_hpp.php
	*  @date Fri, Dec 19, 2025 12:52:59 AM
	*  @version 0.0.1
	*/
    $NAME=$argv[1];
    $DATE=$argv[2];
	$VERSION="version 0.0.1";
    include "cstyle_file_header.php"
    ?>
#ifndef _<?= "$NAME" ?>_HPP
#define _<?= "$NAME" ?>_HPP

#include <string>

using std::string;

void print_help();
void print_version();
int parse_options(int argc, char* argv[]);

#endif
