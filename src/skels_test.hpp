/**
 * @file    skels_test.hpp
 * @version 0.0.1
 * @date    Fri, 19 Dec 2025 20:57:42 +0000
 * @info    ...
 */
#ifndef _App_TEST_H
#define _App_TEST_H

#include <cppunit/Test.h>

class AppTest : public CppUnit::TestFixture
{
private:
    CPPUNIT_TEST_SUITE(AppTest);
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
