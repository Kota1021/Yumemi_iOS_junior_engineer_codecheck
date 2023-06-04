//
//  InputViewLogic.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//

import SwiftUI
import SwiftyUserDefaults


//this time I only wrote a ViewModel for InputView, which is I think complicated enough to need one.

protocol InputViewModelProtocol:ObservableObject{
    var name:String { get set }
    var birthday:Date { get set }
    var bloodType:ABOBloodType { get set }
    var input:FortuneInput { get }
    
    var isTextFieldFocused:Bool{ get set }
    var isBirthdayFocused:Bool { get set }
    var isBloodTypeFocused:Bool { get set }
    var isFetchButtonDisplayed:Bool{ get }
    
    var dateRange:ClosedRange<Date>{ get }
    func fetchLuckyPrefecture(onReceive action:@escaping ()->Void)
    func focus(at:InputField?)
    func viewDidDisappear()
}


class InputViewModel<PrefectureModel:PrefectureModelProtocol>:ObservableObject,InputViewModelProtocol{
    
    
    init(prefectureModel:PrefectureModel){
        self.prefectureModel = prefectureModel
        
        //Loading user info from User Defaults
        print("loading user info: \(Defaults[\.userInfo])")
        let userInfo = Defaults[\.userInfo]
        self.name = userInfo.name
        self.birthday = userInfo.birthday.toDate()
        self.bloodType = userInfo.bloodType
    }
    
    func viewDidDisappear(){
        print("saving input as userInfo into UserDefaults: ")
        Defaults[\.userInfo] = input
    }
    
    
    let prefectureModel:PrefectureModel
    
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
    
    var dateRange: ClosedRange<Date>{
            let calendar = Calendar.current
            let start = calendar.date(byAdding: .year, value: -100, to: Date())!
            let today = Date()
            return start...today
        }
    
    func fetchLuckyPrefecture(onReceive action:@escaping ()->Void){
       print("fetch button tapped")
        
       if input.isValid{
           print("input: \(input)")
               prefectureModel.fetchLuckyPrefecture(input: input){
               action()
           }
               
       }else{
           print("input invalid")
       }
        
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
