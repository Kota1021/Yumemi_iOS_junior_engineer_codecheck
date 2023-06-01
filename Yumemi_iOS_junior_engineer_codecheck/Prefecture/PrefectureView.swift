//
//  OutputView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI
import AudioToolbox

struct PrefectureView: View {
    
    let prefacture:LuckyPrefecture
    let imagesInfo:[PrefectureImageInfo]
    @State private var isBreafViewExpanded = false
    
    var body: some View {
        GeometryReader{proxy in
            VStack{
                ImagePageView(imagesInfo: imagesInfo, viewSize: proxy.size)
                
                VStack(alignment: .leading){
                    HStack{
                        Text(prefacture.name)
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
                    }.frame(height: 100)
                    
                    HStack(spacing: 0){
                        Text("県庁所在地：　")
                        Text("\(prefacture.capital)")
                    }
                    HStack(spacing: 0){
                        Text("市民の日：　")
                        Text(prefacture.citizenDay?.toString() ?? "なし")
                    }
                    HStack(spacing: 0){
                        Text("海：　")
                        Text(prefacture.hasCoastLine ? "あり":"なし")
                    }
                    Text("概要：")
                        .padding(.top)
                    VStack{
                        Text( prefacture.brief )
                            .truncationMode(.middle)
                        HStack{
                            Spacer()
                            Text("長押しで続きを読む")
                            Image(systemName: "hand.tap.fill")
                        }.foregroundColor(.gray)
                    }
                    .padding()
                    .overlay{
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemGray6))
                    }
                    .onTapGesture {}//this empty .onTapGesture() helps ParentView's ScrollView to work smoothly
                    .onLongPressGesture(minimumDuration: 0.2) {
                        withAnimation{
                            isBreafViewExpanded = true
                        }
                        UIImpactFeedbackGenerator(style: .heavy)
                            .impactOccurred()
                    }
                    .padding(.bottom)
                    
                }.padding(.horizontal)
            }.blur(radius: isBreafViewExpanded ? 10 : 0)
                .overlay{
                    if isBreafViewExpanded{
                        BriefCardView(isDisplayed: $isBreafViewExpanded,
                                      text: prefacture.brief,
                                      viewSize: proxy.size)
                            
                    }
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


