//
//  ViewForResearch.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI
import Alamofire

struct InputView: View {
    @Binding var output:Result<LuckyPrefecture, AFError>?
    let geometry:GeometryProxy
    
    @State private var name:String = ""
    
    @State private var birthday:Date = Date()
    private let calendar = Calendar(identifier: .gregorian)
    @State private var hasYearChanged = false
    @State private var hasMonthChanged = false
    @State private var hasDayChanged = false
    
    @State private var bloodType:ABOBloodType = .a
    @State private var hasBloodTypeChanged = false
    
    @FocusState private var isTextFieldFocused:Bool
    @State private var isBirthdayFocused = false
    @State private var isBloodTypeFocused = false
    
    @State private var isFetchFortuneButtonDisplayed = false
    
    
    var body: some View {
        //        GeometryReader{ geometry in
        VStack{
            Spacer()
            VStack{
                InputForm("Name"){
                    TextField("John Doe",text: $name)
                        .multilineTextAlignment(.trailing)
                        .submitLabel(.next)
                    
                }.shadow(color: isTextFieldFocused ? .white : .clear, radius: 8)
                    .focused($isTextFieldFocused)
                    .onSubmit { focus(at: .birthday) }
                    .onTapGesture { focus(at: .name) }
                
                InputForm("Birthday"){
                    Text("\(YearMonthDay(from: self.birthday).toString())")
                    
                }.shadow(color: isBirthdayFocused ? .white : .clear, radius: 8)
                    .onTapGesture { focus(at: .birthday) }
                
                InputForm("Blood Type"){
                    Text(bloodType.rawValue)
                    
                }.shadow(color: isBloodTypeFocused ? .white : .clear, radius: 8)
                    .onTapGesture { focus(at: .bloodType) }
                
                if isFetchFortuneButtonDisplayed{
                    Button{
                        fetchLucyPrefecture()
                    }label:{
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                    }.buttonStyle(.borderedProminent)
                        .compositingGroup()
                        .shadow(color: .white ,radius: 8)
                }
            }
            .padding(.bottom, isTextFieldFocused ? geometry.safeAreaInsets.bottom : 40)
            
            
            
            
            if isBirthdayFocused{
                DatePicker("Birthday", selection: $birthday,displayedComponents: [.date])
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(width: geometry.size.width)
                //                            .frame(width: viewSize.width)
                    .background(Color("keyboardBackground") )
                    .ignoresSafeArea()
                    .transition(.move(edge: .bottom))
                    .onChange(of: calendar.component(.year, from: birthday)) { _ in
                        self.hasYearChanged = true
                    }
                    .onChange(of: calendar.component(.month, from: birthday)) { _ in
                        self.hasMonthChanged = true
                    }
                    .onChange(of: calendar.component(.day, from: birthday)) { _ in
                        self.hasDayChanged = true
                    }
                    .onChange(of: hasYearChanged && hasMonthChanged && hasDayChanged) { hasYearMonthDayChanged in
                        //rough　probability　of changing all of Year,Month and Day ==  59/60(year) * 11/12(month) * 29/30(day)
                        //releasing around 87% of individuals from an effort to change focus
                        if hasYearMonthDayChanged{ focus(at: .bloodType) }
                    }
                    .onDisappear{
                        self.hasYearChanged = false
                        self.hasMonthChanged = false
                        self.hasDayChanged = false
                    }
                
            }else if isBloodTypeFocused{
                Picker("BloodType", selection: $bloodType){
                    ForEach(ABOBloodType.allCases){  bloodType in
                        Text(bloodType.rawValue).tag(bloodType)
                    }
                }.pickerStyle(.wheel)
                    .background(Color("keyboardBackground") )
                    .ignoresSafeArea()
                    .transition(.move(edge: .bottom))
                    .onChange(of: bloodType) { newValue in
                        focus(at: .none)
                        isFetchFortuneButtonDisplayed = true
                    }
            }
            
        }.background(
            Rectangle()
                .foregroundColor(.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    focus(at: .none)
                }
        )
        
        
        
        //        }
        
    }
    
    private func focus(at field:Field?){
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
    
    private enum Field:Hashable{
        case name, birthday, bloodType
    }
    
    private func fetchLucyPrefecture(){
        print("fetch button tapped")
        let birthday = YearMonthDay(from: self.birthday)
        let today = YearMonthDay(from: Date() )
        
        let input = FortuneInput(name: self.name,
                                 birthday: birthday,
                                 bloodType: self.bloodType,
                                 today: today)
        print("input: \(input)")
        Task{
            output = await fetchLuckyPrefecture(input: input)
        }
    }
}

struct ViewForResearch_Previews: PreviewProvider {
    @State static private var output: Result<LuckyPrefecture, AFError>? = nil
    static var previews: some View {
        GeometryReader{geo in
            //            ViewForResearch(output:$output)
            //            ViewForResearch(viewSize: geo.size, output:$output)
            InputView(output:$output, geometry: geo)
        }
    }
}
