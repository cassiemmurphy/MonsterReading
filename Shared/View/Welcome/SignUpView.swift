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
   
   
   var body: some View {
   // FIXME: To link back to CD or other user management
      VStack(alignment: .leading, spacing: 20) {
         Text("Enter the following details to sign up")
            .padding(.bottom)
         VStack {
            EntryField(placeholder: "Parent Name",
                       prompt: loginVM.namePrompt,
                       field: $loginVM.name)
            EntryField(placeholder: "Parent Email",
                       prompt: loginVM.emailPrompt,
                       field: $loginVM.email)
               .keyboardType(.decimalPad)
            EntryField(placeholder: "Enter a 6 digit numeric login PIN",
                       prompt: loginVM.pinPrompt,
                       isSecure: true,
                       field: $loginVM.pin)
               .keyboardType(.numberPad)
            EntryField(placeholder: "Confirm 6 digit numeric login PIN",
                       prompt: loginVM.confirmPinPrompt,
                       isSecure: true,
                       field: $loginVM.pinConfirm)
               .keyboardType(.numberPad)
         }
         Spacer()
         WelcomeNavigation(isEnabled: $loginVM.formValid,
                           pageNumber: 2,
                           accentColor: accentColor,
                           action: {
            authVM.register(name: loginVM.name, email: loginVM.email, password: loginVM.pin)
            navigationVM.currentPage = .monsterPick
         })
      }.padding()
   }
}

struct EntryField: View {
   var placeholder: String
   var prompt: String
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
         Text(prompt)
      }
   }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
       SignUpView(loginVM: LoginViewModel(), accentColor: Color("MonsterRed"))
    }
}
