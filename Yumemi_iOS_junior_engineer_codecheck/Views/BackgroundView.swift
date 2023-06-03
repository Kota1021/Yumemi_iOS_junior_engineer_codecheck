//
//  BackgroundView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct BackgroundView: View {
    @Environment(\ .colorScheme)var colorScheme
    @EnvironmentObject var screen:ScreenSize
    
    
    var body: some View {
        GeometryReader{ geo in
            Image(colorScheme == .light ? "TopImageLightMode" : "TopImageDarkMode")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(width: screen.width, height: screen.height)
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
            BackgroundView()
            .environmentObject(ScreenSize(size: PreviewData.screenSize))
    }
}
