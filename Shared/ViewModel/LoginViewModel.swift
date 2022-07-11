//
//  LoginViewModel.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/19/22.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
   // FIXME: Temp form fields, to be adjusted
   @Published var name: String = ""
   @Published var email: String = ""
   @Published var pin: String = ""
   @Published var pinConfirm: String = ""
   
   @Published var nameValid = false
   @Published var emailValid = false
   @Published var pinValid = false
   @Published var pinConfirmValid = false
   @Published var formValid = false
   private var cancellableSet: Set<AnyCancellable> = []
   
   let namePredicate = NSPredicate(format: "SELF MATCHES %@", "(?<! )[-a-zA-Z' ]{2,26}")
   let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
   let pinPredicate = NSPredicate(format: "SELF MATCHES %@", "^[0-9]{6,6}$")
   
   init() {
      $name
         .map { name in
            return self.namePredicate.evaluate(with: name)
         }
         .assign(to: \.nameValid, on: self)
         .store(in: &cancellableSet)
      $email
         .map { email in
            return self.emailPredicate.evaluate(with: email)
         }
         .assign(to: \.emailValid, on: self)
         .store(in: &cancellableSet)
      
      $pin
         .map { pin in
            return self.pinPredicate.evaluate(with: pin)
         }
         .assign(to: \.pinValid, on: self)
         .store(in: &cancellableSet)
      
      Publishers.CombineLatest($pin, $pinConfirm)
         .map { pin, pinConfirm in
            return pin == pinConfirm
         }
         .assign(to: \.pinConfirmValid, on: self)
         .store(in: &cancellableSet)
      
      Publishers.CombineLatest4($nameValid, $emailValid, $pinValid, $pinConfirmValid)
         .map { lastNameValid, emailValid, pinValid, pinConfirmValid in
            return (lastNameValid && emailValid && pinValid && pinConfirmValid)
         }
         .assign(to: \.formValid, on: self)
         .store(in: &cancellableSet)
   }
   
   var namePrompt: String {
      (nameValid || name.isEmpty) ? "" : "Enter a valid first name"
   }
   
   var emailPrompt: String {
      (emailValid || email.isEmpty) ? "" : "Enter a valid email address"
   }
   
   var pinPrompt: String {
      (pinValid || pin.isEmpty) ? "" : "Enter a valid 6 digit numeric PIN"
   }
   
   var confirmPinPrompt: String {
      pinValid ? "" : "PIN fields do not match"
   }
}
