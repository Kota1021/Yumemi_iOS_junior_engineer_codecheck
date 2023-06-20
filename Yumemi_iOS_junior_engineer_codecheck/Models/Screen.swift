//
//  ScreenSize.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/05.
//

import SwiftUI

final class Screen{
    private init(){}
    static public var size: CGSize {
        get {
            guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene // crashes on preview since connectedScenes is []
//            guard let window = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
            else {
                fatalError("could not get window size: \(UIApplication.shared)")
            }
            return window.screen.bounds.size
        }
    }

}
