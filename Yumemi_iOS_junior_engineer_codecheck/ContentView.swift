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
    
    init() {
         UIScrollView.appearance().bounces = false
      }

    @State private var output: Result<LuckyPrefecture, AFError>? = nil
    @State private var luckyPrefecture:LuckyPrefecture? = nil
    
    private var luckyPrefectureImageInfoSets:[PrefectureImageInfo]?{
        guard let prefecture = luckyPrefecture else{ return nil }
        let prefCode = prefectureCode(from: prefecture.name)
        guard let prefCode = prefCode else{
            print("prefCode nil. prefecture: \(prefecture)")
            return nil }
       return  PrefectureImageInfoSets().infoSets(of: prefCode)
    }
    
    @State private var errorInFetchingFortune:AFError? = nil
    @State private var displayedPage = Pages.input
    
    var body: some View {
        
        ZStack{
            BackgroundView()
            
            // this GeometryReader helps InputView to move input forms upwards when keyboard is displayed.
            GeometryReader{ geo in
                
                // this ScrollView wraps VTabView so that VTabView can fill the screen to the full. cf.https://stackoverflow.com/questions/62593923/edgesignoringsafearea-on-tabview-with-pagetabviewstyle-not-working
                ScrollView (.horizontal,showsIndicators: false){
                    VTabView(selection: $displayedPage){
                        InputView(output: $output, geometry:geo).tag(Pages.input)
                        
                        if let luckyPrefecture = self.luckyPrefecture{
                            PrefectureView(prefacture: luckyPrefecture, imagesInfo:luckyPrefectureImageInfoSets!).tag(Pages.output)
                        }
                        if let errorInFetchingFortune = self.errorInFetchingFortune{
                            ErrorView(error:errorInFetchingFortune).tag(Pages.output)
                        }
//                        MapView().tag(Pages.map)
                        HistoryView().tag(Pages.history)
                    }.frame(
                        width: UIScreen.main.bounds.width ,
                        height: UIScreen.main.bounds.height
                    )
                    .tabViewStyle(.page(indexDisplayMode: .never))
                } .ignoresSafeArea(.all)
            }
        }
        .onChange(of: output) { newValue in
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
        }
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
        case input, output, history
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
