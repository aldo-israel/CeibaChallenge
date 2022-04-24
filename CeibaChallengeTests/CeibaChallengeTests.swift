//
//  CeibaChallengeTests.swift
//  CeibaChallengeTests
//
//  Created by Aldo Israel Navarro on 4/23/22.
//

import XCTest
@testable import Alamofire
@testable import CeibaChallenge

class CeibaChallengeTests: XCTestCase {
    
    private var networkManager: NetworkManager!
    
    override func setUp() {
        super.setUp()
        
        let manager: Session = {
            let configuration: URLSessionConfiguration = {
                let configuration = URLSessionConfiguration.default
                configuration.protocolClasses = [MockProtocol.self]
                return configuration
            }()
            
            return Session(configuration: configuration)
        }()
        networkManager = NetworkManager(manager: manager)
    }
    
    
    func testUsersEndpoint() {
        let expectation = XCTestExpectation(description: "Performs a request to /users endpoint")
            
        networkManager.getUsers() { (result) in
            switch result {
            case.success(let users):
                XCTAssertEqual(users.first?.id, 1)
                expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(!error.localizedDescription.isEmpty, true)
                expectation.fulfill()
            }
        }
    }
    
    func testPostsByUserEndpoint() {
        let expectation = XCTestExpectation(description: "Performs a request to /posts endpoint")
            
        networkManager.getPostsBy(userId: 1) { (result) in
            switch result {
            case.success(let posts):
                XCTAssertEqual(posts.first?.id, 1)
                expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(!error.localizedDescription.isEmpty, true)
                expectation.fulfill()
            }
        }
    }
}
