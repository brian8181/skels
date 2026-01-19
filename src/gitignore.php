<?php
	 /*
    *  @brief generate git ignore file
    *  @file .gitignore.sh
    *  @date Fri, Dec 19, 2025 12:52:59 AM
    *  @version 0.0.1
    */
    $APPNAME=$argv[1];
    $DATE=$argv[2];
	$VERSION="0.0.1";
    ?>
# @project:  <?= "$APPNAME\n"; ?>
# @file:    .gitignore
# @date:    <?= "$DATE\n"; ?>
# @version: <?= "$VERSION\n"; ?>
# @brief:   git ignore file

build/*
