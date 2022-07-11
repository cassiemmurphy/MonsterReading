//
//  StudyListPopupView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/3/22.
//

import SwiftUI

struct StudyListPopupView: View {
   let dismiss: () -> Void
   private let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
   private let words = ["yes", "no", "I", "me", "you", "him", "she"]
   
    var body: some View {
       VStack {
          Text("Sight Words Group 1").font(.title)
          LazyVGrid(columns: gridItemLayout) {
             ForEach (words, id: \.self) { word in
                Text(word)
             }
          }
       }
       .padding(.vertical, 70)
       .frame(width: 250)
       .background(.white)
       .clipShape(RoundedRectangle(cornerRadius: 25))
       .overlay(alignment: .topTrailing) {
          close
       }
       .transition(.scale)
          
    }
}

struct StudyListPopupView_Previews: PreviewProvider {
    static var previews: some View {
       StudyListPopupView {}
         
//         title: "Study List Title",
//                           words: [VocabWord(id: "yes", definition: ""),
//                                   VocabWord(id: "no", definition: ""),
//                                   VocabWord(id: "me", definition: ""),
//                                   VocabWord(id: "you", definition: "")],
//                           model: StudyListViewModel())
    }
}

private extension StudyListPopupView {
   var close: some View {
      Button {
         dismiss()
      } label: {
         Image(systemName: "xmark")
            .symbolVariant(.circle.fill)
            .font(.system(size: 35, weight: .bold, design: .rounded))
            .foregroundStyle(.gray.opacity(0.4))
            .padding(8)
      }
   }
}
