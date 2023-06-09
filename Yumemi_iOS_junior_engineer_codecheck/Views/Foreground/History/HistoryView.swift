//
//  HistoryView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct HistoryView<PrefectureModel>: View where PrefectureModel: PrefectureModelProtocol {
    @FetchRequest(
        entity: History.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \History.fetchedAt, ascending: false)],
        animation: .default)
    private var histories: FetchedResults<History>

    @ObservedObject var prefectureModel: PrefectureModel
    @Binding var shouldShowPrefecture: Bool
    let viewSize: CGSize

    @State private var xOffset = CGFloat.zero
    let cardWidth: CGFloat = 200
    let spacing: CGFloat = 10
    var leadingItemIndex: Int { Int(xOffset / (cardWidth + spacing*2)) }
    var lastCardIndex: Int { histories.count - 1 }

    init(size: CGSize, shouldShowOutput: Binding<Bool>, prefectureModel: PrefectureModel) {
        self.prefectureModel = prefectureModel
        self.viewSize = size
        self._shouldShowPrefecture = shouldShowOutput
    }

    var body: some View {
        ScrollViewReader { reader in
            ScrollView(.horizontal) {
                LazyHStack {
                    //enumerated for pageIndex for ScrollViewReader for Mac and ipad keyboard shortcut.
                    ForEach(Array(histories.enumerated()), id: \.offset) { (cardIndex, history) in
                        Button {
                            prefectureModel.setPrefecture(name: history.prefecture)
                            shouldShowPrefecture = true

                        } label: {
                            HistoryCardView(
                                thumbnailURL: ImageInfoSets.randomThumbnailURL(of: history.prefecture),
                                prefecture: history.prefecture,
                                name: history.name,
                                birthday: history.stringBirthday,
                                bloodType: history.stringBloodType,
                                fetchDate: history.stringFetchDate)

                        }.buttonStyle(.plain)
                            .padding(spacing)
                            .tag(cardIndex)

                    }
                }  //https://zenn.dev/chiii/articles/8da217f39478cb
                .background(
                    GeometryReader { proxy -> Color in
                        Task { xOffset = -proxy.frame(in: .named("scroll")).origin.x }
                        return Color.clear
                    })

            }.coordinateSpace(name: "scroll")
                .frame(width: viewSize.width, height: viewSize.height)
                .background(
                    Color.clear
                        .background(.ultraThinMaterial)
                        .opacity(1)
                )

                // below buttons accept keyboard inputs to scroll
                .background(
                    HStack {
                        Button {
                            let previousItemIndex = leadingItemIndex - 2
                            if previousItemIndex >= 0 {
                                print(
                                    "current:\(leadingItemIndex)\nscrolling to: \(previousItemIndex)"
                                )
                                withAnimation {
                                    reader.scrollTo(previousItemIndex, anchor: .leading)
                                }
                            }
                        } label: {
                            Image(systemName: "chevron.left.square.fill")

                        }.keyboardShortcut(.leftArrow, modifiers: [])

                        Button {
                            let nextItemIndex = leadingItemIndex + 2
                            if nextItemIndex <= lastCardIndex {
                                print("current:\(leadingItemIndex)\nscrolling to: \(nextItemIndex)")
                                withAnimation {
                                    reader.scrollTo(nextItemIndex, anchor: .leading)
                                }
                            }
                        } label: {
                            Image(systemName: "chevron.right.square.fill")

                        }.keyboardShortcut(.rightArrow, modifiers: [])
                    }.foregroundColor(Color(.systemBackground))
                )
        }

    }
}

struct HistoryView_Previews: PreviewProvider {
    @State static private var shouldShowOutput = false

    static var previews: some View {
        HistoryView(
            size: PreviewData.screenSize, shouldShowOutput: $shouldShowOutput,
            prefectureModel: PrefectureModel())
    }
}
