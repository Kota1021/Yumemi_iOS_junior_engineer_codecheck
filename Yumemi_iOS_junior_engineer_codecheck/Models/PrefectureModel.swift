//
//  PrefectureModel.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//


import Foundation
import Alamofire

class PrefectureModel: ObservableObject {
    
    @Published public var prefecture:Prefecture?
    @Published var error:Error? = nil
    
    
    public func fetchLuckyPrefecture(input:FortuneInput) {
        print("fetchAPI called")
        let api = FortuneAPI()
        
        /// If you set JSONDecoder.keyDecodingStrategy's value into .convertFromSnakeCase, it will automatically change snake_case into camelCase, and vice versa.
        /// Thus no need for CordingKeys.       cf. https://zenn.dev/u_dai/articles/af5e2bf083b0dc
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        print("ganna make a request")
        AF.request(api.url, method: .post, parameters: input, encoder: .json(encoder: encoder), headers: api.headers)
            .responseDecodable(of: LuckyPrefecture.self, decoder: decoder){response in
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
        
        print("went over AF")
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


struct Prefecture{
    let name:String
    let brief:String
    let capital:String
    let citizenDay:MonthDay?
    let hasCoastLine:Bool
    let logoUrl:URL
    
    let location:PinLocation
    let images:[PrefectureImageInfo]
}
