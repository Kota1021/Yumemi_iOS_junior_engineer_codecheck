//
//  ContentView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//


import SwiftUI
import CoreData
import Alamofire
import Combine

struct ContentView<PrefectureModel:PrefectureModelProtocol>:View{
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var prefectureModel: PrefectureModel
    @EnvironmentObject var screen:ScreenSize
    
    @State private var displayOutputViewFlag = false
//    @State private var saveUserInputFlag = false
//    @State private var userInputToSave = UserInput(name: "", birthday: YearMonthDay(from: Date()), bloodType: .a, today: YearMonthDay(from: Date()))
    @State private var displayedPage = Pages.input
    
    
    var body: some View {
        //MaximumVerticalPageView fills the screen, ignoring the safe area.
        MaximumVerticalPageView(selection: $displayedPage){
            
            InputView(viewModel: InputViewModel(prefectureModel: prefectureModel),
                      shouldShowOutput: $displayOutputViewFlag)
            
//            InputView(viewModel: InputViewModel(prefectureModel: prefectureModel),
//
//                      shouldShowOutput: $displayOutputViewFlag,
//                      shouldSaveUserInput: $saveUserInputFlag,
//                      userInputToSave: $userInputToSave)
                .tag(Pages.input)
            
            Group{
                if let prefecture = self.prefectureModel.prefecture{
                    PrefectureView(prefacture: prefecture)
                }else if let error = self.prefectureModel.error{
                    ErrorView(error: error)
                }
                
            }.tag(Pages.output)
            
            HistoryView(size:screen.size,shouldShowOutput: $displayOutputViewFlag, prefectureModel: prefectureModel)
                .tag(Pages.history)
            
            LicenseView(size:screen.size)
                .tag(Pages.license)
            
        }
        .background(BackgroundView() )
        .onReceive(Just(displayOutputViewFlag)) { shouldShow in
            print("ContentView: displayOutputViewFlag sent \(shouldShow)")
            print("ContentView: self.prefectureModel.prefecture\n\(self.prefectureModel.prefecture )\n")
            
            if shouldShow{
                Task(priority: .background) {
                    try await Task.sleep(nanoseconds: UInt64(0.3 * 1_000_000_000) )
                    Task{ @MainActor in
                        withAnimation{ displayedPage = .output }
                    }
                }
            }
            
        }
//        .onReceive(Just(saveUserInputFlag)) { shouldSave in
//            print("ContentView: saveUserInputFlag sent: \(shouldSave)\n")
//            if shouldSave{
//                //この辺に保存の処理
//                let newUserInput = SavedUserInput(context: viewContext)
//                newUserInput.name = userInputToSave.name
//                newUserInput.birthday = userInputToSave.birthday.toDate()
//                newUserInput.bloodType = userInputToSave.bloodType
//                newUserInput.fetchedAt = userInputToSave.today.toDate()
//                
//                try? viewContext.save()
//                
//                print("ContentView: userInput saved to CoreData:\n\(userInputToSave)\n")
//            }
//            
//        }
    }
    
    private enum Pages{
        case input, output, history, license
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(PreviewData.devices) { device in
            ContentView<PrefectureModel>(prefectureModel: PrefectureModel())
                .environmentObject(ScreenSize(size: PreviewData.screenSize))
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                .previewDevice(PreviewDevice(rawValue: device.name))
                .previewDisplayName(device.previewTitle)
        }
        
    }
}
