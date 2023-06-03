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
    static var luckyPrefecture = LuckyPrefecture(name: "徳島県", brief: "徳島県（とくしまけん）は、日本の四国地方に位置する県。県庁所在地は徳島市。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』", capital: "徳島市", citizenDay: nil, hasCoastLine: true, logoUrl: URL(string: "https://japan-map.com/wp-content/uploads/tokushima.png")!)
    
    static var prefecture = Prefecture(name: "徳島県", brief: "徳島県（とくしまけん）は、日本の四国地方に位置する県。県庁所在地は徳島市。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』", capital: "徳島市", citizenDay: nil, hasCoastLine: true, logoUrl: URL(string: "https://japan-map.com/wp-content/uploads/tokushima.png")!, location: PinLocation(lat: 40, long: 130), images: [PrefectureImageInfo(id: "", url: URL(string: "https://japan-map.com/wp-content/uploads/tokushima.png")!, title: "test", author: "test", prefCodeStr: "1", pref: "test ")])
    
    static let devices:[Device] = [.init(name: "iPhone 14 Plus", previewTitle: "iPhone 14 Plus 6.7"),
                                   .init(name: "iPhone 14 Pro", previewTitle: "iPhone 14 Pro 6.1"),
                                   .init(name: "iPhone 13 mini", previewTitle: "iPhone 13 mini"),
                                   .init(name: "iPhone 11 Pro", previewTitle: "iPhone 11 Pro 5.85"),
                                   .init(name: "iPhone SE (3rd generation)", previewTitle: "iPhone SE 3rd gen 4.7")]
}

struct Device:Hashable,Identifiable{
    var id = UUID()
    var name:String
    var previewTitle:String
}
