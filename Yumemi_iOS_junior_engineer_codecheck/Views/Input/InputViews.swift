//
//  ProtocolOrientedTest.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//

import SwiftUI
import Alamofire



struct InputView: View {
    @StateObject var viewLogic:ViewLogic
    
    // Below is to move views with keyboard's movement
    let geometry:GeometryProxy
    
    private var isFetchButtonDisplayed:Bool{
        (!viewLogic.isTextFieldFocused && !viewLogic.isBirthdayFocused && !viewLogic.isBloodTypeFocused) && viewLogic.input.isValid
    }
    
    var body: some View {
        
        VStack{
            Spacer()
            
            VStack{
                InputForms(name: $viewLogic.name, birthday: $viewLogic.birthday, bloodType: $viewLogic.bloodType, isTextFieldFocused: viewLogic.$isTextFieldFocused, isBirthdayFocused: $viewLogic.isBirthdayFocused, isBloodTypeFocused: $viewLogic.isBloodTypeFocused, vm: viewLogic)
                
                if isFetchButtonDisplayed{
                    FetchButton(vm: viewLogic)
                }
            }
            // this padding allows this view to adopt to keyboard hight.
            .padding(.bottom, viewLogic.isTextFieldFocused ? geometry.safeAreaInsets.bottom : 40)
            
            
            if viewLogic.isBirthdayFocused{
                BirthdayPicker(birthday: $viewLogic.birthday, vm: viewLogic)
                
            }else if viewLogic.isBloodTypeFocused{
                BloodTypePicker(bloodType: $viewLogic.bloodType, disabled: !viewLogic.input.isValid, vm: viewLogic)
            }

        }.background(
            Rectangle()
                .foregroundColor(.clear)
                .contentShape(Rectangle() )
                .onTapGesture {
                    viewLogic.focus(at: .none)
                }
        )
        
    }
    
}

struct ViewForResearch_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{geo in
            InputView(viewLogic: ViewLogic(prefectureModel:PrefectureModel()), geometry: geo)
        }
    }
}










