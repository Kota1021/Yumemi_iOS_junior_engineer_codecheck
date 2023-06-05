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



