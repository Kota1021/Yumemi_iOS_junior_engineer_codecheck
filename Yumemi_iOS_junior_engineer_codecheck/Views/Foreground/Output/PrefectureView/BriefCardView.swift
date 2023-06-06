//
//  brief.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct BriefCardView: View {
    let text: String

    var body: some View {
        Text(text)
            .textSelection(.enabled)
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .transition(AnyTransition.scale.combined(with: .move(edge: .bottom)))
            .padding()
    }
}

struct BriefView_Previews: PreviewProvider {
    static let text = "aaaaaaaaaaaaa"
    static var previews: some View {
        BriefCardView(text: text)
    }
}
