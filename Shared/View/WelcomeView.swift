//
//  WelcomeView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/15/22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
       GeometryReader { geometry in
          ZStack {
             // FIXME: Image looks too dark, issue with overlay in asset?
             Image("BackgroundFilled")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
             VStack {
                Spacer()
                // FIXME: Need actual size or ratio to put in.
                Image("FaceLogo")
                   .resizable()
                   .frame(width: 150, height: 150, alignment: .center)
                HStack(spacing: 0) {
                   Text("Monster")
                      .font(Font.custom("Helvetica Neue", size: 50))
                      .fontWeight(.light)
                      .foregroundColor(Color("MonsterBase"))
                   Text("Reading")
                      .font(Font.custom("Helvetica Neue", size: 50))
                      .foregroundColor(.white)
                }
                Spacer()
                VStack(alignment: .leading) {
                   VStack(alignment: .leading) {
                      Text("Welcome to MonsterReading")
                         .font(Font.custom("Helvetica Neue", size: 45))
                         .fontWeight(.light)
                      Text("Get ready to learn")
                         .font(Font.custom("Helvetica Neue", size: 16))
                         .fontWeight(.light)
                         .foregroundColor(.gray)
                   }.padding()
                   Spacer()
                   HStack {
                  // FIXME: Random image for now in place of navigation dots
                      Image(systemName: "arrow.left.circle.fill")
                         .foregroundColor(Color("MonsterBase"))
                      Spacer()
                      Image(systemName: "arrow.right.circle.fill")
                         .foregroundColor(Color("MonsterBase"))
                   }.padding()
                   Spacer()
                }  .background(.white)
                   .clipShape(RoundedRectangle(cornerRadius: 45, style: .continuous))
                   .frame(height: geometry.size.height * 0.4, alignment: .bottom)
                // FIXME: Not happy with all odd spacing

             }
          }.frame(height: geometry.size.height)

       }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
