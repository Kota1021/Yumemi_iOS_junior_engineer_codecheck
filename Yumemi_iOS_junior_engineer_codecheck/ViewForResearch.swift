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
    @State private var output: Result<LuckyPrefacture, AFError>? = nil
    @State private var name:String = ""
    
    @State private var birthday:Date = Date()
    private let calendar = Calendar(identifier: .gregorian)
    @State private var hasYearChanged = false
    @State private var hasMonthChanged = false
    @State private var hasDayChanged = false
    
    @State private var bloodType:ABOBloodType = .a
    
    @FocusState private var isTextFieldFocused:Bool
    @State private var isBirthdayPickerDisplayed = false
    @State private var isBloodTypePickerDisplayed = false
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image(colorScheme == .light ? "4181" : "1583")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .offset(x: colorScheme == .light ? 160 : -250, y: 0)//iPhone 14 Proのoffset
                
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
                            TextField("name",text: $name)
                                .focused($isTextFieldFocused)
                                .padding()
                                .submitLabel(.next)
                                .onSubmit {
                                    focus(at: .birthday)
                                }
                            Spacer()
                        }.contentShape(Rectangle() )
                            .onTapGesture {
                                focus(at: .name)
                            }
                        
                        
                        HStack{
                            Text("birthday")
                                .padding()
                            Spacer()
                        }.contentShape(Rectangle() )
                        .onTapGesture {
                            focus(at: .birthday)
                        }
                        
                        HStack{
                            Text("blood type")
                                .padding()
                            Spacer()
                        }.contentShape(Rectangle() )
                        .onTapGesture {
                            focus(at: .bloodType)
                        }
                    }.background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color(.systemBackground) )
                    )
                        .padding(.bottom)
                        .padding(.horizontal)
                    
                    if isBirthdayPickerDisplayed{
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
                                if hasYearMonthDayChanged{ focus(at: .bloodType) }
                            }
                            .onDisappear{
                                self.hasYearChanged = false
                                self.hasMonthChanged = false
                                self.hasDayChanged = false
                            }
                        
                    }
                    if isBloodTypePickerDisplayed{
                        Picker("BloodType", selection: $bloodType){
                            ForEach(ABOBloodType.allCases){  bloodType in
                                Text(bloodType.rawValue).tag(bloodType)
                            }
                        }.pickerStyle(.wheel)
                            .background(Color("keyboardBackground") )
                            .transition(.move(edge: .bottom))
                    }
                    
                }
            }
        }
        
    }
    
    private func focus(at field:FocusedField?){
        withAnimation{
            
                    isTextFieldFocused = false
                    isBirthdayPickerDisplayed = false
                    isBloodTypePickerDisplayed = false
            
            switch field{
            case .none:
                break
            case .name:
                isTextFieldFocused = true
                
            case .birthday:
                isBirthdayPickerDisplayed = true
                
            case .bloodType:
                isBloodTypePickerDisplayed = true
            }
        }
        
    }
    
    private enum FocusedField:Hashable{
        case name, birthday, bloodType
    }
}

struct ViewForResearch_Previews: PreviewProvider {
    static var previews: some View {
        ViewForResearch()
    }
}
