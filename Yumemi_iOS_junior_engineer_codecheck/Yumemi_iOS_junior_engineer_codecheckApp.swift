//
//  Yumemi_iOS_junior_engineer_codecheckApp.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI

@main
struct Yumemi_iOS_junior_engineer_codecheckApp: App {
    let persistenceController = PersistenceController.shared
    @State private var screenSize:CGSize = .zero
    
    var body: some Scene {
        WindowGroup {
            ContentView(prefectureModel: PrefectureModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                //Below setting ScreenSize in environmentObject since UIScreen.main will be deplicated
                .onAppear {
                    guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                        fatalError("could not get window size") }
                    self.screenSize = window.screen.bounds.size
                    print("App: screenSize: \(self.screenSize)")
                    
                }.environmentObject(ScreenSize(size: self.screenSize))
        }
    }
}



class ScreenSize:ObservableObject{
    init(width:CGFloat = .zero, height:CGFloat = .zero){
        self.width = width
        self.height = height
    }
    init(size: CGSize = .zero){
        self.size = size
    }
    
    @Published var width:CGFloat = .zero
    @Published var height:CGFloat = .zero
    public var size:CGSize{
        get{ CGSize(width: width, height: height) }
        set{ width = newValue.width
             height = newValue.height
        }
    }
    
    // Wanna separate iPadOS from iOS, but Conditional Compilation Block doesn't work.
    public var estimatedOS:Plasforms{
        if height < 1000{
            return .iOS
        }else if height < 1500{
            return .iPadOS
        }else{
            return .mac
        }
    }
    
}

enum Plasforms{
    case iOS,iPadOS,mac
}
