//
//  SignUpView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/4/22.
//

import SwiftUI

struct SignUpView: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @EnvironmentObject var authVM: AuthViewModel
   @StateObject var loginVM: LoginViewModel
   var accentColor: Color
   
   @State private var name = ""
   @State private var email = ""
   @State private var password = ""
   @State private var confirmPassword = ""
   
   
   var body: some View {
   // FIXME: To link back to CD or other user management
      VStack(alignment: .leading, spacing: 20) {
         Text("Enter the following details to sign up")
            .padding(.bottom)
         VStack {
            EntryField(placeholder: "Parent Name", field: $name)
            EntryField(placeholder: "Parent Email", field: $email)
               .keyboardType(.decimalPad)
            EntryField(placeholder: "Parent Password", field: $password)
            EntryField(placeholder: "Confirm Password", field: $confirmPassword)
         }
         Spacer()
         Button("Add child") {
            authVM.addChild(name: "Nathan", grade: "First", pin: "234567", monster: "Monster3")
         }
         WelcomeNavigation(isEnabled: $loginVM.formValid, nextPage: .monsterPick, pageNumber: 2, accentColor: accentColor)
      }.padding()
   }
}
   
   
   /*
    EntryField(placeholder: "Enter a 6 digit numeric login PIN", prompt: loginVM.pinPrompt, isSecure: true, field: $loginVM.pin)
       .keyboardType(.numberPad)
    EntryField(placeholder: "Confirm 6 digit numeric login PIN", prompt: loginVM.confirmPinPrompt, isSecure: true, field: $loginVM.pinConfirm)
       .keyboardType(.numberPad)
 }
    */

struct EntryField: View {
   var placeholder: String
   //var prompt: String
   var isSecure = false
   
   @Binding var field: String
   
   var body: some View {
      VStack(alignment: .leading) {
         HStack {
            if isSecure {
               SecureField(placeholder, text: $field)
            } else {
               TextField(placeholder, text: $field)
            }
         }.padding(10)
          .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.gray, lineWidth: 1))
         Text("prompt")
      }
   }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
       SignUpView(loginVM: LoginViewModel(), accentColor: Color("MonsterRed"))
    }
}
