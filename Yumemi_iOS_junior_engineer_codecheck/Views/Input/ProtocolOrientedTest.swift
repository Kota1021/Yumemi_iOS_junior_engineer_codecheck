//
//  ProtocolOrientedTest.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//

import SwiftUI
import Alamofire

protocol TestProtocol{
    func focus(at field:Field?)
    func fetchLuckyPrefectureButton()
}

enum Field:Hashable{
    case name, birthday, bloodType
}

class TestViewModel:ObservableObject,TestProtocol{
    // Below send output and flag to ParentView.
    @Published var output:Result<Prefecture, AFError>? = nil
    @Published var fetchButtonTapped = false
    
    @Published  var name:String = ""
    @Published  var birthday:Date = Date()
    @Published  var bloodType:ABOBloodType = .a
    
    var input:FortuneInput{
        .init(name: name,
              birthday: YearMonthDay(from: birthday),
              bloodType: bloodType,
              today: YearMonthDay(from: Date() ) )
    }
    
    @FocusState  var isTextFieldFocused:Bool
    @Published  var isBirthdayFocused = false
    @Published  var isBloodTypeFocused = false
    
    func fetchLuckyPrefectureButton(){
       print("fetch button tapped")
       
       if input.isValid{
           print("input: \(input)")
           Task{
               output = await Yumemi_iOS_junior_engineer_codecheck.fetchLuckyPrefecture(input: input)
           }
       }else{
           print("input invalid")
       }
       fetchButtonTapped = true
   }
   
    func focus(at field:Field?){
       withAnimation{
           isTextFieldFocused = false
           isBirthdayFocused = false
           isBloodTypeFocused = false
           
           switch field{
           case .none:
               break
           case .name:
               isTextFieldFocused = true
               
           case .birthday:
               isBirthdayFocused = true
               
           case .bloodType:
               isBloodTypeFocused = true
               
           }
       }
   }
}

struct ProtocolOrientedTestView: View {
    
    @StateObject private var vm = TestViewModel()
    
    // Below is to move views with keyboard's movement
    let geometry:GeometryProxy
    
    private var isFetchButtonDisplayed:Bool{
        (!vm.isTextFieldFocused && !vm.isBirthdayFocused && !vm.isBloodTypeFocused) && vm.input.isValid
    }
    
    var body: some View {
        
        VStack{
            Spacer()
            
            VStack{
                InputForms(name: $vm.name, birthday: $vm.birthday, bloodType: $vm.bloodType, isTextFieldFocused: vm.$isTextFieldFocused, isBirthdayFocused: $vm.isBirthdayFocused, isBloodTypeFocused: $vm.isBloodTypeFocused, vm: vm)
                
                if isFetchButtonDisplayed{
                    FetchButton(vm: vm)
                }
            }
            // this padding allows this view to adopt to keyboard hight.
            .padding(.bottom, vm.isTextFieldFocused ? geometry.safeAreaInsets.bottom : 40)
            
            
            if vm.isBirthdayFocused{
                BirthdayPicker(birthday: $vm.birthday, vm: vm)
                
            }else if vm.isBloodTypeFocused{
                BloodTypePicker(bloodType: $vm.bloodType, disabled: !vm.input.isValid, vm: vm)
            }

        }.background(
            Rectangle()
                .foregroundColor(.clear)
                .contentShape(Rectangle() )
                .onTapGesture {
                    vm.focus(at: .none)
                }
        )
        
    }
    
}

struct ViewForResearch_Previews: PreviewProvider {
    @State static private var output: Result<Prefecture, AFError>? = nil
    @State static private var fetchButtonTapped = false
    static var previews: some View {
        GeometryReader{geo in
            ProtocolOrientedTestView(geometry: geo)
        }
    }
}



struct InputForms: View {
    @Binding var name:String
    @Binding var birthday:Date
    @Binding var bloodType:ABOBloodType
    var isTextFieldFocused:FocusState<Bool>.Binding //https://stackoverflow.com/questions/70141230/passing-down-focusstate-to-another-view
    @Binding var isBirthdayFocused:Bool
    @Binding var isBloodTypeFocused:Bool
    let vm:TestProtocol
    
    var body: some View {
        VStack{
            InputForm("Name"){
                TextField("John Doe",text: $name)
                    .multilineTextAlignment(.trailing)
                    .submitLabel(.next)

            }.shadow(color: isTextFieldFocused.wrappedValue ? .white : .clear, radius: 8)
                .focused(isTextFieldFocused)
                .onSubmit { vm.focus(at: .birthday) }
                .onTapGesture { vm.focus(at: .name) }

            InputForm("Birthday"){
                Text("\(YearMonthDay(from: self.birthday).toString())")

            }
            .shadow(color: isBirthdayFocused ? .white : .clear, radius: 8)
            .onTapGesture { vm.focus(at: .birthday) }

            InputForm("Blood Type"){
                Text(bloodType.rawValue)

            }
            .shadow(color: isBloodTypeFocused ? .white : .clear, radius: 8)
            .onTapGesture { vm.focus(at: .bloodType) }
        }
    }



}

struct BirthdayPicker: View {
    @Binding var birthday:Date
    let vm:TestProtocol
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

struct BloodTypePicker: View {
    @Binding var bloodType:ABOBloodType
    let disabled:Bool
    let vm:TestProtocol
    
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

struct FetchButton: View {
    let vm:TestProtocol
    var body: some View {
        Button{
            vm.fetchLuckyPrefectureButton()
        }label:{
            HStack{
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("See Lucky Prefecture")
            }
        }.buttonStyle(.borderedProminent)
            .compositingGroup()
            .shadow(color: .white ,radius: 8)
    }
}
