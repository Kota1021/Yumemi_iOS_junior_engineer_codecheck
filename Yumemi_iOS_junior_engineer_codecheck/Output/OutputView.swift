//
//  OutputView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI
import Alamofire
struct OutputView: View {
    
    @Binding var output: Result<Prefecture, AFError>?
    @State private var luckyPrefecture:Prefecture? = nil
    @State private var errorInFetchingFortune:Error? = nil
    
    private var luckyPrefectureImageInfoSets:[PrefectureImageInfo]?{
        guard let prefecture = luckyPrefecture else{ return nil }
        let prefCode = prefectureCode(from: prefecture.name)
        guard let prefCode = prefCode else{
            print("prefCode nil. prefecture: \(prefecture)")
            return nil }
       return  PrefectureImageInfoSets().infoSets(of: prefCode)
    }
    
    
    var body: some View {
        Group{
            if output == nil {
//                PrefectureView()//placeholder
                EmptyView()
            }else if let prefecture = self.luckyPrefecture{
                PrefectureView(prefacture: prefecture, imagesInfo:luckyPrefectureImageInfoSets!)
                
            }else if let errorInFetchingFortune = self.errorInFetchingFortune{
                ErrorView(error:errorInFetchingFortune)
                
            }
        }.onChange(of: output) { newValue in
                    do{
                        errorInFetchingFortune = nil
                        luckyPrefecture = try output?.get()
                    }catch{
                        luckyPrefecture = nil
                        errorInFetchingFortune = error
                    }
                }
    }
}

struct OutputView_Previews: PreviewProvider {
    @State static private var output: Result<Prefecture, AFError>? = nil
    static var previews: some View {
        OutputView(output: $output)
    }
}
