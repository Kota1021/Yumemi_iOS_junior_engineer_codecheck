//
//  PopOver.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/06.
//

import SwiftUI

struct PopOver<Content:View>: View {
    @EnvironmentObject var screen:ScreenSize
    @Binding var isThereAnyPopOver:Bool
    let content:  ()->Content
    
    init(isThereAnyPopOver: Binding<Bool>, content: @escaping () -> Content) {
        self._isThereAnyPopOver = isThereAnyPopOver
        self.content = content
    }
//    init(content: @escaping () -> Content) {
//        self.content = content
//    }
    
    var body: some View {
//        if isThereAnyPopOver{
            Group{

                content()
        }
            .background(
                Color.clear
                    .contentShape(Rectangle())
                    .frame(width: screen.size.width, height: screen.size.height)
                // Empty gestures prevents unintended scrolling.
                    .gesture(DragGesture())
                    .gesture(MagnificationGesture())
                    .onTapGesture { withAnimation{ isThereAnyPopOver = false } }
            )
//    }
    }
}

struct PopOver_Previews: PreviewProvider {
    @State static var isThereAnyPopOver = true
    @State static var isBriefPoppedOver = false
    @State static var isMapPoppingOver = false
    static var mapPopOverSize:CGSize{
        let width = PreviewData.screenSize.width
        let height = PreviewData.screenSize.height
        if width < height{
            return CGSize(width: width * 4/5, height: width * 5/5)
        }else{
            return CGSize(width: height * 5/5, height: height * 4/5)
        }
    }
    
    static var previews: some View {
//        Text("aaa")
        PopOver(isThereAnyPopOver:$isThereAnyPopOver ){
//            if isBriefPoppedOver{
                BriefCardView(text: PreviewData.prefecture.brief/*,
                    viewSize: screen.size*/)

//            }else if isMapPoppingOver{
//                // map pop over is for iOS
//                MapView(pinLocation:  PreviewData.prefecture.location)
//                    .transition(.scale(scale: 0,anchor: UnitPoint(x: 0.7, y: 0.7)))
//                    .frame(width:  mapPopOverSize.width,height:  mapPopOverSize.height)
//
//
//            }
        }
            .environmentObject(ScreenSize())
    }
}
