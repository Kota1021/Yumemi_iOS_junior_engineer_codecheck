//
//  OutputView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI

struct PrefectureView: View {
    
    let prefecture: Prefecture
    @EnvironmentObject var screen:ScreenSize
    @State private var isMapPoppedOver = false
    @State private var isBriefPoppedOver = false
    
    private var isThereAnyPopOver: Bool{ isMapPoppedOver || isBriefPoppedOver }
    
    var body: some View {
        GeometryReader{ proxy in
            VStack{
                ImagePageView(imagesInfo: prefecture.images, viewSize: CGSize(width: proxy.size.width, height: proxy.size.height/2) )
                DetailView(prefecture: prefecture,
                           isBreafViewExpanded:$isBriefPoppedOver,
                           isMapExpanded: $isMapPoppedOver)
                Spacer()
            }
            .frame(width: screen.width, height: screen.height)
            .background(Color(.systemBackground) )
            .blur(radius: isThereAnyPopOver ? 10 : 0)
            .overlay{
                if isBriefPoppedOver{
                    BriefCardView(isDisplayed: $isBriefPoppedOver,
                                  text: prefecture.brief,
                                  viewSize: proxy.size)
                    
                }else if isMapPoppedOver{
                    ExpandedMap(isDisplayed:$isMapPoppedOver, viewSize:proxy.size, pinLocation:  prefecture.location)
                    
                }
            }
            
        }
        
    }
}

struct PrefectureView_Previews: PreviewProvider {
    
    static var previews: some View {
        PrefectureView(prefecture:PreviewData.prefecture)
            .environmentObject(ScreenSize(size: PreviewData.screenSize))
    }
}



