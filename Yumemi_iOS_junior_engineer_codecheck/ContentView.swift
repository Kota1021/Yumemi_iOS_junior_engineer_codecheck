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

    @State private var output: Result<LuckyPrefacture, AFError>? = nil
    @State private var luckyPrefecture:LuckyPrefacture? = nil
    @State private var errorInFetchingFortune:AFError? = nil
    
    var body: some View {
        VStack{
            InputView(output: $output)
            
            if let luckyPrefecture = self.luckyPrefecture{
                OutputView(prefacture: luckyPrefecture)
            }
            if let errorInFetchingFortune = self.errorInFetchingFortune{
                ErrorView(error:errorInFetchingFortune)
            }
            
        }.onChange(of: output) { newValue in
            do{
                errorInFetchingFortune = nil
                luckyPrefecture = try output?.get()
            }catch{
                luckyPrefecture = nil
                errorInFetchingFortune = error as? AFError
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

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
