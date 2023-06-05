//
//  InputViewLogic.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//

import SwiftUI
import SwiftyUserDefaults


//this time I only made a ViewModel for InputView, which is I think complicated enough to need one.
//Not MVVM, however, Views know the Model and Model is independent of Views.

protocol InputViewModelProtocol:ObservableObject{
    var name:String { get set }
    var birthday:Date { get set }
    var bloodType:ABOBloodType { get set }
    var input:FetchInput { get }
    
    var isTextFieldFocused:Bool{ get set }
    var isBirthdayFocused:Bool { get set }
    var isBloodTypeFocused:Bool { get set }
    var isFetchButtonDisplayed:Bool{ get }
    
    
    var dateRange:ClosedRange<Date>{ get }
    func fetchLuckyPrefecture(onReceive actionOnReceive:@escaping ()->Void)
//    func fetchLuckyPrefecture(onSuccess actionOnSuccess:@escaping ()->Void,onFailure actionOnFailure:@escaping ()->Void)
    func focus(at:InputField?)
    func viewDidDisappear()
}

class InputViewModel<PrefectureModel:PrefectureModelProtocol>:ObservableObject,InputViewModelProtocol{
    
    
    init(prefectureModel:PrefectureModel){
        self.prefectureModel = prefectureModel
        
        //Loading user info from User Defaults
        print("InputViewModel: loading latest userInput from User Defaults:\n\(Defaults[\.userInfo])")
        let userInfo = Defaults[\.userInfo]
        self.name = userInfo.name
        self.birthday = userInfo.birthday.toDate()
        self.bloodType = userInfo.bloodType
        
        
    }
    
    public func viewDidDisappear(){
        print("InputViewModel: saving latest userInput into User Defaults:\n\(input)")
        Defaults[\.userInfo] = input
    }
    
    
    private let prefectureModel:PrefectureModel
    
    @Published  public var name:String = ""
    @Published  public var birthday:Date = Date()
    @Published  public var bloodType:ABOBloodType = .a
    
    public var input:FetchInput{
        FetchInput(name: name,
              birthday: YearMonthDay(from: birthday),
              bloodType: bloodType,today: YearMonthDay(from: Date() ) )
        
    }
    
    @Published public var isTextFieldFocused = false
    @Published public var isBirthdayFocused = false
    @Published public var isBloodTypeFocused = false
    
    public var isFetchButtonDisplayed:Bool{
        (!isTextFieldFocused && !isBirthdayFocused && !isBloodTypeFocused) && input.isValid
    }
    
    public var dateRange: ClosedRange<Date>{
            let calendar = Calendar.current
            let start = calendar.date(byAdding: .year, value: -100, to: Date())!
            let today = Date()
            return start...today
        }
    
    public func fetchLuckyPrefecture(onReceive actionOnReceive:@escaping ()->Void){
       print("InputViewModel: fetch button tapped")

       if input.isValid{
           print("InputViewModel: fetching luckyPrefecture with:\n\(input)")
           
           prefectureModel.fetchLuckyPrefecture(input: input){
               actionOnReceive()
           }onSuccess: { yumemiAPIprefecture in
               self.storeUserInfoIntoCoreData(prefecture: yumemiAPIprefecture.name)
           }onFailure: {
           }
           
       }else{
           print("InputViewModel: input invalid")
       }
   }
    
    // not sure if it is good to have InputViewModel deal with CoreData
    private let viewContext = PersistenceController.shared.container.viewContext
    private func storeUserInfoIntoCoreData(prefecture:String){
        let newHistory = History(context: viewContext)
        newHistory.prefecture = prefecture
        newHistory.name = input.name
        newHistory.birthday = input.birthday.toDate()
        newHistory.bloodType = input.bloodType
        newHistory.fetchedAt = Date()
        
        print("InputViewModel: saving userInfo into Core Data")
        try? viewContext.save()
    }
    
    public func focus(at field:InputField?){
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

