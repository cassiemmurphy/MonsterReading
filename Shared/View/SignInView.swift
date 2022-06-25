//
//  SignInView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/19/22.
//

import SwiftUI

struct SignInView: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @EnvironmentObject var appState: AppState
   
   @State var pin: String = ""
   @State var label = "Enter your 6 digit PIN to sign in"
   @State var showPin = false
   @State var isDisabled = false
   @State var pinSuccess = false

   var accentColor: Color
   var maxDigits: Int = 6
   var handler: (String, (Bool) -> Void) -> Void

   var body: some View {
       // FIXME: To link back to CD or other user management
      VStack(alignment: .leading) {
         Text(label)
         ZStack {
            pinDots
            backgroundField
         }
         HStack {
            Spacer()
            Button(action: {
                self.showPin.toggle()
            }, label: {
                self.showPin ?
               Image(systemName: "eye.slash.fill").foregroundColor(.black) :
                    Image(systemName: "eye.fill").foregroundColor(.black)
            }).padding(.trailing)
         }.padding()
         KeyPadView(pin: $pin, isDisabled: $isDisabled)
         WelcomeNavigation(isEnabled: $pinSuccess, nextPage: .monsterPick,
                           pageNumber: 2, accentColor: accentColor)
         Spacer()
      }.padding()
    }
   
   private var backgroundField: some View {
       let boundPin = Binding<String>(get: { self.pin }, set: { newValue in
           self.pin = newValue
           self.submitPin()
       })
       
       return TextField("", text: boundPin, onCommit: submitPin)
         .accentColor(.clear)
         .foregroundColor(.clear)
         .keyboardType(.numberPad)
         .disabled(isDisabled)
   }
   
   private var pinDots: some View {
       HStack {
           Spacer()
           ForEach(0..<maxDigits) { index in
               Image(systemName: self.getImageName(at: index))
                 .font(.system(size: 30, weight: .thin))
               Spacer()
           }
       }
   }
   
   private func getImageName(at index: Int) -> String {
       if index >= self.pin.count {
           return "circle"
       }
       
       if self.showPin {
           return self.pin.digits[index].numberString + ".circle"
       }
       
       return "circle.fill"
   }
   
   private func submitPin() {
       guard !pin.isEmpty else {
           showPin = false
           return
       }
       
       if pin.count == maxDigits {
           isDisabled = true
           
           handler(pin) { isSuccess in
               if isSuccess {
                   pinSuccess = true
               } else {
                   pin = ""
                   isDisabled = false
                   label = "Incorrect PIN, please try again"
               }
           }
       }
       
       if pin.count > maxDigits {
           pin = String(pin.prefix(maxDigits))
           submitPin()
       }
   }
   
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
       SignInView(accentColor: Color("MonsterLime"), handler: {pin, success in
          print(pin)
       }).environmentObject(NavigationViewModel())
          .environmentObject(AppState(loggedIn: false))
    }
}

private extension String {
    
    var digits: [Int] {
        var result = [Int]()
        
        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }
        
        return result
    }
    
}

private extension Int {
    
    var numberString: String {
        
        guard self < 10 else { return "0" }
        
        return String(self)
    }
}
