//
//  BirthdayPicker.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//

import SwiftUI

struct BirthdayPicker: View {
    @Binding var birthday:Date
    let vm:ViewLogicProtocol
    var body: some View {
        HStack{
            DatePicker("Birthday", selection: $birthday,displayedComponents: [.date])
                .datePickerStyle(.wheel)
                .labelsHidden()

            Button("Next") {
                vm.focus(at: .bloodType)
            }.buttonStyle(.borderedProminent)
        }.keyboardAlike
    }
}
