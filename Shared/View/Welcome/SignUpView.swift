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
   
   @State var showChildOverlay = false
   @State var children: [Child] = []
   
   var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
   var accentColor: Color
   
   /*
    TODO: Fix child add situation
    Fix Style
    Edit call to add child to send CHILD object
    */
   
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
            // TODO: Fix placeholder showing odd
            EntryField(placeholder: "Confirm 6 digit numeric login PIN",
                       prompt: loginVM.confirmPinPrompt,
                       isSecure: true,
                       field: $loginVM.pinConfirm)
               .keyboardType(.numberPad)
         }.popover(isPresented: $showChildOverlay) {
            AddChildView { child in
               children.append(child)
               showChildOverlay = false
            }
         }
         VStack(alignment: .leading) {
            Text(children.isEmpty ? "No Children Added" : "Children Added:")
            VStack {
               ForEach(children) { child in
                  HStack {
                     Image(child.monster).resizable().scaledToFit()
                     Text(child.name)
                     Text(child.grade.rawValue)
                  }.frame(height: 25)
               }
            }
         }.padding()
            .border(accentColor, width: 2)
         Button {
            showChildOverlay = true
         } label: {
            Text(children.isEmpty ? "Add another child" : "Add a child")
         }
         Spacer()
         WelcomeNavigation(isEnabled: $loginVM.formValid,
                           pageNumber: 2,
                           accentColor: accentColor,
                           action: {
            authVM.register(name: loginVM.name,
                            email: loginVM.email,
                            password: loginVM.pin,
                            children: children)})
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
