//
//  BackgroundView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct BackgroundView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        GeometryReader { geo in
            Image(colorScheme == .light ? "TopImageLightMode" : "TopImageDarkMode")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(width: Screen.size.width, height: Screen.size.height)
//                .frame(width: 1024, height: 1366)
//                .frame(width: geo.size.width, height: geo.size.height)
                .overlay {
                    VStack {
                        Text("LuckyPrefecture")
                            .font(.system(size: 100))
                            .minimumScaleFactor(0.1)
                            .lineLimit(2)  //日本語タイトルは2行
                            .multilineTextAlignment(.center)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                            .shadow(radius: 8)
                            .padding()
                            .padding(.top)
                            .padding(.horizontal)
                        Spacer()
                    }
                }
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
