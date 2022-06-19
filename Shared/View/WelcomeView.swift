//
//  WelcomeView.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/15/22.
//

import SwiftUI

//FIXME: Look into using tab view

struct WelcomeView: View {
   @EnvironmentObject var appState: AppState
   
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
                MonsterTitle(fontSize: 50)
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
                   WelcomeNavigation(pageNumber: 1, accentColor: Color("MonsterBase"))
                   Spacer()
                }.withOverlayStyle(bgColor: .white,
                                     height: geometry.size.height * 0.45,
                                     offsetY: .zero)
             }
             // FIXME: Check size issues on all devices..
          }.frame(height: geometry.size.height)

       }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}




