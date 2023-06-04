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
    //    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var prefectureModel: PrefectureModel
    @EnvironmentObject var screen:ScreenSize
    @State private var displayOutputView = false
    @State private var displayedPage = Pages.input
    
    var body: some View {
        //MaximumVerticalPageView fills the screen, ignoring the safe area.
        MaximumVerticalPageView(selection: $displayedPage){
            InputView(viewModel:InputViewModel(prefectureModel: prefectureModel), shouldShowOutput: $displayOutputView)
                .tag(Pages.input)
            
            Group{
                if let prefecture = self.prefectureModel.prefecture{
                    PrefectureView(prefacture: prefecture)
                }else if let error = self.prefectureModel.error{
                    ErrorView(error: error)
                }
                
            }.tag(Pages.output)
            
            HistoryView(size:screen.size,shouldShowOutput: $displayOutputView)
                .tag(Pages.history)
            
            LicenseView(size:screen.size)
                .tag(Pages.license)
            
        }
        .background(BackgroundView() )
        .onReceive(Just(displayOutputView)) { shouldShow in
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
        ForEach(PreviewData.devices) { device in
            ContentView<PrefectureModel>(prefectureModel: PrefectureModel())
                .environmentObject(ScreenSize(size: PreviewData.screenSize))
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                .previewDevice(PreviewDevice(rawValue: device.name))
                .previewDisplayName(device.previewTitle)
        }
        
    }
}
