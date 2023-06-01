//
//  PrefectureImageInfo.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import Foundation
//Json

struct PrefectureImageInfo: Codable {
    let id: String
    let urlImage: String
    let title: String
    let author: String
    let prefCode: String
    let pref:String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case urlImage = "url_image"
        case title
        case author
        case prefCode = "pref_code"
        case pref
    }
}


struct PrefectureImageInfoSets{
    let imageInfoSets:[PrefectureImageInfo] = load("find47images.json")
    
    public func infoSets(of prefectureCode: Int)-> [PrefectureImageInfo]{
        return imageInfoSets//.filter{$0.prefCode == prefectureCode }
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

// made by ChatGPT, needs to check.
//enum Prefecture: Int {
//    case hokkaido
//    case aomori
//    case iwate
//    case miyagi
//    case akita
//    case yamagata
//    case fukushima
//    case ibaraki
//    case tochigi
//    case gunma
//    case saitama
//    case chiba
//    case tokyo
//    case kanagawa
//    case niigata
//    case toyama
//    case ishikawa
//    case fukui
//    case yamanashi
//    case nagano
//    case gifu
//    case shizuoka
//    case aichi
//    case mie
//    case shiga
//    case kyoto
//    case osaka
//    case hyogo
//    case nara
//    case wakayama
//    case tottori
//    case shimane
//    case okayama
//    case hiroshima
//    case yamaguchi
//    case tokushima
//    case kagawa
//    case ehime
//    case kochi
//    case fukuoka
//    case saga
//    case nagasaki
//    case kumamoto
//    case oita
//    case miyazaki
//    case kagoshima
//    case okinawa
//
//    var code:Int{
//        switch self{
//        case .hokkaido: return 1
//        case .aomori: return 2
//        case .iwate: return 3
//        case .miyagi: return 4
//        case .akita: return 5
//        case .yamagata: return 6
//        case .fukushima: return 7
//        case .ibaraki: return 8
//        case .tochigi: return 9
//        case .gunma: return 10
//        case .saitama: return 11
//        case .chiba: return 12
//        case .tokyo: return 13
//        case .kanagawa: return 14
//        case .niigata: return 15
//        case .toyama: return 16
//        case .ishikawa: return 17
//        case .fukui: return 18
//        case .yamanashi: return 19
//        case .nagano: return 20
//        case .gifu: return 21
//        case .shizuoka: return 22
//        case .aichi: return 23
//        case .mie: return 24
//        case .shiga: return 25
//        case .kyoto: return 26
//        case .osaka: return 27
//        case .hyogo: return 28
//        case .nara: return 29
//        case .wakayama: return 30
//        case .tottori: return 31
//        case .shimane: return 32
//        case .okayama: return 33
//        case .hiroshima: return 34
//        case .yamaguchi: return 35
//        case .tokushima: return 36
//        case .kagawa: return 37
//        case .ehime: return 38
//        case .kochi: return 39
//        case .fukuoka: return 40
//        case .saga: return 41
//        case .nagasaki: return 42
//        case .kumamoto: return 43
//        case .oita: return 44
//        case .miyazaki: return 45
//        case .kagoshima: return 46
//        case .okinawa: return 47
//        }
//
//    }
//
//    var alphabetName: String {
//        switch self {
//        case .hokkaido: return "Hokkaido"
//        case .aomori: return "Aomori"
//        case .iwate: return "Iwate"
//        case .miyagi: return "Miyagi"
//        case .akita: return "Akita"
//        case .yamagata: return "Yamagata"
//        case .fukushima: return "Fukushima"
//        case .ibaraki: return "Ibaraki"
//        case .tochigi: return "Tochigi"
//        case .gunma: return "Gunma"
//        case .saitama: return "Saitama"
//        case .chiba: return "Chiba"
//        case .tokyo: return "Tokyo"
//        case .kanagawa: return "Kanagawa"
//        case .niigata: return "Niigata"
//        case .toyama: return "Toyama"
//        case .ishikawa: return "Ishikawa"
//        case .fukui: return "Fukui"
//        case .yamanashi: return "Yamanashi"
//        case .nagano: return "Nagano"
//        case .gifu: return "Gifu"
//        case .shizuoka: return "Shizuoka"
//        case .aichi: return "Aichi"
//        case .mie: return "Mie"
//        case .shiga: return "Shiga"
//        case .kyoto: return "Kyoto"
//        case .osaka: return "Osaka"
//        case .hyogo: return "Hyogo"
//        case .nara: return "Nara"
//        case .wakayama: return "Wakayama"
//        case .tottori: return "Tottori"
//        case .shimane: return "Shimane"
//        case .okayama: return "Okayama"
//        case .hiroshima: return "Hiroshima"
//        case .yamaguchi: return "Yamaguchi"
//        case .tokushima: return "Tokushima"
//        case .kagawa: return "Kagawa"
//        case .ehime: return "Ehime"
//        case .kochi: return "Kochi"
//        case .fukuoka: return "Fukuoka"
//        case .saga: return "Saga"
//        case .nagasaki: return "Nagasaki"
//        case .kumamoto: return "Kumamoto"
//        case .oita: return "Oita"
//        case .miyazaki: return "Miyazaki"
//        case .kagoshima: return "Kagoshima"
//        case .okinawa: return "Okinawa"
//        }
//    }
//
//    func from(string:String)->Prefecture{
//        switch string{
//
//        }
//    }
//}

