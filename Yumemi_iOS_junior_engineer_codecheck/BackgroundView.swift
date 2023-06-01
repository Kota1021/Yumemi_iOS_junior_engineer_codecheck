//
//  BackgroundView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct BackgroundView: View {
    @Environment(\ .colorScheme)var colorScheme
//    let viewSize:CGSize
    var body: some View {
        GeometryReader{ geo in
            Image(colorScheme == .light ? "4181" : "1583")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
//                .frame(width: viewSize.width, height: viewSize.height)
                .frame(width: geo.size.width, height: geo.size.height)
                .offset(x: colorScheme == .light ? 160 : -250, y: 0)// on iPhone 14 pro
                .overlay{
                    VStack{
                        Text("Lucky Prefecture")
                            .foregroundColor(.white)
                            .fontWeight(.black)
                            .font(.largeTitle)
                            .shadow(radius: 8)
                            .padding(.top, 40)
                        Spacer()
                    }
                }
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
//        GeometryReader{ geo in
            BackgroundView()
//            BackgroundView(viewSize:geo.size)
//        }
    }
}
