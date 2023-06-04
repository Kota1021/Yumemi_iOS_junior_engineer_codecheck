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
    var prefecture:Prefecture? { get set }
    var error:AFError? { get }
    func fetchLuckyPrefecture(input:UserInput,onReceive action: @escaping ()->Void)
}

//PrefectureModel does not know view
class PrefectureModel: ObservableObject, PrefectureModelProtocol{
    
    @Published public var prefecture:Prefecture?
    @Published private(set) var error:AFError? = nil
    
    public func fetchLuckyPrefecture(input:UserInput,onReceive action: @escaping ()->Void) {
        print("PrefectureModel: fetchLuckyPrefecture called")
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
                        print("PrefectureModel: fetched:\n\(luckyPrefecture)\n")
                        self.storeLuckyPrefectureCoreData(luckyPrefecture: luckyPrefecture)
                        print("PrefectureModel: and stored it in CoreData.\n\n")
                    } else {
                        print("PrefectureModel: luckyPrefecture is nil")
                    }
                case .failure(let error):
                    self.error = error
                    print("PrefectureModel: failed to fetch luckyPrefecture")
                }
                action()
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
    
    
    
    private let viewContext = PersistenceController.shared.container.viewContext
    private func storeLuckyPrefectureCoreData(luckyPrefecture:LuckyPrefecture){
        //この辺に保存の処理
        
        let newLuckPrefecture = SavedLuckyPrefecture(context: viewContext)
        newLuckPrefecture.name = luckyPrefecture.name
        newLuckPrefecture.brief = luckyPrefecture.brief
        newLuckPrefecture.capital = luckyPrefecture.capital
        newLuckPrefecture.citizenDay = luckyPrefecture.citizenDay?.toDate()
        newLuckPrefecture.hasCoastLine = luckyPrefecture.hasCoastLine
        newLuckPrefecture.logoURL = luckyPrefecture.logoUrl
        
        print("InputViewModel: saving userInfo into Core Data")
        try? viewContext.save()
    }
    
}

