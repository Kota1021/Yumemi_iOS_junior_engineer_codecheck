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
    @State private var displayOutputView = false
    @State private var displayedPage = Pages.input
    
    var body: some View {
        MaximumVerticalPageView(selection: $displayedPage){
            InputView(viewModel:InputViewModel(prefectureModel: prefectureModel), shouldShowOutput: $displayOutputView)
                .tag(Pages.input)
            
            Group{
                if let prefecture = self.prefectureModel.prefecture{
                    PrefectureView(prefacture: prefecture)
                }else if let error = self.prefectureModel.error{
                    ErrorView(error: error)
                }}.tag(Pages.output)
            
            HistoryView()
                .tag(Pages.history)
            
            ///This SafeArea() environmentObject is to tell the safe area to views inside MaximumVerticalPageView, which  ignores safe area.
        }.environmentObject(SafeArea() )
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
        case input, output, history
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(PreviewData.devices) { device in
            ContentView<PrefectureModel>(prefectureModel: PrefectureModel())
                .environmentObject(SafeArea())
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                .previewDevice(PreviewDevice(rawValue: device.name))
                .previewDisplayName(device.previewTitle)
        }
        
    }
}
