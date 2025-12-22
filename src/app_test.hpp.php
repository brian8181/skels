<?php
	/*
    *  @brief # main with getlongopts
	*  @file main_get_long_opts.php
	*  @date Fri, Dec 19, 2025 12:52:59 AM
	*  @version 0.0.1
	*/
    $NAME=$argv[1];
    $VERSION="0.0.1";
	$INFO="auto generated with ccsk, create class skeleton";
	include 'cstyle_file_header.php';
    ?>
#ifndef _TEST_<?= $APPNAME ?>_H
#define _TEST_<?= $APPNAME ?>_H

#include <cppunit/Test.h>

class TEST_<?= $APPNAME ?> : public CppUnit::TestFixture
{
private:
    CPPUNIT_TEST_SUITE(TEST_<?= $APPNAME ?>);
    CPPUNIT_TEST(testNoOptions);
    CPPUNIT_TEST(testOptionHelp);
    CPPUNIT_TEST(testOptionHelpLong);
    CPPUNIT_TEST(testOptionVerbose);
    CPPUNIT_TEST(testOptionVerboseLong);
    CPPUNIT_TEST_SUITE_END();

public:
    void setUp();
    void tearDown();

    // agregate test functions
    void execute();
    void execute(int argc, char* argv[]);

protected:
    void testNoOptions();
    void testOptionHelp();
    void testOptionHelpLong();
    void testOptionVerbose();
    void testOptionVerboseLong();

private:
    int m_argc;
    char* m_argv[10];

};

#endif
