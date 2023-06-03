//
//  ContentView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import Combine
import SwiftUI
import CoreData
import Alamofire

struct ContentView<PrefectureModel:PrefectureModelProtocol,InputVM:InputViewModelProtocol>: View {
    //    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var prefectureModel:PrefectureModel
    let inputViewModel:InputViewModel<PrefectureModel>
    @State private var displayedPage = Pages.input
    
    init(prefectureModel: PrefectureModel) {
        self.prefectureModel = prefectureModel
        self.inputViewModel =  InputViewModel(prefectureModel:prefectureModel)
    }
    
    var body: some View {
            MaximumVerticalPageView(selection: $displayedPage){
//                InputView(viewModel: InputViewLogic(prefectureModel:prefectureModel) )
                InputView(viewModel: inputViewModel)
                
                if let prefecture = self.prefectureModel.prefecture{
                    PrefectureView(prefacture: prefecture)
                        .tag(Pages.output)
                }else if let error = self.prefectureModel.error{
                    ErrorView(error: error)
                }
                
                HistoryView()
                    .tag(Pages.history)
                
                ///MaximumVerticalPageView ignores safe area.
                /// To tell the safe area to views inside MaximumVerticalPageView, you need to set an environmentObject.
            }.environmentObject(SafeArea() )
        .background(BackgroundView() )
//        .onReceive($prefectureModel.prefecture) { _ in
//            withAnimation{ displayedPage = .output }
//        }
    }
    
    private enum Pages{
        case input, output, history
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(prefectureModel: PrefectureModel())
            .environmentObject(SafeArea())
        //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
