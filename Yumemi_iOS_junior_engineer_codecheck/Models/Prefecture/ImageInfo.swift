//
//  PrefectureImageInfo.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import Foundation

///this holds imageInfoSets data.
struct ImageInfoSets {

    private init() {}  // Singleton like. No need for initializing this data holding struct.
    static private let data: [PrefectureImageInfo] = load("find47images.json")

    static public func items(of prefecture: String) -> [PrefectureImageInfo] {
        let prefectureItems = data.filter { $0.pref == prefecture }
        
        guard !prefectureItems.isEmpty else {
            fatalError("ImageInfoSets: items of \(prefecture) not found")
        }
        return prefectureItems
    }
    
    static public func thumbnailURLs(of prefecture: String) -> [URL]{
        let urls = items(of:prefecture).map{ $0.urlThumb }
        return urls
    }
    
    static public func randomThumbnailURL(of prefecture: String) -> URL{
        self.thumbnailURLs(of: prefecture).shuffled().first!
    }
    
}

///Photos from website find/47
struct PrefectureImageInfo: Decodable, Identifiable {
    let id: String
    let url: URL
    let urlThumb: URL
    let title: String
    let author: String
    let prefCodeStr: String  // ここがIntで受け取りたいが、JSONがprefCode: "44"のようになっている。
    let pref: String

    var prefCode: Int {
        if let prefCode = Int(prefCodeStr) {
            return prefCode
        } else {
            fatalError("prefCodeStr cannot be transformed into Int. prefCodeStr: \(prefCodeStr)")
        }
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case url = "url_image"
        case urlThumb = "url_thumb"
        case title
        case author
        case prefCodeStr = "pref_code"
        case pref
    }
}
