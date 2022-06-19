//
//  HelperViews.swift
//  Monster Reading
//
//  Created by Murphy, Cassie on 6/15/22.
//

import SwiftUI

struct MonsterTitle: View {
   let fontSize: CGFloat
   
   var body: some View {
      HStack(spacing: 0) {
         Text("Monster")
            .font(Font.custom("Helvetica Neue", size: fontSize))
            .fontWeight(.light)
            .foregroundColor(Color("MonsterBase"))
         Text("Reading")
            .font(Font.custom("Helvetica Neue", size: fontSize))
            .fontWeight(.semibold)
            .foregroundColor(.white)
      }
   }
}

extension View {
   func withOverlayStyle(bgColor: Color, height: CGFloat, offsetY: CGFloat) -> some View {
      self.padding()
         .background(bgColor)
         .clipShape(RoundedRectangle(cornerRadius: 45, style: .continuous))
         .frame(height: height, alignment: .bottom)
         .offset(x: 0, y: offsetY)
   }
}

struct WelcomeNavigation: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @Binding var isEnabled: Bool
   
   var nextPage: NavPage
   var pageNumber: Int
   var accentColor: Color
   
   
   var body: some View {
      let navShapes = NavShapes(accentColor: accentColor).setShapeOrder(pageArrayNumber: pageNumber - 1)
      
      HStack {
         HStack(spacing: 20) {
            navShapes[0]
            navShapes[1]
            navShapes[2]
         }
         Spacer()
         Button(action: {
            navigationVM.currentPage = nextPage
         }, label: {
            Image(systemName: "arrow.right.circle.fill")
               .resizable()
               .frame(width: 55, height: 55)
               .foregroundColor(isEnabled ? accentColor : accentColor.opacity(0.5))
         }).disabled(!isEnabled)
      }.padding()
   }
}

private struct NavShapes {
   var accentColor: Color
   
   func setShapeOrder(pageArrayNumber: Int) -> [AnyView]{
      let currentPage = AnyView(RoundedRectangle(cornerRadius: 50, style: .continuous)
                                 .fill(accentColor)
                                 .frame(width: 25, height: 10))
      let otherPage = AnyView(Circle()
                              .fill(Color("Gray"))
                              .frame(width: 10, height: 10))
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

struct HelperViews_Previews: PreviewProvider {
    static var previews: some View {
       VStack {
          MonsterTitle(fontSize: 50)
          WelcomeNavigation(isEnabled: .constant(true), nextPage: .login, pageNumber: 1, accentColor: Color("MonsterBase"))
             .environmentObject(NavigationViewModel())
       }
    }
}
