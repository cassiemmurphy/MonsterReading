//
//  LoginViewModel.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/19/22.
//

import Foundation

class LoginViewModel: ObservableObject {
   var testPIN = "628426"
   
   func checkPIN(pin: String) -> Bool {
      return pin == testPIN
   }
}
