//
//  KeyboardAlikeView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/02.
//

import SwiftUI

struct KeyboardAlike: ViewModifier {
    
    let width:CGFloat
    init(){
        self.width = UIScreen.main.bounds.width
    }
    
    func body(content: Content) -> some View {
        content
            .transition(.move(edge: .bottom))
            .ignoresSafeArea()
            .frame(width:width)
            .padding(.bottom)
            .background(Color("keyboardBackground") )
    }
}

extension View{
    var keyboardAlike: some View{
        self.modifier(KeyboardAlike())
    }
}

//struct KeyboardAlikeView<Content:View>: View {
//    let content: ()->Content
//    let width:CGFloat
//    init(@ViewBuilder content: @escaping () -> Content) {
//        self.content = content
//
//        self.width = UIScreen.main.bounds.width
//    }
//    var body: some View {
//        content()
//            .transition(.move(edge: .bottom))
//            .ignoresSafeArea()
//            .frame(width:width)
//            .padding(.bottom)
//            .background(Color("keyboardBackground") )
//    }
//}
//
//struct KeyboardAlikeView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        KeyboardAlikeView{ Text("aaa") }
//
//    }
//}
