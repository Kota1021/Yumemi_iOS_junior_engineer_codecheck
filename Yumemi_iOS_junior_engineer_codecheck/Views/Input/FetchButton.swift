//
//  FetchButton.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/03.
//

import SwiftUI
struct FetchButton: View {
    let action: ()->Void
    var body: some View {
        Button{
            action()
        }label:{
            HStack{
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("See Lucky Prefecture")
            }
        }.buttonStyle(.borderedProminent)
            .compositingGroup()
            .shadow(color: .white ,radius: 8)
    }
}
