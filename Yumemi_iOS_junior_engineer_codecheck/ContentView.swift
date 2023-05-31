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

    @State private var name: String = ""
    @State private var birthday = Date()
    @State private var bloodType: ABOBloodType? = nil
    
    var body: some View {
        //inputViewを作成
        VStack{
            TextField("Name", text: $name)
            
            DatePicker("Birthday", selection: $birthday,displayedComponents: [.date])
                .datePickerStyle(.wheel)
                
            Picker("BloodType", selection: $bloodType){
                ForEach(ABOBloodType.allCases){  bloodType in
                    Text(bloodType.rawValue)
                }
            }.pickerStyle(.wheel)
            
            Button("API test"){
                fetchAPITest()
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
