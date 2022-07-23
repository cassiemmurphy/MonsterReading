//
//  StudyListPopupView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 7/3/22.
//

import SwiftUI

struct StudyListPopupView: View {
   let title: String
   let words: [VocabWord]
   let dismiss: () -> Void
   let addList: () -> Void
   private let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
   @State var hovering = false
   
    var body: some View {
       VStack {
          Text(title).font(Font.custom("Helvetica Neue", size: 30, relativeTo: .title))
             .fontWeight(.semibold)
          LazyVGrid(columns: gridItemLayout) {
             ForEach (words, id: \.id) { word in
                Text(word.id).font(Font.custom("Helvetica Neue", size: 25, relativeTo: .title2))
             }
          }
          Button("Add List") {
             addList()
          }.foregroundColor(.white)
          .padding()
          .background(hovering ? Color(.gray) : Color("MonsterBase"))
          .clipShape(RoundedRectangle(cornerRadius: 15))
          .onHover { hovering in
             self.hovering = hovering
          }

       }
       .padding(.vertical, 40)
       .padding(.horizontal, 25)
       .frame(width: 235)
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
       StudyListPopupView(title: "Study List Group 1",
                          words: [VocabWord(id: "yes", definition: ""),
                                  VocabWord(id: "no", definition: ""),
                                  VocabWord(id: "me", definition: ""),
                                  VocabWord(id: "you", definition: "")]) {}       addList: {}
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
