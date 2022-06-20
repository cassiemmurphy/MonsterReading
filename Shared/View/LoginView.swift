//
//  Login.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/15/22.
//

import SwiftUI

struct LoginView: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @EnvironmentObject var appState: AppState
   
   @State var bgColor = Color("MonsterLime")
   @State var isSignIn = true
   @ObservedObject var loginVM = LoginViewModel()
   
   
    var body: some View {
       // Back, Title, Logo
       GeometryReader { geometry in
          ZStack {
             VStack(alignment: .leading) {
                MenuTop(previousPage: .welcome)
                HStack {
                   Button(action: {
                      isSignIn = true
                      bgColor = Color("MonsterLime")
                   }, label: {
                      Text("Sign in")
                         .focus(focused: isSignIn)
                   }).padding()
                   Button(action: {
                      isSignIn = false
                      bgColor = Color("MonsterRed")
                   }, label: {
                      Text("Sign up")
                         .focus(focused: !isSignIn)
                   })
                }.padding()
                VStack {
                   Spacer()
                   if isSignIn {
                      SignInView(accentColor: bgColor, handler: { pin, success in
                         success(loginVM.checkPIN(pin: pin))
                      })
                   } else {
                      SignUp(loginVM: loginVM, accentColor: bgColor)
                   }
                   Spacer()
                }.withOverlayStyle(bgColor: .white,
                                   height: geometry.size.height * 0.82,
                                   offsetY: .zero)
             }
          }.background(bgColor)
       }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
       LoginView()
          .environmentObject(NavigationViewModel())
          .environmentObject(AppState(loggedIn: false))
    }
}

extension Text {
   func focus(focused: Bool) -> some View {
      self.font(Font.custom("Helvetica Neue", size: focused ? 40 : 30))
         .fontWeight(.light)
         .foregroundColor(.white)
         .opacity(focused ? 1.0 : 0.5)

      }
}

struct SignUp: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @StateObject var loginVM: LoginViewModel
   var accentColor: Color
   
   
   var body: some View {
   // FIXME: To link back to CD or other user management
      VStack(alignment: .leading, spacing: 20) {
         Text("Enter the following details to sign up")
            .padding(.bottom)
         VStack {
            EntryField(placeholder: "First Name", prompt: loginVM.firstNamePrompt, field: $loginVM.firstName)
            EntryField(placeholder: "Last Name", prompt: loginVM.lastNamePrompt, field: $loginVM.lastName)
            EntryField(placeholder: "Enter your email", prompt: loginVM.emailPrompt, field: $loginVM.email)
               .keyboardType(.decimalPad)
            EntryField(placeholder: "Enter a 6 digit numeric login PIN", prompt: loginVM.pinPrompt, isSecure: true, field: $loginVM.pin)
               .keyboardType(.numberPad)
            EntryField(placeholder: "Confirm 6 digit numeric login PIN", prompt: loginVM.confirmPinPrompt, isSecure: true, field: $loginVM.pinConfirm)
               .keyboardType(.numberPad)
         }
         Spacer()
         WelcomeNavigation(isEnabled: $loginVM.formValid, nextPage: .monsterPick, pageNumber: 2, accentColor: accentColor)
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
                  .keyboardType(.numberPad)
            } else {
               TextField(placeholder, text: $field)
            }
         }.padding(10)
          .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.gray, lineWidth: 1))
         Text(prompt)
      }
   }
}
