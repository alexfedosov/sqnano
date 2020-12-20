import XCTest

import sqnanoTests

var tests = [XCTestCaseEntry]()
tests += sqnanoTests.allTests()
XCTMain(tests)
