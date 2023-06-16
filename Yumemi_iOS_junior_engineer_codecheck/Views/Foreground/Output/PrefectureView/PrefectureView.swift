//
//  OutputView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI

struct PrefectureView: View {
    let prefecture: Prefecture
    @State private var isMapPoppingOver = false
    @State private var isBriefPoppedOver = false

    private var isThereAnyPopOver: Bool { isMapPoppingOver || isBriefPoppedOver }

    var mapPopOverSize: CGSize {
        let width = Screen.size.width
        let height = Screen.size.height
        if width < height {
            return CGSize(width: width * 4 / 5, height: width * 5 / 5)
        } else {
            return CGSize(width: height * 5 / 5, height: height * 4 / 5)
        }
    }

    var body: some View {
        VStack {
            ImagePageView(
                imagesInfo: prefecture.images,
                viewSize: CGSize(width: Screen.size.width, height: Screen.size.height / 2))
            DetailView(
                prefecture: prefecture,
                isBreafViewExpanded: $isBriefPoppedOver,
                isMapExpanded: $isMapPoppingOver)
            Spacer()
        }
        .frame(width: Screen.size.width, height: Screen.size.height)
        .background(Color(.systemBackground))

        //Below popups
        .blur(radius: isThereAnyPopOver ? 10 : 0)
        .overlay {
            if isBriefPoppedOver {
                BriefCardView(text: prefecture.brief)
                    .background(
                        Color.clear
                            .contentShape(Rectangle())
                            .frame(width: Screen.size.width, height: Screen.size.height)
                            // Empty gestures prevents unintended scrolling.
                            .gesture(DragGesture())
                            .gesture(MagnificationGesture())
                            .onTapGesture { withAnimation { isBriefPoppedOver = false } }
                    )
            } else if isMapPoppingOver {
                // map pop over is for iOS
                MapView(pinLocation: prefecture.location)
                    .transition(.scale(scale: 0, anchor: UnitPoint(x: 0.7, y: 0.7)))
                    .frame(width: mapPopOverSize.width, height: mapPopOverSize.height)
                    .background(
                        Color.clear
                            .contentShape(Rectangle())
                            .frame(width: Screen.size.width, height: Screen.size.height)
                            // Empty gestures prevents unintended scrolling.
                            .gesture(DragGesture())
                            .gesture(MagnificationGesture())
                            .onTapGesture { withAnimation { isMapPoppingOver = false } }
                    )

            }
        }

    }
}

struct PrefectureView_Previews: PreviewProvider {

    
    static var previews: some View {
        PrefectureView(prefecture: PreviewData.prefecture)
        
    }
}
