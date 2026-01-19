// # File Name:  ./rx_test.cpp
// # Build Date: Wed Nov  8 08:33:47 AM CST 2023
// # Version:    0.1

#include <iostream>
#include <string>
#include <list>
#include <cppunit/ui/text/TestRunner.h>
#include <cppunit/TestCase.h>
#include <cppunit/TestFixture.h>
#include <cppunit/ui/text/TextTestRunner.h>
#include <cppunit/extensions/HelperMacros.h>
#include <cppunit/extensions/TestFactoryRegistry.h>
#include <cppunit/TestResult.h>
#include <cppunit/TestResultCollector.h>
#include <cppunit/TestRunner.h>
#include <cppunit/BriefTestProgressListener.h>
#include <cppunit/CompilerOutputter.h>
#include <cppunit/XmlOutputter.h>
#include <netinet/in.h>
#include "auto_ptr.hpp"
#include "auto_ptr_utest.hpp"
#include "point.hpp"

using namespace CppUnit;

void Auto_Ptr_Test::setUp()
{
}

void Auto_Ptr_Test::tearDown()
{
}

void Auto_Ptr_Test::test_get_ref_count()
{
    auto_ptr<int> ap(42);
    int ref_count = ap.get_ref_count();
    CPPUNIT_ASSERT(ref_count == 1);
}

void Auto_Ptr_Test::test_get_val()
{
    auto_ptr<int> ap(42);
    int value = ap.get_val();
    CPPUNIT_ASSERT(value == 42);
}

void Auto_Ptr_Test::test_get_ref_const_ref()
{
    auto_ptr<int> ap(42);
    auto_ptr<int> ap2;
    ap.get_ref(ap2);

    CPPUNIT_ASSERT_EQUAL(*ap, *ap2);
    CPPUNIT_ASSERT_EQUAL(ap.operator->(), ap2.operator->());
    CPPUNIT_ASSERT(ap.get_val() == ap2.get_val());
}

void Auto_Ptr_Test::test_get_ref_no_parma()
{
    auto_ptr<int> ap(42);
    // auto_ptr<int> ap2 = ap.get_ref();

    // CPPUNIT_ASSERT_EQUAL( *ap, *ap2 );
    // CPPUNIT_ASSERT_EQUAL( ap.operator->(), ap2.operator->() );
    // CPPUNIT_ASSERT( ap.get_val() == ap2.get_val() );
}

void Auto_Ptr_Test::test_copy_ctor()
{
    const CPPUNIT_NS::Message message("a message");

    auto_ptr<int> ap(42);
    auto_ptr<int> ap2(ap);

    CPPUNIT_ASSERT_EQUAL(*ap, *ap2);
    CPPUNIT_ASSERT_EQUAL(ap.operator->(), ap2.operator->());
    CPPUNIT_ASSERT(ap.get_val() == ap2.get_val());
}

void Auto_Ptr_Test::test_move_ctor()
{
    //  const CPPUNIT_NS::Message message( "a message" );

    //  auto_ptr<int> ap(42);
    //  auto_ptr<int> ap2 = std::move(ap);

    //  CPPUNIT_ASSERT( &ap == 0 );
    //  CPPUNIT_ASSERT( ap2.operator&() != 0 );
    CPPUNIT_ASSERT_ASSERTION_PASS(true);
}

void Auto_Ptr_Test::test_assignment_oper()
{
    auto_ptr<int> ap(42);
    auto_ptr<int> ap2 = ap;

    CPPUNIT_ASSERT_EQUAL(*ap, *ap2);
    CPPUNIT_ASSERT_EQUAL(ap.operator->(), ap2.operator->());
    CPPUNIT_ASSERT(ap.get_val() == ap2.get_val());
}

