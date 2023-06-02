//
//  PrefectureImageInfo.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import Foundation

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

struct PrefectureImageInfoSets{
    static let imageInfoSets:[PrefectureImageInfo] = load("find47images.json")
    
    static public func infoSets(of prefecture: String)-> [PrefectureImageInfo]{
        return imageInfoSets.filter{$0.pref == prefecture }
    }
}
