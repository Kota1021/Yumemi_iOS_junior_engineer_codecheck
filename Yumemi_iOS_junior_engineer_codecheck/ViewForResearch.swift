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
    
    @FocusState private var isTextFieldFocused:Bool{
        didSet{
            if oldValue{
                focusedField = .name
            }
        }
    }
    @State private var focusedField:FocusedField? = nil{
        didSet{
            if oldValue == .birthday || oldValue == .bloodType {
                isTextFieldFocused = false
            }
        }
    }
    
    
    
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
                        isTextFieldFocused = false
                    }
                
                VStack{
                    Spacer()
                    Group{
                        HStack{
                            TextField("name",text: $name)
                                .focused($isTextFieldFocused)
                                .padding()
                            Spacer()
                        }
                        
                        
                        HStack{
                            Text("birthday")
                                .padding()
                            Spacer()
                        }.contentShape(Rectangle() )
                        .onTapGesture {
                            focusedField = .birthday
                        }
                        
                        HStack{
                            Text("blood type")
                                .padding()
                            Spacer()
                        }.contentShape(Rectangle() )
                        .onTapGesture {
                            focusedField = .bloodType
                        }
                    }.background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color("Background") )
                    )
                        .padding(.bottom)
                        .padding(.horizontal)
                    
                    switch focusedField {

                    case .none,.name:
                        EmptyView()

                    case .birthday:
                        DatePicker("Birthday", selection: $birthday,displayedComponents: [.date])
                                        .datePickerStyle(.wheel)
                                        .labelsHidden()
                                        

                    case .bloodType:
                        Picker("BloodType", selection: $bloodType){
                            ForEach(ABOBloodType.allCases){  bloodType in
                                Text(bloodType.rawValue).tag(bloodType)
                            }
                        }.pickerStyle(.wheel)
                    }
                    
                }
            }
        }
        
    }
    
    enum FocusedField:Hashable{
        case name, birthday, bloodType
        
        var isNameInFocus:Bool{ self == .name }
        var isBirthdayInFocus:Bool{ self == .birthday }
        var isBloodTypeInFocus:Bool{ self == .bloodType }
    }
}

struct ViewForResearch_Previews: PreviewProvider {
    static var previews: some View {
        ViewForResearch()
    }
}