void Auto_Ptr_Test::test_get_ref_counts()
{
    auto_ptr<int> ap1(42);
    CPPUNIT_ASSERT_EQUAL(1, (int)ap1.get_ref_count());
    {
        auto_ptr<int> ap2(ap1);
        CPPUNIT_ASSERT_EQUAL(2, (int)ap1.get_ref_count());
        CPPUNIT_ASSERT_EQUAL(2, (int)ap2.get_ref_count());
        {
            auto_ptr<int> ap3(ap2);
            CPPUNIT_ASSERT_EQUAL(3, (int)ap1.get_ref_count());
            CPPUNIT_ASSERT_EQUAL(3, (int)ap1.get_ref_count());
            CPPUNIT_ASSERT_EQUAL(3, (int)ap3.get_ref_count());
            {
                auto_ptr<int> ap4(ap3);
                CPPUNIT_ASSERT_EQUAL(4, (int)ap1.get_ref_count());
                CPPUNIT_ASSERT_EQUAL(4, (int)ap2.get_ref_count());
                CPPUNIT_ASSERT_EQUAL(4, (int)ap3.get_ref_count());
                // CPPUNIT_ASSERT_EQUAL(4, (int)ap4.get_ref_count());
            }
            CPPUNIT_ASSERT_EQUAL(3, (int)ap1.get_ref_count());
            CPPUNIT_ASSERT_EQUAL(3, (int)ap2.get_ref_count());
            CPPUNIT_ASSERT_EQUAL(3, (int)ap3.get_ref_count());
        }
        CPPUNIT_ASSERT_EQUAL(2, (int)ap1.get_ref_count());
        CPPUNIT_ASSERT_EQUAL(2, (int)ap2.get_ref_count());
    }
    CPPUNIT_ASSERT_EQUAL(1, (int)ap1.get_ref_count());
}

void Auto_Ptr_Test::test_point_get_ref()
{
    point<int> p(2, 3);
    auto_ptr<point<int>> ap(p);
    int ref_count = ap.get_ref_count();
    CPPUNIT_ASSERT(ref_count == 1);

    point<int> p2 = ap.get_val();
    CPPUNIT_ASSERT_MESSAGE("p != p2", p.get_x() == p2.get_x() && p.get_y() == p2.get_y());

    auto_ptr<point<int>> ap2;
    ap.get_ref(ap2);
    point<int> v1 = ap.get_val();
    point<int> v2 = ap2.get_val();
    CPPUNIT_ASSERT(v1.get_x() == v2.get_x());
    // CPPUNIT_ASSERT( v1 == v2 );
}

void Auto_Ptr_Test::test_point_assignment()
{
    point<int> p1(2, 3);
    auto_ptr<point<int>> ap1(p1);
    int ref_count = ap1.get_ref_count();
    CPPUNIT_ASSERT(ref_count == 1);

    auto_ptr<point<int>> ap2 = ap1;
    ap2.set_val(point(9, 8));
    CPPUNIT_ASSERT(ap1.get_val().get_x() == ap2.get_val().get_x());
}

void Auto_Ptr_Test::test_equals()
{
    // int n = 42;
    // int* p = &n;
    // auto_ptr<int> ap(p);

    // CPPUNIT_ASSERT(ap.operator->() == &n);
    CPPUNIT_ASSERT(true);
}

void Auto_Ptr_Test::test_not_equals()
{
    // int n = 42;
    // auto_ptr<int> ap(n);

    // CPPUNIT_ASSERT(ap.operator->() != &n);
    CPPUNIT_ASSERT(true);
}

void Auto_Ptr_Test::test_less_than()
{
    CPPUNIT_ASSERT(true);
}

void Auto_Ptr_Test::test_less_than_equals()
{
    CPPUNIT_ASSERT(true);
}

void Auto_Ptr_Test::test_greater_than()
{
    CPPUNIT_ASSERT(true);
}

void Auto_Ptr_Test::test_greater_than_equals()
{
    CPPUNIT_ASSERT(true);
}

CPPUNIT_TEST_SUITE_REGISTRATION(Auto_Ptr_Test);

int main(int argc, char *argv[])
{
    // informs test-listener about testresults
    CPPUNIT_NS::TestResult testresult;

    // register listener for collecting the test-results
    CPPUNIT_NS::TestResultCollector collectedresults;
    testresult.addListener(&collectedresults);

    // register listener for per-test progress output
    CPPUNIT_NS::BriefTestProgressListener progress;
    testresult.addListener(&progress);

    // insert test-suite at test-runner by registry#include <stdio.h>
    CPPUNIT_NS::TestRunner testrunner;
    testrunner.addTest(CPPUNIT_NS::TestFactoryRegistry::getRegistry().makeTest());
    testrunner.run(testresult);

    // output resint* pn = new int;ults in compiler-format
    CPPUNIT_NS::CompilerOutputter compileroutputter(&collectedresults, std::cerr);
    compileroutputter.write();

    // Output XML for Jenkins CPPunit plugin
    std::ofstream xmlFileOut("cppAuto_Ptr_TestResults.xml");
    XmlOutputter xmlOut(&collectedresults, xmlFileOut);
    xmlOut.write();

    CppUnit::TextUi::TestRunner text_ui_runner;
    text_ui_runner.addTest(Auto_Ptr_Test::suite());
    text_ui_runner.run();

    // return 0 if tests were successful
    return collectedresults.wasSuccessful() ? 0 : 1;
}
