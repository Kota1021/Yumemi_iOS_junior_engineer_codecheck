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
    
    @State private var output: Result<Prefecture, AFError>? = nil
    @State private var fetchPrefectureButtonTapped = false
    @State private var displayedPage = Pages.input
    
    var body: some View {
        
        /// this GeometryReader helps InputView to move input forms upwards when keyboard is displayed.
        /// InputView is inside MaximumVerticalPageView, which ignores safe area.
        GeometryReader{ geo in
            MaximumVerticalPageView(selection: $displayedPage){
                    InputView(output: $output,
                              fetchButtonTapped: $fetchPrefectureButtonTapped,
                              geometry:geo)
                    .tag(Pages.input)
                    OutputView(output: $output)
                    .tag(Pages.output)
                    HistoryView()
                    .tag(Pages.history)
            }
        }.background( BackgroundView() )
            .onChange(of: fetchPrefectureButtonTapped) { tapped in
                print("button tapped observed in ContentView")
                if tapped{
                    print("fetchPrefectureButtonTapped true")
                    Task{
                        try? await Task.sleep(nanoseconds:0_300_000_000)
                        withAnimation{
                            displayedPage = .output
                        }
                    }
                }
                fetchPrefectureButtonTapped = false
            }
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
