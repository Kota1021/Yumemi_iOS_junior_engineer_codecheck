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
    @State private var test:String = ""
    @State private var birthday:Date = Date()
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
                            
                        
                    }
                    if isBloodTypePickerDisplayed{
                        Picker("BloodType", selection: $bloodType){
                            ForEach(ABOBloodType.allCases){  bloodType in
                                Text(bloodType.rawValue).tag(bloodType)
                            }
                        }.pickerStyle(.wheel)
                            .background(Color("keyboardBackground") )
                    }
                    
                }
            }
        }
        
    }
    
    private func focus(at field:FocusedField?){
        withAnimation{
            switch field{
            case .none:
                isTextFieldFocused = false
                isBirthdayPickerDisplayed = false
                isBloodTypePickerDisplayed = false
            case .name:
                isTextFieldFocused = true
                isBirthdayPickerDisplayed = false
                isBloodTypePickerDisplayed = false
                
            case .birthday:
                isTextFieldFocused = false
                isBirthdayPickerDisplayed = true
                isBloodTypePickerDisplayed = false
                
            case .bloodType:
                isTextFieldFocused = false
                isBirthdayPickerDisplayed = false
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
