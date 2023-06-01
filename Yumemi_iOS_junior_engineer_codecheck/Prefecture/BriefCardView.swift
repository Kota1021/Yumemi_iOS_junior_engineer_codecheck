//
//  brief.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct BriefCardView: View {
    let breaf:String
    var body: some View {
        Text(breaf)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.secondarySystemBackground)))
            
    }
}

struct BriefView_Previews: PreviewProvider {
    static let text = "aaaaaaaaaaaaa"
    static var previews: some View {
        BriefCardView(breaf:text)
    }
}
