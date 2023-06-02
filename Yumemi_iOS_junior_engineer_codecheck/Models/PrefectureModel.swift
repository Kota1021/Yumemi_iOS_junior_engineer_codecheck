//
//  PrefectureModel.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//


import Foundation
import Alamofire

class PrefectureModel: ObservableObject {
    
    public var prefecture:Prefecture?{
        guard let luckyPrefecture = luckyPrefecture else { return nil }

        let location: PinLocation = PrefectureLocations.location(of: luckyPrefecture.name)
        let images: [PrefectureImageInfo] = PrefectureImageInfoSets.infoSets(of: luckyPrefecture.name)
        
        return .init(name: luckyPrefecture.name,
                     brief: luckyPrefecture.brief,
                     capital: luckyPrefecture.capital,
                     citizenDay: luckyPrefecture.citizenDay,
                     hasCoastLine: luckyPrefecture.hasCoastLine,
                     logoUrl: luckyPrefecture.logoUrl,
                     location: location,
                     images: images)
    }
    
    @Published var luckyPrefecture:LuckyPrefecture? = nil
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
        
        Task{
            let result = await AF.request(api.url, method: .post, parameters: input, encoder: .json(encoder: encoder), headers: api.headers).serializingDecodable(LuckyPrefecture.self, decoder: decoder).result
            
            do{
                self.luckyPrefecture = try result.get()
            }catch{
                self.error = error
            }
            
        }
        
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
