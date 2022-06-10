//
//  TempView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/9/22.
//

import SwiftUI

struct TempView: View {
    var body: some View {
       GeometryReader { geometry in
          ZStack {
             Rectangle()
                .fill(Color("MonsterLime"))
                .ignoresSafeArea()
                .overlay(alignment: .bottom, content: {
                   Card1()
                      .background(Color("MonsterBase"))
                      .clipShape(RoundedRectangle(cornerRadius: 45))
                      .frame(height: geometry.size.height * 0.4)
                      .offset(x: 0, y: 35)
                })
          }
       }
    }
}

struct TempView_Previews: PreviewProvider {
    static var previews: some View {
       Group {
          TempView()
             .previewInterfaceOrientation(.portrait)
       }
    }
}

struct Card1: View {
   var body: some View {
      VStack {
         Text("WORD").font(.system(size: 72))
         Spacer()
         HStack {
            Spacer()
            Image(systemName: "mic.circle.fill")
               .imageScale(.large)
            Spacer()
            Image(systemName: "speaker.wave.2.fill")
               .imageScale(.large)
            Spacer()
         }
         Spacer()
      }.padding()
   }
   
}
