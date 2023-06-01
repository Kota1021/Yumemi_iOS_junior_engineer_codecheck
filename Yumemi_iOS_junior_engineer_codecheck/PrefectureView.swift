//
//  OutputView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI

struct PrefectureView: View {
    
    let prefacture:LuckyPrefacture
    
    var body: some View {
        GeometryReader{proxy in
            VStack{
                TabView{
                    Image("35")
                        .resizable()
                        .scaledToFill()
                    
                    Image("92")
                        .resizable()
                        .scaledToFill()
                    Image("923")
                        .resizable()
                        .scaledToFill()
                }.tabViewStyle(.page)
                    .frame(width: proxy.size.width,height: 300)
                    .clipped()
          
                VStack{
                    HStack{
                        Text(prefacture.name)
                        //                        .foregroundColor(.white)
                            .fontWeight(.black)
                            .font(.system(size: 60))
                            .shadow(radius: 20)
                            .padding(10)
                        //                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8)
                        //                        )
                        
                        AsyncImage(url: prefacture.logoUrl){ image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }//.shadow(color: .white, radius: 8)
                        Spacer()
                    }.frame(height: 100)
                    HStack(spacing: 0){
                        Text("県庁所在地：　")
                        Text("\(prefacture.capital)")
                        Spacer()
                    }
                    HStack(spacing: 0){
                        Text("市民の日：　")
                        Text(prefacture.citizenDay?.toString() ?? "なし")
                        Spacer()
                    }
                    HStack(spacing: 0){
                        Text("海：　")
                        Text(prefacture.hasCoastLine ? "あり":"なし")
                        Spacer()
                    }
                    HStack(spacing: 0){
                        Text("概要：　" + prefacture.brief)
                        Spacer()
                    }
                }.padding(.horizontal)
            }
        }
        .background(.ultraThinMaterial)
    }
}

struct OutputView_Previews: PreviewProvider {
    
     static var luckeyPrefacture = LuckyPrefacture(name: "徳島県", brief: "徳島県（とくしまけん）は、日本の四国地方に位置する県。県庁所在地は徳島市。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』", capital: "徳島市", citizenDay: nil, hasCoastLine: true, logoUrl: URL(string: "https://japan-map.com/wp-content/uploads/tokushima.png")!)
    
    static var previews: some View {
        PrefectureView(prefacture:luckeyPrefacture)
    }
}
