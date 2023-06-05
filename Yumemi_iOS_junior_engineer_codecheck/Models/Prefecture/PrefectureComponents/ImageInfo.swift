//
//  PrefectureImageInfo.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import Foundation

///this holds imageInfoSets data.
struct PrefectureImageInfoSets{
    
    private init(){} // Singleton like. No need for initializing this data holding struct.
    static public let imageInfoSets:[PrefectureImageInfo] = load("find47images.json")
    static public func infoSets(of prefecture: String) -> [PrefectureImageInfo]{
        return imageInfoSets.filter{$0.pref == prefecture }
    }
    static public func thumbnailURL(of prefecture: String) -> URL{
        let prefectureImageInfoSets = imageInfoSets.filter{$0.pref == prefecture }
        guard let imageInfo = prefectureImageInfoSets.shuffled().first else {
            fatalError("PrefectureImageInfoSets: image info not found. of \(prefecture)")
        }
        return imageInfo.url
    }
}

///Photos from website find/47
struct PrefectureImageInfo: Decodable,Identifiable {
    let id: String
    let url: URL
    let title: String
    let author: String
    let prefCodeStr: String// ここがIntで受け取りたいが、JSONがprefCode: "44"のようになっている。
    let pref:String
    
    var prefCode:Int{
        if let prefCode = Int(prefCodeStr){
            return prefCode
        }else{
            fatalError("prefCodeStr cannot be transformed into Int. prefCodeStr: \(prefCodeStr)")
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case url = "url_image"
        case title
        case author
        case prefCodeStr = "pref_code"
        case pref
    }
}
