//
//  ViewForResearch.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI
import Alamofire

struct ViewForResearch: View {
    
    @Environment(\ .colorScheme)var colorScheme
    @Binding var output:Result<LuckyPrefacture, AFError>?
    
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
        GeometryReader{ geo in
            ZStack{
                Image(colorScheme == .light ? "4181" : "1583")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .offset(x: colorScheme == .light ? 160 : -250, y: 0)// on iPhone 14 pro
                    .overlay{
                        VStack{
                            Text("Lucky Prefecture")
                                .foregroundColor(.white)
                                .fontWeight(.black)
                                .font(.largeTitle)
                                .shadow(radius: 8)
                                .padding(.top, 40)
                            Spacer()
                        }
                    }
                    .onTapGesture {
                        focus(at: .none)
                    }
                
                VStack{
                    Spacer()
                    Group{
                        HStack{
//                            HStack{
                                Text("Name")
                                Spacer()
//                            }.frame(width: 100)
                            TextField("John Doe",text: $name)
                                .focused($isTextFieldFocused)
                                .multilineTextAlignment(.trailing)
                                .submitLabel(.next)
                                .onSubmit { focus(at: .birthday) }
                            
//                            Spacer()
                        }.padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color(.systemGray6) )
                        )
                        .compositingGroup()
                        .shadow(color: isTextFieldFocused ? .white : .clear, radius: 8)
                        .onTapGesture { focus(at: .name) }
                        
                        HStack{
//                            HStack{
                            Text("Birthday")
                            Spacer()
//                            }.frame(width: 100)
                            Text("\(YearMonthDay(from: self.birthday).toString())")
//                            Spacer()
                            
                        }.padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color(.systemGray6) )
                        )
                        .compositingGroup()
                        .shadow(color: isBirthdayFocused ? .white : .clear, radius: 8)
                        .onTapGesture { focus(at: .birthday) }
                        
                        HStack{
//                            HStack{
                                Text("Blood Type")
                                Spacer()
//                            }.frame(width: 100)
                            Text(bloodType.rawValue)
//                            Spacer()
                        }.padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color(.systemGray6) )
                        )
                        .compositingGroup()
                        .shadow(color: isBloodTypeFocused ? .white : .clear, radius: 8)
                        .onTapGesture { focus(at: .bloodType) }
                    }
                        .padding(.bottom)
                        .padding(.horizontal)
                        
                    
                    if isFetchFortuneButtonDisplayed{
                        Button{
                            print("fetch button tapped")
                            let birthday = YearMonthDay(from: self.birthday)
                            print("bloodtype: \(bloodType)")
                            let today = YearMonthDay(from: Date() )
                        
                            let input = FortuneInput(name: self.name,
                                                     birthday: birthday,
                                                     bloodType: self.bloodType,
                                                     today: today)
                            print("input: \(input)")
                            Task{
                                output = await fetchLuckyPrefecture(input: input)
                            }
                        }label:{
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                
                        }.buttonStyle(.borderedProminent)
                            .compositingGroup()
                            .shadow(color: .white ,radius: 8)
                    }
                    
                    if isBirthdayFocused{
                        DatePicker("Birthday", selection: $birthday,displayedComponents: [.date])
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .frame(width: geo.size.width)
                            .background(Color("keyboardBackground") )
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
                            .transition(.move(edge: .bottom))
                            .onChange(of: bloodType) { newValue in
                                focus(at: .none)
                                isFetchFortuneButtonDisplayed = true
                            }
                    }
                    
                }
            }
        }
        
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
}

struct ViewForResearch_Previews: PreviewProvider {
    @State static private var output: Result<LuckyPrefacture, AFError>? = nil
    static var previews: some View {
        ViewForResearch(output:$output)
    }
}
