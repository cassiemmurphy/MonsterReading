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
                   CardView(word: WordManager(word: "hat", definition: "Item worn on head"))
                      .background(Color("MonsterBase"))
                      .clipShape(RoundedRectangle(cornerRadius: 45, style: .continuous))
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
