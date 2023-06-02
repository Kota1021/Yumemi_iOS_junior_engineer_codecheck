//
//  GlowBorder.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by Samuel Doe
//  from.  https://www.youtube.com/watch?v=MJLoKS1i1oQ


import SwiftUI
struct GlowBorder: ViewModifier {
    var color: Color
    var lineWidth: Int
    func body(content: Content) -> some View {
        var newContent = AnyView(content)
        for _ in 0..<lineWidth {
            newContent = AnyView(newContent.shadow(color: color, radius: 1))
        }
        return newContent
    }
}

extension View{
    func glowBorder(color:Color, lineWidth: Int) -> some View{
        self.modifier(GlowBorder(color: color, lineWidth: lineWidth))
    }
}
