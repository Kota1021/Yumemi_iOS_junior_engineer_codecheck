//
//  ForeachTestView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/06.
//

import SwiftUI

struct ForeachTestView: View {
    var body: some View {
        Button("tap") {
            print("tapped")
        }.keyboardShortcut(.return, modifiers: [])
    }
}

struct ForeachTestView_Previews: PreviewProvider {
    static var previews: some View {
        ForeachTestView()
    }
}
