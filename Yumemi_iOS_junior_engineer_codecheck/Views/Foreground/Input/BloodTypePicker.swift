//
//  BloodTypePicker.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//

//import SwiftUI
//
//struct BloodTypePicker: View {
//    @Binding var bloodType:ABOBloodType
//    let disabled:Bool
//    let buttonAction:()->Void
//
//    var body: some View {
//        KeyboardAlikeView{
//            HStack{
//                Picker("BloodType", selection: $bloodType){
//                    ForEach(ABOBloodType.allCases){  bloodType in
//                        Text(bloodType.rawValue).tag(bloodType)
//                    }
//                }.pickerStyle(.wheel)
//
//                Button("See Fortune") {
//                    buttonAction()
//                }.buttonStyle(.borderedProminent)
//                    .disabled(disabled)
//            }//.keyboardAlike
//        }
//    }
//}
