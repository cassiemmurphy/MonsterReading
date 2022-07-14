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
   
   func glowBorder(color: Color, lineWidth: Int) -> some View {
       self.modifier(GlowBorder(color: color, lineWidth: lineWidth))
   }
}

struct WelcomeNavigation: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @Binding var isEnabled: Bool
   
   var pageNumber: Int
   var accentColor: Color
   var action: () -> Void
   
   
   
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
            action()
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

struct MenuTop: View {
   @EnvironmentObject var navigationVM: NavigationViewModel
   @EnvironmentObject var authVM: AuthViewModel
   @State var showPopover = false
   var previousPage: NavPage = .home
   
   var body: some View {
      HStack {
         Button(action: {
            if authVM.userSeission == nil {
               navigationVM.currentPage = previousPage
            } else {
               navigationVM.currentPage = .home
            }
         }, label: {
            Image(systemName: authVM.userSeission == nil ? "chevron.left" : "house.fill")
               .resizable()
               .scaledToFit()
               .frame(height: 25)
               .foregroundColor(.white)
         })
         Spacer()
         MonsterTitle(fontSize: 30)
         Spacer()
         Button {
            withAnimation {
               if authVM.userSeission == nil {
                  showPopover.toggle()
               }
            }
         } label: {
            Image("FaceLogo")
               .resizable()
               .frame(width: 30, height: 30)
         }
      }
      .frame(height: 35)
      .iconPopover(show: $showPopover) {
         VStack(alignment: .leading, spacing: 15) {
            if let child = authVM.childUser {
               HStack {
                  Image(child.monster)
                  Text(child.name)
               }
            }
            Button("Switch Profile") {
               navigationVM.currentPage = .childSelection
            }
            Button("Parent Profile") {
               print("Parent Profile")
            }
            Button("Sign Out") {
               authVM.signOut()
               // TODO: test if this is needed or automatic
               navigationVM.currentPage = .welcome
            }
         }
       }
   }
}


struct HelperViews_Previews: PreviewProvider {
    static var previews: some View {
       VStack {
          MenuTop()
             .environmentObject(NavigationViewModel())
             .environmentObject(AuthViewModel())
          MonsterTitle(fontSize: 50)
          WelcomeNavigation(isEnabled: .constant(true),
                            pageNumber: 1,
                            accentColor: Color("MonsterBase"),
                            action: {})
             .environmentObject(NavigationViewModel())
       }.background(Color("MonsterPurple"))
    }
}

struct GlowBorder: ViewModifier {
    var color: Color
    var lineWidth: Int
    
    func body(content: Content) -> some View {
        applyShadow(content: AnyView(content), lineWidth: lineWidth)
    }
    
    func applyShadow(content: AnyView, lineWidth: Int) -> AnyView {
        if lineWidth == 0 {
            return content
        } else {
            return applyShadow(content: AnyView(content.shadow(color: color, radius: 1)), lineWidth: lineWidth - 1)
        }
    }
}
