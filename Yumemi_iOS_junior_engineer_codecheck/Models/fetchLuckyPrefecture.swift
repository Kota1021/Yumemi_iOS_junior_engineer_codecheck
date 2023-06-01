//
//  FetchAPI.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import Foundation
import Alamofire

func fetchLuckyPrefecture(input:FortuneInput) async -> Result<Prefecture, AFError> {
    print("fetchAPI called")
    let api = FortuneAPI()
    
    /// If you set JSONDecoder.keyDecodingStrategy's value into .convertFromSnakeCase, it will automatically change snake_case into camelCase, and vice versa.
    /// Thus no need for CordingKeys.       cf. https://zenn.dev/u_dai/articles/af5e2bf083b0dc
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    let result = await AF.request(api.url, method: .post, parameters: input, encoder: .json(encoder: encoder), headers: api.headers).serializingDecodable(Prefecture.self, decoder: decoder).result
    
    return result
}
