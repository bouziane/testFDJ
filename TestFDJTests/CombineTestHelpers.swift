//
//  CombineTestHelpers.swift
//  TestFDJTests
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Combine
@testable import TestFDJ
import XCTest

extension XCTestCase {
    func assertPublisher<T: Equatable>(_ publisher: AnyPublisher<T, Error>, completesWith expectedResult: Result<T, Error>, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Waiting for publisher")
        var cancellables = Set<AnyCancellable>()

        publisher.sink(receiveCompletion: { completion in
            switch (completion, expectedResult) {
                case (.finished, .success):
                    break
                case (.failure(let receivedError as NSError), .failure(let expectedError as NSError)):
                    XCTAssertEqual(receivedError, expectedError, file: file, line: line)
                default:
                    XCTFail("Expected \(expectedResult) but got \(completion)", file: file, line: line)
            }
            exp.fulfill()
        }, receiveValue: { value in
            if case .success(let expectedValue) = expectedResult {
                XCTAssertEqual(value, expectedValue, file: file, line: line)
            }
        })
        .store(in: &cancellables)

        wait(for: [exp], timeout: 1.0)
    }
}
