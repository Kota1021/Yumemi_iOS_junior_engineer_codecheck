//
//  InputView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI

struct InputView: View {
    
    @Binding var output:FortuneOutput?
    
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
                Task{
                    do {
                        let result = try await fetchLuckyPrefecture(input: input)
                        output = try result.get()
                    }catch{
                        print(error)
                    }
                }
            }
            
        }
    }
}

struct InputView_Previews: PreviewProvider {
    @State static var luckeyPrefacture:FortuneOutput? = FortuneOutput(name: "徳島県", brief: "徳島県（とくしまけん）は、日本の四国地方に位置する県。県庁所在地は徳島市。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』", capital: "徳島市", citizenDay: nil, hasCoastLine: true, logoUrl: URL(string: "https://japan-map.com/wp-content/uploads/tokushima.png")!)
    
    static var previews: some View {
        InputView(output:$luckeyPrefacture)
    }
}
