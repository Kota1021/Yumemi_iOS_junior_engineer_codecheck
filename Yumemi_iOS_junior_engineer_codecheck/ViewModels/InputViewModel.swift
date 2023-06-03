//
//  InputViewLogic.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//

import SwiftUI

protocol InputViewModel:ObservableObject{
    var name:String { get set }
    var birthday:Date { get set }
    var bloodType:ABOBloodType { get set }
    var isTextFieldFocused:Bool{ get set }
    var isBirthdayFocused:Bool { get set }
    var isBloodTypeFocused:Bool { get set }
    var isFetchButtonDisplayed:Bool{ get }
//    var bottomSafeArea:CGFloat { get }
    var input:FortuneInput { get }
    func fetchLuckyPrefectureButton()
    func focus(at:InputField?)
}

class InputViewLogic:ObservableObject,InputViewModel{
    
    init(prefectureModel:PrefectureModel/*,geometry:GeometryProxy*/){
        self.prefectureModel = prefectureModel
//        self.geometry = geometry
    }
    
    let prefectureModel:PrefectureModel
    
    // Below sends flag to ParentView.
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
    
    @Published  var isTextFieldFocused = false
    @Published  var isBirthdayFocused = false
    @Published  var isBloodTypeFocused = false
    
    var isFetchButtonDisplayed:Bool{
        (!isTextFieldFocused && !isBirthdayFocused && !isBloodTypeFocused) && input.isValid
    }
    
    
    // Below is to move views with keyboard's movement
//    let geometry:GeometryProxy?
//    var bottomSafeArea:CGFloat{ isTextFieldFocused ? geometry.safeAreaInsets.bottom : 40 }
    
    
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

