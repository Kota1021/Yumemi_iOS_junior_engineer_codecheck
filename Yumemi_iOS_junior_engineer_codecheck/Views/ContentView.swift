//
//  ContentView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//


import SwiftUI
import CoreData
import Alamofire
import Combine

struct ContentView<PrefectureModel:PrefectureModelProtocol>:View{
    @EnvironmentObject var screen:ScreenSize
    @ObservedObject var prefectureModel: PrefectureModel
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: History.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \History.fetchedAt, ascending: false)],
                  animation: .default)
    private var histories: FetchedResults<History>
    
    @State private var displayOutputViewFlag = false
    @State private var displayedPage = Pages.input
    //Below if launched for the first time, it would lock the view, only showing the InputView.
    private var isHistoryViewEnabled:Bool{ histories.count > 0}
    private var isLicenseViewEnabled:Bool{ histories.count > 0}
    
    var body: some View {
        //MaximumVerticalPageView fills the screen, ignoring the safe area.
        MaximumVerticalPageView(selection: $displayedPage){
            
            InputView(viewModel: InputViewModel(prefectureModel: prefectureModel),
                      shouldShowOutput: $displayOutputViewFlag)
                .tag(Pages.input)
            
            Group{
                if let prefecture = self.prefectureModel.prefecture{
                    PrefectureView(prefecture: prefecture)
                }else if let error = self.prefectureModel.error{
                    ErrorView(error: error)
                }
            }.tag(Pages.output)
            
            if isHistoryViewEnabled{
                HistoryView(size:screen.size,shouldShowOutput: $displayOutputViewFlag, prefectureModel: prefectureModel)
                    .tag(Pages.history)
            }
            if isLicenseViewEnabled{
                LicenseView(size:screen.size)
                    .tag(Pages.license)
            }
            
        }
        .background(BackgroundView() )
        .onReceive(Just(displayOutputViewFlag)) { shouldShow in
//            print("ContentView: displayOutputViewFlag sent \(shouldShow)")
            if shouldShow{
                Task(priority: .background) {
                    try await Task.sleep(nanoseconds: UInt64(0.3 * 1_000_000_000) )
                    Task{ @MainActor in
                        withAnimation{ displayedPage = .output }
                    }
                }
            }
        }
    }
    
    private enum Pages{
        case input, output, history, license
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // from iPhone SE 3ed gen to 14 pro
        ForEach(PreviewData.devices) { device in
            ContentView<PrefectureModel>(prefectureModel: PrefectureModel())
                .environmentObject(ScreenSize(size: PreviewData.screenSize))
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                .previewDevice(PreviewDevice(rawValue: device.name))
                .previewDisplayName(device.previewTitle)
        }
        
    }
}
