//
//  OutputView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI

struct PrefectureView: View {
    
    let prefacture:LuckyPrefecture
    let imagesInfo:[PrefectureImageInfo]
    var body: some View {
        GeometryReader{proxy in
            VStack{
                TabView{
                    ForEach(0..<3){index in
                        VStack{
                            AsyncImage(url: URL(string: imagesInfo[index].urlImage)){ image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: proxy.size.width,height: 300)
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                            }
                                
                            HStack{
                                Text("\"\(imagesInfo[index].title)\" © \(imagesInfo[index].author) \n(Licensed under CC BY 4.0)")
                                Spacer()
                            }.padding()
                        }
                    }
                }.tabViewStyle(.page)
                    .frame(height: 450)
          
                VStack{
                    HStack{
                        Text(prefacture.name)
                        //                        .foregroundColor(.white)
                            .fontWeight(.black)
                            .font(.system(size: 60))
                            .shadow(radius: 20)
                            .padding(10)
                        
                        AsyncImage(url: prefacture.logoUrl){ image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
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
    
     static var luckyPrefecture = LuckyPrefecture(name: "徳島県", brief: "徳島県（とくしまけん）は、日本の四国地方に位置する県。県庁所在地は徳島市。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』", capital: "徳島市", citizenDay: nil, hasCoastLine: true, logoUrl: URL(string: "https://japan-map.com/wp-content/uploads/tokushima.png")!)
    
    static private var luckyPrefectureImageInfoSets:[PrefectureImageInfo]?{
        let prefCode = prefectureCode(from: luckyPrefecture.name)
        guard let prefCode = prefCode else{
            print("prefCode nil. prefecture: \(luckyPrefecture)")
            return nil }
       return  PrefectureImageInfoSets().infoSets(of: prefCode)
    }
    
    static var previews: some View {
        PrefectureView(prefacture:luckyPrefecture, imagesInfo: luckyPrefectureImageInfoSets!)
    }
}