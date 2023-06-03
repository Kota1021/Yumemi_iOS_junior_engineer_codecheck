//
//  InputViewLogic.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//

import SwiftUI

protocol ViewLogicProtocol{
    func focus(at field:InputField?)
    func fetchLuckyPrefectureButton()
}

class ViewLogic:ObservableObject,ViewLogicProtocol{
    init(prefectureModel:PrefectureModel){
        self.prefectureModel = prefectureModel
    }
    
    // Below send output and flag to ParentView.
    @Published var fetchButtonTapped = false
    
    @Published  var name:String = ""
    @Published  var birthday:Date = Date()
    @Published  var bloodType:ABOBloodType = .a
    
//    @ObservedObject
    let prefectureModel:PrefectureModel
    
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
               prefectureModel.fetchLuckyPrefecture(input: input)
           }
       }else{
           print("input invalid")
       }
       fetchButtonTapped = true
   }
   
    func focus(at field:InputField?){
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

enum InputField:Hashable{
    case name, birthday, bloodType
}

