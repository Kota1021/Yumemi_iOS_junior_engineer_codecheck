//
//  InputView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI

struct InputView: View {
    @State private var name: String = ""
    @State private var birthday = Date()
    @State private var bloodType: ABOBloodType = .a
    
    var body: some View {
        //inputViewを作成
        VStack{
            TextField("Name", text: $name)
            
            DatePicker("Birthday", selection: $birthday,displayedComponents: [.date])
                .datePickerStyle(.wheel)
                
            Picker("BloodType", selection: $bloodType){
                ForEach(ABOBloodType.allCases){  bloodType in
                    Text(bloodType.rawValue).tag(bloodType)
                }
            }.pickerStyle(.wheel)
            
            Button("API test"){
                print("fetch button tapped")
                let birthday = YearMonthDay(from: self.birthday)
                print("bloodtype: \(bloodType)")
                let today = YearMonthDay(from: Date() )
            
                let input = FortuneInput(name: self.name, birthday: birthday, bloodType: self.bloodType, today: today)
                
                fetchAPI(input: input)
            }
            
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
