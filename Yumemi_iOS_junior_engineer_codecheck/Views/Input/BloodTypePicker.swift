//
//  BloodTypePicker.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//

import SwiftUI

struct BloodTypePicker: View {
    @Binding var bloodType:ABOBloodType
    let disabled:Bool
    let vm:ViewLogicProtocol
    
    var body: some View {
        HStack{
            Picker("BloodType", selection: $bloodType){
                ForEach(ABOBloodType.allCases){  bloodType in
                    Text(bloodType.rawValue).tag(bloodType)
                }
            }.pickerStyle(.wheel)

            Button("See Fortune") {
                vm.focus(at: .none)
                vm.fetchLuckyPrefectureButton()
            }.buttonStyle(.borderedProminent)
                .disabled(disabled)
        }.keyboardAlike
    }
}
