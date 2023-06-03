//
//  KeyboardAlikeView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/02.
//

import SwiftUI

struct KeyboardAlikeView<Content:View>: View {
    @EnvironmentObject var screen:ScreenSize
    let content: ()->Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        content()
            .transition(.move(edge: .bottom))
            .ignoresSafeArea()
            .frame(width:screen.width)
            .padding(.bottom)
            .background(Color("keyboardBackground") )
    }
}

struct KeyboardAlikeView_Previews: PreviewProvider {

    static var previews: some View {
        KeyboardAlikeView{ Text("aaa") }
            .environmentObject(ScreenSize(size: PreviewData.screenSize))

    }
}
