//
//  ContentView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI
import CoreData
import Alamofire
import VTabView

struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext

    @State private var output: Result<LuckyPrefacture, AFError>? = nil
    @State private var luckyPrefecture:LuckyPrefacture? = nil
    @State private var errorInFetchingFortune:AFError? = nil
    @State private var displayedPage = Pages.input
    
    var body: some View {
        VStack{
            VTabView(selection: $displayedPage,indexPosition: .trailing){
                ViewForResearch(output: $output).tag(Pages.input)
                if let luckyPrefecture = self.luckyPrefecture{
                    OutputView(prefacture: luckyPrefecture).tag(Pages.output)
                }
                if let errorInFetchingFortune = self.errorInFetchingFortune{
                    ErrorView(error:errorInFetchingFortune).tag(Pages.output)
                }
            }.tabViewStyle(.page(indexDisplayMode: .always))
                
                
//            InputView(output: $output)

            

        }.onChange(of: output) { newValue in
            do{
                errorInFetchingFortune = nil
                luckyPrefecture = try output?.get()
            }catch{
                luckyPrefecture = nil
                errorInFetchingFortune = error as? AFError
            }
            Task{
                Thread.sleep(forTimeInterval: 0.5)
                withAnimation{
                    displayedPage = .output
                }
            }
//            isOutputSheetDisplayed = true
        }
//        .sheet(isPresented: $isOutputSheetDisplayed) {
//            if let luckyPrefecture = self.luckyPrefecture{
//                OutputView(prefacture: luckyPrefecture)
//            }
//            if let errorInFetchingFortune = self.errorInFetchingFortune{
//                ErrorView(error:errorInFetchingFortune)
//            }
//        }
//        .onAppear{
//            errorFetcher()
//        }
    }
    
//    func errorFetcher(){
//        // generates an intended error for testing ErrorView
//        let name = "AAA"
//        let birthday = YearMonthDay(year: 111, month: 111, day: 111)
//        let bloodType = ABOBloodType.a
//        print("bloodtype: \(bloodType)")
//        let today = YearMonthDay(from: Date() )
//
//        let input = FortuneInput(name: name, birthday: birthday, bloodType: bloodType, today: today)
//
//        Task{
//            output = await fetchLuckyPrefecture(input: input)
//        }
//    }
    
    private enum Pages{
        case input, output, map, history
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
