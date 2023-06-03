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
//    @ObservedObject var screenSize = ScreenSize()
    @State private var screenSize:CGSize = .zero

    var body: some Scene {
        WindowGroup {
            ContentView(prefectureModel: PrefectureModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                        fatalError("could not get window size") }
//                    self.screenSize.size = UIScreen.main.bounds.size
                    self.screenSize = window.screen.bounds.size
                    print("screenSize: \(self.screenSize)")
                }
                .environmentObject(ScreenSize(size: self.screenSize))
//                .environmentObject(screenSize)
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
}
