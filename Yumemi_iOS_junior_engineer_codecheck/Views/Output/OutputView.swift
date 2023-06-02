//
//  OutputView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI
import Alamofire
struct OutputView: View {
    @ObservedObject var prefectureModel:PrefectureModel
    
    var body: some View {
            if let prefecture = self.prefectureModel.prefecture{
                PrefectureView(prefacture: prefecture)
                
            }else if let errorInFetchingFortune = self.prefectureModel.error{
                ErrorView(error:errorInFetchingFortune)
                
            }
    }
}

struct OutputView_Previews: PreviewProvider {
    static var previews: some View {
        OutputView(prefectureModel: PrefectureModel())
    }
}
