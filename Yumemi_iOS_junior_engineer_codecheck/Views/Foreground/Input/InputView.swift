////
////  ViewForResearch.swift
////  Yumemi_iOS_junior_engineer_codecheck
////
////  Created by 松本幸太郎 on 2023/05/31.
////
//
//import SwiftUI
//import Alamofire
//
//struct InputView: View {
//    
//    // Below send output and flag to ParentView.
//    @Binding var output:Result<Prefecture, AFError>?
//    @Binding var fetchButtonTapped:Bool
//    
//    // Below is to move views with keyboard's movement
//    let geometry:GeometryProxy
//    
//    
//    @State private var name:String = ""
//    @State private var birthday:Date = Date()
//    @State private var bloodType:ABOBloodType = .a
//    
//    private var input:FortuneInput{
//        .init(name: name,
//              birthday: YearMonthDay(from: birthday),
//              bloodType: bloodType,
//              today: YearMonthDay(from: Date() ) )
//    }
//    
//    @FocusState private var isTextFieldFocused:Bool
//    @State private var isBirthdayFocused = false
//    @State private var isBloodTypeFocused = false
//    
//    private var isFetchButtonDisplayed:Bool{
//        (!isTextFieldFocused && !isBirthdayFocused && !isBloodTypeFocused) && input.isValid
//    }
//    
//    
//    var body: some View {
//        
//        VStack{
//            Spacer()
//            
//            VStack{
//                InputForms()
//                
//                if isFetchButtonDisplayed{
//                FetchButton()
//                }
//            }
//            // this padding allows this view to adopt to keyboard hight.
//            .padding(.bottom, isTextFieldFocused ? geometry.safeAreaInsets.bottom : 40)
//            
//            
//            if isBirthdayFocused{
//                    BirthdayPicker()
//                
//            }else if isBloodTypeFocused{
//                    BloodTypePicker()
//            }
//
//        }.background(
//            Rectangle()
//                .foregroundColor(.clear)
//                .contentShape(Rectangle() )
//                .onTapGesture {
//                    focus(at: .none)
//                }
//        )
//        
//    }
//    
//
//    
//    private func fetchLuckyPrefectureButton(){
//        print("fetch button tapped")
//        
//        if input.isValid{
//            print("input: \(input)")
//            Task{ 
//                output = await Yumemi_iOS_junior_engineer_codecheck.fetchLuckyPrefecture(input: input)
//            }
//        }else{
//            print("input invalid")
//        }
//        fetchButtonTapped = true
//    }
//    
//    private enum Field:Hashable{
//        case name, birthday, bloodType
//    }
//    
//    private func focus(at field:Field?){
//        withAnimation{
//            isTextFieldFocused = false
//            isBirthdayFocused = false
//            isBloodTypeFocused = false
//            
//            switch field{
//            case .none:
//                break
//            case .name:
//                isTextFieldFocused = true
//                
//            case .birthday:
//                isBirthdayFocused = true
//                
//            case .bloodType:
//                isBloodTypeFocused = true
//                
//            }
//        }
//    }
//    
//}
//
//struct ViewForResearch_Previews: PreviewProvider {
//    @State static private var output: Result<Prefecture, AFError>? = nil
//    @State static private var fetchButtonTapped = false
//    static var previews: some View {
//        GeometryReader{geo in
//            InputView(output:$output, fetchButtonTapped: $fetchButtonTapped, geometry: geo)
//        }
//    }
//}
//
//
//
//struct InputForms: View {
//    
//    var body: some View {
//        VStack{
//            InputForm("Name"){
//                TextField("John Doe",text: $name)
//                    .multilineTextAlignment(.trailing)
//                    .submitLabel(.next)
//                
//            }.shadow(color: isTextFieldFocused ? .white : .clear, radius: 8)
//                .focused($isTextFieldFocused)
//                .onSubmit { focus(at: .birthday) }
//                .onTapGesture { focus(at: .name) }
//            
//            InputForm("Birthday"){
//                Text("\(YearMonthDay(from: self.birthday).toString())")
//                
//            }
//            .shadow(color: isBirthdayFocused ? .white : .clear, radius: 8)
//            .onTapGesture { focus(at: .birthday) }
//            
//            InputForm("Blood Type"){
//                Text(bloodType.rawValue)
//                
//            }
//            .shadow(color: isBloodTypeFocused ? .white : .clear, radius: 8)
//            .onTapGesture { focus(at: .bloodType) }
//        }
//    }
//    
//    
//
//}
//
//struct BirthdayPicker: View {
//    var body: some View {
//        HStack{
//            DatePicker("Birthday", selection: $birthday,displayedComponents: [.date])
//                .datePickerStyle(.wheel)
//                .labelsHidden()
//            
//            Button("Next") {
//                focus(at: .bloodType)
//            }.buttonStyle(.borderedProminent)
//        }.keyboardAlike
//    }
//}
//
//struct BloodTypePicker: View {
//    var body: some View {
//        HStack{
//            Picker("BloodType", selection: $bloodType){
//                ForEach(ABOBloodType.allCases){  bloodType in
//                    Text(bloodType.rawValue).tag(bloodType)
//                }
//            }.pickerStyle(.wheel)
//            
//            Button("See Fortune") {
//                focus(at: .none)
//                fetchLuckyPrefectureButton()
//            }.buttonStyle(.borderedProminent)
//                .disabled( !input.isValid)
//        }.keyboardAlike
//    }
//}
//
//struct FetchButton: View {
//    var body: some View {
//        Button{
//            fetchLuckyPrefectureButton()
//        }label:{
//            HStack{
//                Image(systemName: "paperplane.fill")
//                    .resizable()
//                    .frame(width: 30, height: 30)
//                Text("See Lucky Prefecture")
//            }
//        }.buttonStyle(.borderedProminent)
//            .compositingGroup()
//            .shadow(color: .white ,radius: 8)
//    }
//}
