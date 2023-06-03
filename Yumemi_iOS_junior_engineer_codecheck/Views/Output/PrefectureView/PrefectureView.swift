//
//  OutputView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI

struct PrefectureView: View {
    
    let prefacture: Prefecture
    
    @State private var isMapPoppedOver = false
    @State private var isBriefPoppedOver = false
    private var isThereAnyPopOver: Bool{ isMapPoppedOver || isBriefPoppedOver }
    
    var body: some View {
        GeometryReader{ proxy in
            VStack{
                
                ImagePageView(imagesInfo: prefacture.images, viewSize: CGSize(width: proxy.size.width, height: proxy.size.height/2) )
                DetailView(prefecture: prefacture,
                           isBreafViewExpanded:$isBriefPoppedOver,
                           isMapExpanded: $isMapPoppedOver)
                Spacer()
            }.frame(width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height)
            .background(Color(.systemBackground) )
            .blur(radius: isThereAnyPopOver ? 10 : 0)
            .overlay{
                if isBriefPoppedOver{
                    BriefCardView(isDisplayed: $isBriefPoppedOver,
                                  text: prefacture.brief,
                                  viewSize: proxy.size)
                    
                }
                if isMapPoppedOver{
                    MapView(isDisplayed:$isMapPoppedOver, viewSize:proxy.size, pinLocation:  prefacture.location)
                    
                }
            }
        }
        
    }
}

struct PrefectureView_Previews: PreviewProvider {
    
    static var previews: some View {
        PrefectureView(prefacture:PreviewData.prefecture)
    }
}



