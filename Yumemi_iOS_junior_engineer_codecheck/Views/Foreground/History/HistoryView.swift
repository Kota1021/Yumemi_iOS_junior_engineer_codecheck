//
//  HistoryView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct HistoryView<PrefectureModel>: View where PrefectureModel: PrefectureModelProtocol{
    @FetchRequest(entity: History.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \History.fetchedAt, ascending: false)],
                  animation: .default)
    private var histories: FetchedResults<History>
    
    @ObservedObject var prefectureModel:PrefectureModel
    @Binding var shouldShowPrefecture: Bool
    let viewSize:CGSize
    
    init(size: CGSize,shouldShowOutput:Binding<Bool>, prefectureModel:PrefectureModel) {
        self.prefectureModel = prefectureModel
        self.viewSize = size
        self._shouldShowPrefecture = shouldShowOutput
    }
    
    
    var body: some View {
        ScrollView(.horizontal){
        LazyHStack{
                ForEach(histories){ history in
                    Button{
                        prefectureModel.setPrefecture(name: history.prefecture)
                        shouldShowPrefecture = true

                    }label:{
                        HistoryCardView(thumbnailURL: ImageInfoSets.thumbnailURL(of: history.prefecture)
                                        ,
                                        prefecture: history.prefecture,
                                        name: history.name,
                                        birthday: history.stringBirthday,
                                        bloodType: history.stringBloodType,
                                        fetchDate: history.stringFetchDate)
                        
                    }.buttonStyle(.plain)
                }
            }
        }
            .frame(width: viewSize.width, height: viewSize.height)
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


