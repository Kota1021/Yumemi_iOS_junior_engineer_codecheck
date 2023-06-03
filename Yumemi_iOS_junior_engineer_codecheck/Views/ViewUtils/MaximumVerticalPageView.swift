//
//  IgnoreSafeAreaView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/02.
//

import SwiftUI
import VTabView

class SafeArea:ObservableObject{
    @Published var insets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
}

/// ignores safe area.
struct MaximumVerticalPageView<Content,Selection>: View where Content:View, Selection:Hashable{
    
    let content: ()->Content
    private var selection:Binding<Selection>?
    @EnvironmentObject var safeArea: SafeArea
    
    init(selection:Binding<Selection>?, @ViewBuilder content: @escaping ()->Content) {
        
        ///ScrollView is not wanted to move around.
        UIScrollView.appearance().bounces = false
        
        self.selection = selection
        self.content = content
        
    }
    
    var body: some View {
        
        /// this GeometryReader tells the safe area towards the  SafeArea EnvironmentObject.
        /// InputView is inside MaximumVerticalPageView, which ignores safe area.
        GeometryReader{ proxy in
            
            /// this ScrollView wraps VTabView so that VTabView can fill the screen to the full.
            ///cf.https://stackoverflow.com/questions/62593923/edgesignoringsafearea-on-tabview-with-pagetabviewstyle-not-working
            ScrollView (.horizontal,showsIndicators: false){
                VTabView(selection: selection){
                    content()
                    
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .tabViewStyle(.page(indexDisplayMode: .never))
                
            }
            .ignoresSafeArea(.all)
            .onChange(of: proxy.safeAreaInsets) { newValue in
                withAnimation { safeArea.insets = newValue }
            }
            
        }
        
    }
    
}


struct IgnoreSafeAreaView_Previews: PreviewProvider {
    
    @State static private var selection:ABC = .a
    
    enum ABC{ case a,b,c }
    
    static var previews: some View {
        MaximumVerticalPageView(selection:$selection){
            Text("View1!")
                .frame(width: PreviewData.screenSize.width, height: PreviewData.screenSize.height)
                .background(.red)
                .tag(ABC.a)
            
            Text("View2!")
                .frame(width: PreviewData.screenSize.width, height: PreviewData.screenSize.height)
                .background(.green)
                .tag(ABC.b)
            
            Text("View3")
                .frame(width: PreviewData.screenSize.width, height: PreviewData.screenSize.height)
                .background(.yellow)
                .tag(ABC.c)
            
        }
    }
}
