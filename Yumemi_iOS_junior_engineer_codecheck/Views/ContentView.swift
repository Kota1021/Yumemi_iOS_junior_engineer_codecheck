//
//  ContentView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI
import CoreData
import Alamofire

struct ContentView: View {
    //    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var fetchPrefectureButtonTapped = false
    @State private var displayedPage = Pages.input
    @ObservedObject var prefectureModel = PrefectureModel()
    
    var body: some View {
        /// this GeometryReader tells InputViewModel the safe area.
        /// InputView is inside MaximumVerticalPageView, which ignores safe area.
//        GeometryReader{ geo in
            MaximumVerticalPageView(selection: $displayedPage){
                InputView(viewModel: InputViewLogic(prefectureModel:prefectureModel/*, geometry: geo*/) )
                
                if let prefecture = self.prefectureModel.prefecture{
                    PrefectureView(prefacture: prefecture)
                        .tag(Pages.output)
                }else if let error = self.prefectureModel.error{
                    ErrorView(error: error)
                }
                
                HistoryView()
                    .tag(Pages.history)
                
            }.environmentObject(MaximumVerticalPageViewLogic())
//        }
        .background(BackgroundView() )
    }
    
    private enum Pages{
        case input, output, history
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
