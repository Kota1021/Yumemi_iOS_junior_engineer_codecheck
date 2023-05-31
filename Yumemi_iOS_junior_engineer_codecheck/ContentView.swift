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

    var body: some View {
        //まずはAPIを叩く最低限の機能を作成
        Button("API test"){
            fetchAPITest()
        }
    }
    

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
