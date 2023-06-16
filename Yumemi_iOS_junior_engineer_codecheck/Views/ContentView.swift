//
//  ContentView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import Alamofire
import Combine
import CoreData
import SwiftUI

struct ContentView<PrefectureModel: PrefectureModelProtocol>: View {
    @ObservedObject var prefectureModel: PrefectureModel
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: History.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \History.fetchedAt, ascending: false)],
        animation: .default)
    private var histories: FetchedResults<History>

    @State private var displayOutputViewFlag = false
    @State private var displayedPage = Pages.input
    
    //Below: History/LicenseView are unlocked after the user inputs info and fetched data.
    private var isHistoryViewEnabled: Bool { histories.count > 0 }
    private var isLicenseViewEnabled: Bool { histories.count > 0 }

    var body: some View {
        //MaximumVerticalPageView fills the screen, ignoring the safe area.
        MaximumVerticalPageView(selection: $displayedPage) {
            InputView(
                viewModel: InputViewModel(prefectureModel: prefectureModel),
                shouldShowOutput: $displayOutputViewFlag
            )
            .tag(Pages.input)

            Group {
                if let prefecture = self.prefectureModel.prefecture {
                    PrefectureView(prefecture: prefecture)
                } else if let error = self.prefectureModel.error {
                    ErrorView(error: error)
                }
            }.tag(Pages.output)

            if isHistoryViewEnabled {
                HistoryView(
                    size: Screen.size, shouldShowOutput: $displayOutputViewFlag,
                    prefectureModel: prefectureModel
                )
                .tag(Pages.history)
            }
            if isLicenseViewEnabled {
                LicenseView(size: Screen.size)
                    .tag(Pages.license)
            }

        }
        .background(BackgroundView())
        .onReceive(Just(displayOutputViewFlag)) { shouldShow in
            if shouldShow {
                Task(priority: .background) {
                    try await Task.sleep(nanoseconds: UInt64(0.3 * 1_000_000_000))
                    Task { @MainActor in
                        withAnimation { displayedPage = .output }
                    }
                }
            }
        }
        //Below shortcut for Mac and iPad
        .background(
            HStack {
                Button {
                    withAnimation {
                        displayedPage = displayedPage.previous()
                    }
                } label: {
                    Text("Up")
                }
                .keyboardShortcut(.upArrow, modifiers: [])
                Button {
                    withAnimation {
                        displayedPage = displayedPage.next()
                    }
                } label: {
                    Text("Down")
                }
                .keyboardShortcut(.downArrow, modifiers: [])
            }
        )

    }

    private enum Pages: CaseIterable {
        case input, output, history, license
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // from iPhone SE 3ed gen to 14 pro
        ForEach(PreviewData.iPhone) { device in
            ContentView<PrefectureModel>(prefectureModel: PrefectureModel())
                .border(.red)
                .onAppear(perform: {
                    print("App: screenSize: \(Screen.size)")
                })
                .previewDevice(PreviewDevice(rawValue: device.name))
                .previewDisplayName(device.previewTitle)
        }

    }
}
