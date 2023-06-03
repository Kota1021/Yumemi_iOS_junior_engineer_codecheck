//
//  VPageViewAnimationTest.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//

import SwiftUI

struct TestView:View{
    @State private var selection:ABC = .a
    @State private var isViewBDisplayed = false
    enum ABC{ case a,b,c }
    var body: some View{
        MaximumVerticalPageView(selection:$selection){
            Text("View1!")
                .frame(width: PreviewData.screenSize.width, height: PreviewData.screenSize.height)
                .background(.red)
                .tag(ABC.a)
            if isViewBDisplayed{
                Text("View2!")
                    .frame(width: PreviewData.screenSize.width, height: PreviewData.screenSize.height)
                    .background(.green)
                    .tag(ABC.b)
            }
            Text("View3")
                .frame(width: PreviewData.screenSize.width, height: PreviewData.screenSize.height)
                .background(.yellow)
                .tag(ABC.c)
            
        }.overlay{
            VStack{
                Spacer()
                Button("change pages to view2") {
                    print("tapped")
                    displayViewB()
                    print("selection: \(selection)")
                }.buttonStyle(.borderedProminent)
            }
        }
    }
    func displayViewB(){
        isViewBDisplayed = true
        
        withAnimation {
            selection = ABC.b
        }
    }
}


struct Previews_VPageViewAnimationTest_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
