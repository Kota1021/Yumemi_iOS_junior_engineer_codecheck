//
//  PrefectureModel.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//


import Foundation
import Alamofire
import Combine

protocol PrefectureModelProtocol:ObservableObject{
    var prefecture:Prefecture? { get }
    var error:AFError? { get }
    func fetchLuckyPrefecture(input:FortuneInput)
}

//PrefectureModel does not know view
class PrefectureModel: ObservableObject, PrefectureModelProtocol{
    
    @Published private(set) var prefecture:Prefecture?
    @Published private(set) var error:AFError? = nil
    
    public func fetchLuckyPrefecture(input:FortuneInput) {
        let api = FortuneAPI()
        
        /// If you set JSONDecoder.keyDecodingStrategy's value into .convertFromSnakeCase, it will automatically change snake_case into camelCase, and vice versa.
        /// Thus no need for CordingKeys.       cf. https://zenn.dev/u_dai/articles/af5e2bf083b0dc
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(api.url, method: .post, parameters: input, encoder: .json(encoder: encoder), headers: api.headers)
            .responseDecodable(of: LuckyPrefecture.self, decoder: decoder){ response in
                switch response.result {
                case .success:
                    if let luckyPrefecture = response.value {
                        self.setPrefecture(luckyPrefecture: luckyPrefecture)
                        print("luckyPrefecture:\(luckyPrefecture)")
                    } else {
                        print("luckyPrefecture is nil")
                    }
                case .failure(let error):
                    self.error = error
                    print("failed to fetch luckyPrefecture")
                }
            }
    }
    
    private func setPrefecture(luckyPrefecture:LuckyPrefecture){
        let location: PinLocation = PrefectureLocations.location(of: luckyPrefecture.name)
        let images: [PrefectureImageInfo] = PrefectureImageInfoSets.infoSets(of: luckyPrefecture.name)
        
        self.prefecture = Prefecture(name: luckyPrefecture.name,
                                     brief: luckyPrefecture.brief,
                                     capital: luckyPrefecture.capital,
                                     citizenDay: luckyPrefecture.citizenDay,
                                     hasCoastLine: luckyPrefecture.hasCoastLine,
                                     logoUrl: luckyPrefecture.logoUrl,
                                     location: location,
                                     images: images)
    }
}

struct LuckyPrefecture:Decodable{
    public let name:String
    public let brief:String
    public let capital:String
    public let citizenDay:MonthDay?
    public let hasCoastLine:Bool
    public let logoUrl:URL
}

struct MonthDay:Codable{
    let month:Int
    let day:Int
}

extension MonthDay{
    public func toString()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "dMMM", options: 0, locale: Locale(identifier: "ja_JP"))
        return formatter.string(from: self.toDate())
    }
    
    public func toDate()->Date{
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(month: self.month, day: self.day)
        guard let date = calendar.date(from: dateComponents ) else{ fatalError("invalid date") }
        return date
    }
}
