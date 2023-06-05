//
//  BackgroundView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct BackgroundView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var screen: ScreenSize

    var body: some View {
        GeometryReader { geo in
            Image(colorScheme == .light ? "TopImageLightMode" : "TopImageDarkMode")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(width: screen.width, height: screen.height)
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
            .environmentObject(ScreenSize(size: PreviewData.screenSize))
    }
}
