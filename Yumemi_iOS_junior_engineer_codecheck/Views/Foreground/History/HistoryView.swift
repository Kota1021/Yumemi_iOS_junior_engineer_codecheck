//
//  HistoryView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct HistoryView<PrefectureModel>: View where PrefectureModel: PrefectureModelProtocol{
    @FetchRequest(entity: StoredHistory.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \StoredHistory.fetchedAt, ascending: false)],
                  animation: .default)
    private var fetchedHistories: FetchedResults<StoredHistory>
    
//    private var histories:[History]{ fetchedHistories.map{ HistoryFrom(history: $0) } }
    
    @ObservedObject var prefectureModel:PrefectureModel
    @Binding var shouldShowOutput: Bool
    let viewSize:CGSize
    
    init(size: CGSize,shouldShowOutput:Binding<Bool>, prefectureModel:PrefectureModel) {
        self.prefectureModel = prefectureModel
        self.viewSize = size
        self._shouldShowOutput = shouldShowOutput
    }
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                
                ForEach(0..<fetchedHistories.count) { index in
                    Button{
//                        let prefecture =  prefectureModel.setPrefecture(name: history.prefecture)
//                        prefectureModel.prefecture = prefecture
//                        shouldShowOutput = true

                    }label:{
                        HistoryCardView(history:fetchedHistories[index], thumbnailURL: PrefectureImageInfoSets.thumbnailURL(of: fetchedHistories[index].prefecture))
                    }.buttonStyle(.plain)
                }
//                ForEach(histories) { history in
//                    Button{
////                        let prefecture =  prefectureModel.setPrefecture(name: history.prefecture)
////                        prefectureModel.prefecture = prefecture
////                        shouldShowOutput = true
//
//                    }label:{
//                        HistoryCardView(history:history, thumbnailURL: PrefectureImageInfoSets.thumbnailURL(of: history.prefecture))
//                    }.buttonStyle(.plain)
//                }
            }
        }.frame(width: viewSize.width, height: viewSize.height)
            .background(
                Color.clear
                    .background(.ultraThinMaterial)
                    .opacity(1)
            )
    }
}

struct HistoryView_Previews: PreviewProvider {
    @State static var shouldShowOutput = false
    static var previews: some View {
        HistoryView(size: PreviewData.screenSize, shouldShowOutput: $shouldShowOutput, prefectureModel: PrefectureModel())
    }
}


