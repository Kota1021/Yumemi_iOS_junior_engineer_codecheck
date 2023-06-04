//
//  HistoryView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct HistoryView<PrefectureModel>: View where PrefectureModel: PrefectureModelProtocol{
    
    
    @ObservedObject var prefectureModel:PrefectureModel
    @Binding var shouldShowOutput: Bool
    let viewSize:CGSize
    
    @State private var selectedPrefecture: Prefecture? = nil
    
    let histories:[History] = [PreviewData.history,PreviewData.history,PreviewData.history] //ここあとでcoredata で、検索者の情報なども伴って。
    
    init(size: CGSize,shouldShowOutput:Binding<Bool>, prefectureModel:PrefectureModel) {
        self.prefectureModel = prefectureModel
        self.viewSize = size
        self._shouldShowOutput = shouldShowOutput
    }
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(0..<histories.count) { index in
                    Button{
                        self.selectedPrefecture =  histories[index].prefecture
                    }label:{
                        HistoryCardView(history:histories[index])
                    }.buttonStyle(.plain)
                }
            }
        }.frame(width: viewSize.width, height: viewSize.height)
            .background(
                Color.clear
                    .background(.ultraThinMaterial)
                    .opacity(1)
//                    .opacity(blurStrength)
            )
//            .onAppear {
//                
//                Task(priority: .background){
//                    try await Task.sleep(nanoseconds: UInt64(0.5 * 1_000_000_000) )
//                        Task{ @MainActor in
//                        withAnimation {
//                            blurStrength = 1
//                        }
//                    }
//                }
//            }
    }
}

struct HistoryView_Previews: PreviewProvider {
    @State static var shouldShowOutput = false
    static var previews: some View {
        HistoryView(size: PreviewData.screenSize, shouldShowOutput: $shouldShowOutput, prefectureModel: PrefectureModel())
    }
}
