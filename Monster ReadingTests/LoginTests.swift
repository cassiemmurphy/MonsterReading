//
//  LoginTests.swift
//  Monster Reading Tests
//
//  Created by Murphy, Cassie on 6/19/22.
//

import XCTest
@testable import Monster_Reading

class LoginTests: XCTestCase {
   var login: LoginViewModel!

    override func setUpWithError() throws {
       try super.setUpWithError()
       login = LoginViewModel()
    }

    override func tearDownWithError() throws {
       login = nil
       try super.tearDownWithError()
    }

    func testValidLogin() throws {
        // given
       
       // when
       
       // then
       
    }

    func testMissingName() throws {
        // This is an example of a performance test case.
    }

}
