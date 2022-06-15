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
                   WelcomeNavigation(pageNumber: 1)
                   Spacer()
                }.padding()
                   .background(.white)
                   .clipShape(RoundedRectangle(cornerRadius: 45, style: .continuous))
                   .frame(height: geometry.size.height * 0.45, alignment: .bottom)
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

struct WelcomeNavigation: View {
   var pageNumber: Int
   
   var body: some View {
      let navShapes = NavShapes().setShapeOrder(pageArrayNumber: pageNumber - 1)
      
      HStack {
         HStack(spacing: 20) {
            navShapes[0]
            navShapes[1]
            navShapes[2]
         }
         Spacer()
         Button(action: {
         // Switch Views
            print("View Switch")
         }, label: {
            Image(systemName: "arrow.right.circle.fill")
               .resizable()
               .frame(width: 55, height: 55)
               .foregroundColor(Color("MonsterBase"))
         })
      }.padding()
   }
}

private struct NavShapes {
   let currentPage = AnyView(RoundedRectangle(cornerRadius: 50, style: .continuous)
                              .fill(Color("MonsterBase"))
                              .frame(width: 25, height: 10))
   let otherPage = AnyView(Circle()
                           .fill(Color("Gray"))
                           .frame(width: 10, height: 10))
   
   
   func setShapeOrder(pageArrayNumber: Int) -> [AnyView]{
      var navShapes: [AnyView] = []
      
      for index in 0...2 {
         if index == pageArrayNumber {
            navShapes.append(currentPage)
         } else {
            navShapes.append(otherPage)
         }
      }
      
      return navShapes
   }
}
