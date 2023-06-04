//
//  HistoryView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct HistoryView<PrefectureModel>: View where PrefectureModel: PrefectureModelProtocol{
    
    @Binding var shouldShowOutput: Bool
//    @State private var blurStrength:Double = 0
    
    let viewSize:CGSize
    @ObservedObject var prefectureModel:PrefectureModel
    
    init(size: CGSize,shouldShowOutput:Binding<Bool>, prefectureModel:PrefectureModel) {
        self.prefectureModel = prefectureModel
        self.viewSize = size
        self._shouldShowOutput = shouldShowOutput
    }
    
    func cardTapped(prefecture:String){
        
    }
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(1..<10) { _ in
                    Button{
                        cardTapped(prefecture:"")
                    }label:{
                        HistoryCardView()
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
