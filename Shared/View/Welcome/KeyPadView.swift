//
//  KeyPadView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/19/22.
//

import SwiftUI

struct KeyPadView: View {
   @Binding var pin: String
   @Binding var isDisabled: Bool

       var body: some View {
           VStack {
              KeyPadRow(keys: ["1", "2", "3"], isDisabled: $isDisabled)
              KeyPadRow(keys: ["4", "5", "6"], isDisabled: $isDisabled)
              KeyPadRow(keys: ["7", "8", "9"], isDisabled: $isDisabled)
              KeyPadRow(keys: ["faceid", "0", "⌫"], isDisabled: $isDisabled)
           }.environment(\.keyPadButtonAction, self.keyWasPressed(_:))
       }

       private func keyWasPressed(_ key: String) {
           switch key {
           case "faceid":
              print("Use FaceID here")
              break
           case "⌫":
              if pin.isEmpty {
                 pin = ""
                 break
              }
              pin.removeLast()
           case _ where pin == "0": pin = key
           default: pin += key
           }
       }
}

struct KeypadView_Previews: PreviewProvider {
    static var previews: some View {
       KeyPadView(pin: .constant(" "), isDisabled: .constant(false))
    }
}

struct KeyPadButton: View {
   @Binding var isDisabled: Bool
   var key: String

   var body: some View {
     Button(action: { self.action(self.key) }) {
        if key == "faceid" {
           Color.clear
             .overlay(Image(systemName: key).foregroundColor(.black))
        } else {
           Color.clear
             .overlay(Text(key).foregroundColor(.black))
        }
     }.disabled(isDisabled)
   }

   enum ActionKey: EnvironmentKey {
     static var defaultValue: (String) -> Void { { _ in } }
   }

   @Environment(\.keyPadButtonAction) var action: (String) -> Void
}

extension EnvironmentValues {
   var keyPadButtonAction: (String) -> Void {
     get { self[KeyPadButton.ActionKey.self] }
     set { self[KeyPadButton.ActionKey.self] = newValue }
   }
}

struct KeyPadRow: View {
   var keys: [String]
   @Binding var isDisabled: Bool

   var body: some View {
     HStack {
         ForEach(keys, id: \.self) { key in
            KeyPadButton(isDisabled: $isDisabled, key: key)
         }
     }
   }
}


