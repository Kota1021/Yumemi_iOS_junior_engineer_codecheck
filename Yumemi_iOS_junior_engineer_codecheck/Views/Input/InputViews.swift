//
//  ProtocolOrientedTest.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//

import SwiftUI
import Alamofire



struct InputView<Model>: View where Model: InputViewModelProtocol{
    @StateObject var viewModel:Model
    @EnvironmentObject var safeArea:SafeArea
    
    @FocusState private var isTextFieldFocused:Bool
    
    var body: some View {
        VStack{
            Spacer()
            
            VStack{
                InputForm("Name"){
                    TextField("John Doe",text: $viewModel.name)
                        .multilineTextAlignment(.trailing)
                        .submitLabel(.next)

                }.shadow(color: viewModel.isTextFieldFocused ? .white : .clear, radius: 8)
                /// setting FocusState to Name TextField, and sync it with viewModel's Published<Bool> property. Wanna write in a cleaner way.
                    .focused(self.$isTextFieldFocused)
                    .onAppear { self.isTextFieldFocused = viewModel.isTextFieldFocused}
                    .onChange(of: self.isTextFieldFocused) { viewModel.isTextFieldFocused = $0 }
                    .onChange(of: viewModel.isTextFieldFocused) { self.isTextFieldFocused = $0 }
                
                    .onSubmit { viewModel.focus(at: .birthday) }
                    .onTapGesture { viewModel.focus(at: .name) }

                InputForm("Birthday"){
                    Text("\(YearMonthDay(from: viewModel.birthday).toString())")

                }
                .shadow(color: viewModel.isBirthdayFocused ? .white : .clear, radius: 8)
                .onTapGesture { viewModel.focus(at: .birthday) }

                InputForm("Blood Type"){
                    Text(viewModel.bloodType.rawValue)

                }
                .shadow(color: viewModel.isBloodTypeFocused ? .white : .clear, radius: 8)
                .onTapGesture { viewModel.focus(at: .bloodType) }
                
                if viewModel.isFetchButtonDisplayed{
                    FetchButton(action: viewModel.fetchLuckyPrefecture)
                    
                }
                
            }
            .padding(.bottom,40)
            .padding(.bottom, safeArea.insets.bottom)
            
            
            if viewModel.isBirthdayFocused{
                KeyboardAlikeView{
                    HStack{
                        DatePicker("Birthday", selection: $viewModel.birthday,displayedComponents: [.date])
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                        
                        Button("Next") {
                            viewModel.focus(at: .bloodType)
                        }.buttonStyle(.borderedProminent)
                    }
                }
                
            }else if viewModel.isBloodTypeFocused{
                KeyboardAlikeView{
                    HStack{
                        Picker("BloodType", selection: $viewModel.bloodType){
                            ForEach(ABOBloodType.allCases){  bloodType in
                                Text(bloodType.rawValue).tag(bloodType)
                            }
                        }.pickerStyle(.wheel)
                        
                        Button("See Fortune") {
                            viewModel.fetchLuckyPrefecture()
                            viewModel.focus(at: .none)
                        }.buttonStyle(.borderedProminent)
                            .disabled(!viewModel.input.isValid)
                    }
                }
            }

        }.background(
            Rectangle()
                .foregroundColor(.clear)
                .contentShape(Rectangle() )
                .onTapGesture {
                    viewModel.focus(at: .none)
                }
        )
        
    }
    
}

struct ViewForResearch_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{geo in
            InputView(viewModel: InputViewLogic(prefectureModel:PrefectureModel() ))
                .environmentObject(SafeArea() )
        }
    }
}










