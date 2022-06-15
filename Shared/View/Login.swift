//
//  Login.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/15/22.
//

import SwiftUI

struct Login: View {
   @State var bgColor = Color("MonsterRed")
   @State var isSignIn = false
   
   
    var body: some View {
       // Back, Title, Logo
       GeometryReader { geometry in
          VStack {
             HStack {
                Button(action: {
                   isSignIn = true
                   bgColor = Color("MonsterLime")
                }, label: {
                   Text("Sign in")
                      .foregroundColor(.white)
                })
                Button(action: {
                   isSignIn = false
                   bgColor = Color("MonsterRed")
                }, label: {
                   Text("Sign up")
                })
             }
             if isSignIn {
                SignIn()
             } else {
                SignUp()
             }
          }.frame(width: geometry.size.width, height: geometry.size.height)
             .background(bgColor)
       }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

struct SignUp: View {
// FIXME: Temp form fields, to be adjusted
   @State var fullName: String = ""
   @State var email: String = ""
   @State var pin: String = ""
   @State var phone: String = ""
   
   var body: some View {
   // FIXME: To link back to CD or other user management
      
      VStack {
         Text("Enter the following details to sign up")
         Form {
            TextField("Full Name", text: $fullName)
            TextField("Enter your email", text: $email)
               .keyboardType(.decimalPad)
            TextField("Enter a 6 digit login PIN", text: $pin)
            TextField("Mobile", text: $phone)
         }
      }
   }
}

struct SignIn: View {
// FIXME: Temp form fields, to be adjusted
   @State var fullName: String = ""
   @State var email: String = ""
   @State var pin: String = ""
   @State var phone: String = ""
   
   var body: some View {
   // FIXME: To link back to CD or other user management
      
      VStack {
         Text("Enter your 6 digit PIN to sign in")
         Rectangle()
      }
   }
}
