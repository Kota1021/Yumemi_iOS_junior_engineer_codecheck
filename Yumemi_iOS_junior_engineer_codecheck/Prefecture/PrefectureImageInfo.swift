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
    let imageInfoSets:[PrefectureImageInfo] = load("find47images.json")
    
    public func infoSets(of prefectureCode: Int)-> [PrefectureImageInfo]{
        return imageInfoSets.filter{$0.prefCode == prefectureCode }
    }
}

func prefectureCode(from prefecture:String)->Int?{
    switch prefecture{
    case  "北海道": return 1
    case  "青森県": return 2
    case  "岩手県": return 3
    case  "宮城県": return 4
    case  "秋田県": return 5
    case  "山形県": return 6
    case  "福島県": return 7
    case  "茨城県": return 8
    case  "栃木県": return 9
    case  "群馬県": return 10
    case  "埼玉県": return 11
    case  "千葉県": return 12
    case  "東京都": return 13
    case  "神奈川県": return 14
    case  "新潟県": return 15
    case  "富山県": return 16
    case  "石川県": return 17
    case  "福井県": return 18
    case  "山梨県": return 19
    case  "長野県": return 20
    case  "岐阜県": return 21
    case  "静岡県": return 22
    case  "愛知県": return 23
    case  "三重県": return 24
    case  "滋賀県": return 25
    case  "京都府": return 26
    case  "大阪府": return 27
    case  "兵庫県": return 28
    case  "奈良県": return 29
    case  "和歌山県": return 30
    case  "鳥取県": return 31
    case  "島根県": return 32
    case  "岡山県": return 33
    case  "広島県": return 34
    case  "山口県": return 35
    case  "徳島県": return 36
    case  "香川県": return 37
    case  "愛媛県": return 38
    case  "高知県": return 39
    case  "福岡県": return 40
    case  "佐賀県": return 41
    case  "長崎県": return 42
    case  "熊本県": return 43
    case  "大分県": return 44
    case  "宮崎県": return 45
    case  "鹿児島県": return 46
    case  "沖縄県": return 47
    default: return nil
    }
}
