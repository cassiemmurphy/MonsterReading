//
//  AuthTests.swift
//  Monster Reading Tests
//
//  Created by Murphy, Cassie on 7/10/22.
//

import XCTest
@testable import Monster_Reading

class AuthTests: XCTestCase {
   var auth: AuthViewModel!

    override func setUpWithError() throws {
       try super.setUpWithError()
       auth = AuthViewModel()
    }

    override func tearDownWithError() throws {
       auth = nil
       try super.tearDownWithError()
    }

   func testAccountCreation()  {
      
   }
   func testAccountCreationBadEmail()  {
      
   }
   func testAccountCreationExistingEmail()  {
      
   }
   func testLoginSuccess()  {
      
   }
   func testInvalidEmail()  {
      
   }
   func testInvalidPIN()  {
      
   }

}
