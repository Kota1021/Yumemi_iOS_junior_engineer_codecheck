//
//  HistoryView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct HistoryView<PrefectureModel>: View where PrefectureModel: PrefectureModelProtocol{
    @FetchRequest(entity: StoredUserInput.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \StoredUserInput.fetchedAt, ascending: true)],animation: .default)
    private var userInputs: FetchedResults<StoredUserInput>
    
    @FetchRequest(entity: SavedLuckyPrefecture.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \SavedLuckyPrefecture.name, ascending: true)],animation: .default)
    private var luckyPrefectures: FetchedResults<SavedLuckyPrefecture>
    
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
            VStack{
                HStack{
                    ForEach(0..<userInputs.count) { index in
                        Text(userInputs[index].name)
                    }
                }
                HStack{
                    ForEach(0..<luckyPrefectures.count) { index in
                        Text(luckyPrefectures[index].name)
                    }
                }
            }
//            HStack{
//                ForEach(0..<historiesTest.count) { index in
//                    Button{
//                        let prefecture =  historiesTest[index].prefecture
//                        prefectureModel.prefecture = prefecture
//                        shouldShowOutput = true
//
//                    }label:{
//                        HistoryCardView(history:historiesTest[index])
//                    }.buttonStyle(.plain)
//                }
//            }
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
