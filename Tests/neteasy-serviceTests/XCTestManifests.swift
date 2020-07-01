import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(neteasy_serviceTests.allTests),
    ]
}
#endif
