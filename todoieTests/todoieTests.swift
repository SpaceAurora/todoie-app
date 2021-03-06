//
//  todoieTests.swift
//  todoieTests
//
//  Created by Mustafa Khalil on 12/11/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import XCTest
@testable import todoie

class todoieTests: XCTestCase {

    private let network = NetworkManager(url: AppConfiguration.serverUrl)
    private let interalQueue: OperationQueue = {
        let op = OperationQueue()
        op.maxConcurrentOperationCount = 1
        return op
    }()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAllowedStatus() {
        
        // Testing the procedures that were writtin
        let fetchStatusOperation = network.fetchStatusOkay()
        let decoderOperation = DecoderOperation<Status>()
        
        decoderOperation.completionBlock = { [unowned decoderOperation] in
            
            XCTAssertTrue(decoderOperation.output?.Allowed == true, "GO")
        }
        
        fetchStatusOperation.completionBlock = { [unowned fetchStatusOperation, unowned decoderOperation] in
            if fetchStatusOperation.isCancelled {
                return
            }
            decoderOperation.input = fetchStatusOperation.output
        }
        
        decoderOperation.addDependency(fetchStatusOperation)
        interalQueue.addOperations([decoderOperation, fetchStatusOperation], waitUntilFinished: false)
    }

}
