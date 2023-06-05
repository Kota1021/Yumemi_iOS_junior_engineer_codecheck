////
////  ImputForms.swift
////  Yumemi_iOS_junior_engineer_codecheck
////
////  Created by 松本幸太郎 on 2023/06/03.
////
//
//import SwiftUI
//
//struct InputForms: View {
//    @Binding var name:String
//    @Binding var birthday:Date
//    @Binding var bloodType:ABOBloodType
//    var isTextFieldFocused:FocusState<Bool>.Binding //https://stackoverflow.com/questions/70141230/passing-down-focusstate-to-another-view
//    @Binding var isBirthdayFocused:Bool
//    @Binding var isBloodTypeFocused:Bool
//    let vm:ViewLogicProtocol
//
//    var body: some View {
//        VStack{
//            InputForm("Name"){
//                TextField("John Doe",text: $name)
//                    .multilineTextAlignment(.trailing)
//                    .submitLabel(.next)
//
//            }.shadow(color: isTextFieldFocused.wrappedValue ? .white : .clear, radius: 8)
//                .focused(isTextFieldFocused)
//                .onSubmit { vm.focus(at: .birthday) }
//                .onTapGesture { vm.focus(at: .name) }
//
//            InputForm("Birthday"){
//                Text("\(YearMonthDay(from: self.birthday).toString())")
//
//            }
//            .shadow(color: isBirthdayFocused ? .white : .clear, radius: 8)
//            .onTapGesture { vm.focus(at: .birthday) }
//
//            InputForm("Blood Type"){
//                Text(bloodType.rawValue)
//
//            }
//            .shadow(color: isBloodTypeFocused ? .white : .clear, radius: 8)
//            .onTapGesture { vm.focus(at: .bloodType) }
//        }
//    }
//
//
//
//}
//
//struct ImputForms_Previews: PreviewProvider {
//    @ObservedObject static var vm = ViewLogic(prefectureModel: PrefectureModel() )
//    static var previews: some View {
//        InputForms(name: $vm.name, birthday: $vm.birthday, bloodType: $vm.bloodType, isTextFieldFocused: vm.$isTextFieldFocused, isBirthdayFocused: $vm.isBirthdayFocused, isBloodTypeFocused: $vm.isBloodTypeFocused, vm: vm)
//    }
//}
