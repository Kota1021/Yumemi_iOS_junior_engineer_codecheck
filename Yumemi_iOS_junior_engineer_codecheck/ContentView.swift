//
//  ContentView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI
import CoreData

struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext

    @State private var output: FortuneOutput? = nil
    
    var body: some View {
        VStack{
            InputView(output: $output)
            
            if let luckyPrefecture = output{
                OutputView(prefacture: luckyPrefecture)
            }
            
        }
    }
    

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
