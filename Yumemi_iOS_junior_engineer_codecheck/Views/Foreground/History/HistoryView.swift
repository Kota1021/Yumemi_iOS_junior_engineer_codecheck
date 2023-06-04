//
//  HistoryView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct HistoryView: View {
    @State private var blurStrength:Double = 0
    
    let viewSize:CGSize
    init(size: CGSize) {
        self.viewSize = size
    }
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(1..<10) { _ in
                    HistoryCardView()
                }
            }
        }.frame(width: viewSize.width, height: viewSize.height)
            .background(
                Color.clear
                    .background(.ultraThinMaterial)
                    .opacity(blurStrength)
            )
            .onAppear {
                Task(priority: .background){
                    try await Task.sleep(nanoseconds: UInt64(0.5 * 1_000_000_000) )
                        Task{ @MainActor in
                        withAnimation {
                            blurStrength = 1
                        }
                    }
                }
            }
//            .onDisappear {
//                Task(priority: .background){
//                    try await Task.sleep(nanoseconds: UInt64(0.5 * 1_000_000_000) )
//                        Task{ @MainActor in
//                        withAnimation {
//                            blurStrength = 0
//                        }
//                    }
//                }
//            }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(size: PreviewData.screenSize)
    }
}
