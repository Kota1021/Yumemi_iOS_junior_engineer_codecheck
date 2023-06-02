//
//  OutputView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI

struct PrefectureView: View {
    
    let prefacture:Prefecture
    let imagesInfo:[PrefectureImageInfo]
    let position: IdentifiablePlace
    
    @State private var isMapExpanded = false
    @State private var isBreafViewExpanded = false
    private var isBulured: Bool{ isMapExpanded || isBreafViewExpanded }
    
    
    var body: some View {
        GeometryReader{proxy in
            VStack{
                ImagePageView(imagesInfo: imagesInfo, viewSize: CGSize(width: proxy.size.width, height: 450) )
                InfoView(prefecture: prefacture,
                         isBreafViewExpanded:$isBreafViewExpanded,
                         isMapExpanded: $isMapExpanded)
            }.background(Color(.systemBackground))
            .blur(radius: isBulured ? 10 : 0)
                .overlay{
                    if isBreafViewExpanded{
                        BriefCardView(isDisplayed: $isBreafViewExpanded,
                                      text: prefacture.brief,
                                      viewSize: proxy.size)

                    }
                    if isMapExpanded{
                        MapView(isDisplayed:$isMapExpanded, viewSize:proxy.size, pinPosition:  position)
                    }
                }
        }
        
    }
}

struct PrefectureView_Previews: PreviewProvider {
    
    static var luckyPrefecture = Prefecture(name: "徳島県", brief: "徳島県（とくしまけん）は、日本の四国地方に位置する県。県庁所在地は徳島市。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』", capital: "徳島市", citizenDay: nil, hasCoastLine: true, logoUrl: URL(string: "https://japan-map.com/wp-content/uploads/tokushima.png")!)
    
    static private var luckyPrefectureImageInfoSets:[PrefectureImageInfo]?{
        let prefCode = prefectureCode(from: luckyPrefecture.name)
        guard let prefCode = prefCode else{
            print("prefCode nil. prefecture: \(luckyPrefecture)")
            return nil }
        return  PrefectureImageInfoSets().infoSets(of: prefCode)
    }
    
    static var previews: some View {
//        PrefectureView()
        PrefectureView(prefacture:luckyPrefecture, imagesInfo: luckyPrefectureImageInfoSets!, position: IdentifiablePlace(lat: 39, long: 138))
    }
}



