//
//  IgnoreSafeAreaView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/02.
//

import SwiftUI
import VTabView

/// ignores safe area.
struct MaximumVerticalPageView<Content,Selection>: View where Content:View, Selection:Hashable{
    
    let content: ()->Content
    private var selection:Binding<Selection>?
    
    init(selection:Binding<Selection>?, @ViewBuilder content: @escaping ()->Content) {
        
        ///ScrollView is not wanted to move around.
        UIScrollView.appearance().bounces = false
        
        self.selection = selection
        self.content = content
    }
    
    var body: some View {
        /// this ScrollView wraps VTabView so that VTabView can fill the screen to the full.
        ///cf.https://stackoverflow.com/questions/62593923/edgesignoringsafearea-on-tabview-with-pagetabviewstyle-not-working
        ScrollView (.horizontal,showsIndicators: false){
            VTabView(selection: selection){
                content()
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .tabViewStyle(.page(indexDisplayMode: .never))
        }.ignoresSafeArea(.all)
    }
}

struct IgnoreSafeAreaView_Previews: PreviewProvider {
    @State static private var selection:ABC = .a
    enum ABC{ case a,b,c }
    static var previews: some View {
        MaximumVerticalPageView(selection:$selection){
            Text("Hello, World!").tag(ABC.a)
            Text("Hello, World!").tag(ABC.b)
            Text("Hello, World!").tag(ABC.c)
        }
    }
}
