//
//  ViewForResearch.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI
import Alamofire

struct ViewForResearch: View {
    @State private var output: Result<LuckyPrefacture, AFError>? = nil
    var body: some View {
        ZStack{
            Image("4181")
                .resizable()
                .scaledToFill()
                .offset(x: 160, y: 0)//iPhone 14 Proの場合
                .overlay{
                    VStack{
                        Text("Lucky Prefecture")
                            .foregroundColor(.white)
                            .fontWeight(.black)
                            .font(.largeTitle)
                            .shadow(radius: 5)
                            .padding(.top, 80)
                        Spacer()
                    }
                }
            
                InputView(output: $output)
                    .background(
                        Color("Background")
                            .opacity(0.8)
                    )
//                    .border(.pink)
        }
    }
}

struct ViewForResearch_Previews: PreviewProvider {
    static var previews: some View {
        ViewForResearch()
    }
}
