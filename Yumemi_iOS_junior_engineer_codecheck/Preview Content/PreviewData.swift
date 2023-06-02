//
//  PreviewData.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/02.
//

import Foundation
import SwiftUI

struct PreviewData{
    
    static var screenSize:CGSize = UIScreen.main.bounds.size
    static var luckyPrefecture = Prefecture(name: "徳島県", brief: "徳島県（とくしまけん）は、日本の四国地方に位置する県。県庁所在地は徳島市。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』", capital: "徳島市", citizenDay: nil, hasCoastLine: true, logoUrl: URL(string: "https://japan-map.com/wp-content/uploads/tokushima.png")!)
    
    static var luckyPrefectureImageInfoSets:[PrefectureImageInfo]?{
        let prefCode = prefectureCode(from: luckyPrefecture.name)
        guard let prefCode = prefCode else{
            print("prefCode nil. prefecture: \(luckyPrefecture)")
            return nil }
        return  PrefectureImageInfoSets().infoSets(of: prefCode)
    }
}
