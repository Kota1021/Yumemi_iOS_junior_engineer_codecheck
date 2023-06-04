//
//  InputFormView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct InputForm<Content:View>: View {
    
    let content:()-> Content
    let title:String
    
//    init(_ title:String,@ViewBuilder content: @escaping () -> Content) {
//        self.title = title
//        self.content = content
//    }
    
    init(_ titleKey:String.LocalizationValue,@ViewBuilder content: @escaping () -> Content) {
        self.title = String(localized: titleKey)
        self.content = content
    }
    
    var body: some View {
        HStack{
            Text(title)
            Spacer()
            content()
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .compositingGroup()
        .padding(.bottom)
        .padding(.horizontal)
    }
}

struct InputFormView_Previews: PreviewProvider {
    static var previews: some View {
        InputForm("hello"){
            Text("hi")
        }
    }
}
