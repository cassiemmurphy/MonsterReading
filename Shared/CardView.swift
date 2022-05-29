//
//  CardView.swift
//  Reading Flashcards
//
//  Created by Murphy, Cassie on 5/29/22.
//

import SwiftUI

struct CardView: View {
   let card: Card
   
//   @State private var isShowingAnswer = false
   
    var body: some View {
       ZStack {
          RoundedRectangle(cornerRadius: 25, style: .continuous)
             .fill(.white)
          
          VStack{
             Text(card.prompt)
                .font(.largeTitle)
                .foregroundColor(.black)
             
             Text(card.answer)
                .font(.title)
                .foregroundColor(.gray)
          }
          .padding()
          .multilineTextAlignment(.center)
       }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
       CardView(card: Card.example)
    }
}