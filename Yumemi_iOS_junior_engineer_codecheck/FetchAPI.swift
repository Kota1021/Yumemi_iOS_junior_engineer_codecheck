//
//  FetchAPI.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import Foundation
import Alamofire

func fetchAPI(input:FortuneInput){
    print("fetchAPI called")
    let api = FortuneAPI()
//
//    let input = FortuneInput(name: "John Doe", birthday: birthday, bloodType: .a, today: today)
    
    /// If you set JSONDecoder.keyDecodingStrategy's value into .convertFromSnakeCase, it will automatically change snake_case into camelCase, and vice versa.
    /// Thus no need for CordingKeys.       cf. https://zenn.dev/u_dai/articles/af5e2bf083b0dc
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    AF.request(api.url, method: .post, parameters: input, encoder: .json(encoder: encoder), headers: api.headers)
        .responseDecodable(of: FortuneOutput.self,decoder: decoder){ response in
            print("api requested")
            
            switch response.result {
            case .success:
                if let result = response.value {
                    print("fortune output not nil")
                    let output:FortuneOutput = result
                    print(output)
                    
                } else {
                    print("fortune output nil")
                }
            case .failure(let error):
                print(error)
            }
            
        }
}
