//
//  brief.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct BriefCardView: View {
    @Binding var isDisplayed:Bool
    let text:String
    let viewSize:CGSize
    
    var body: some View {
        Text(text)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.secondarySystemBackground)))
            .transition(AnyTransition.scale.combined(with:.move(edge: .bottom)))
            .padding()
            .background(
                Rectangle()
                    .frame(width: viewSize.width, height: viewSize.height)
                    .foregroundColor(.clear)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation{
                            isDisplayed = false
                        }
                    }
            )
    }
}

struct BriefView_Previews: PreviewProvider {
    @State static var isDisplayed = true
    static let text = "aaaaaaaaaaaaa"
    static var previews: some View {
        BriefCardView(isDisplayed:$isDisplayed ,text:text,viewSize:CGSize(width: 100, height: 100))
    }
}
