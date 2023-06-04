//
//  InfoView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI
import AudioToolbox

struct DetailView: View {
    let prefecture:Prefecture
    @Binding var isBreafViewExpanded:Bool
    @Binding var isMapExpanded:Bool
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    
                    Text(prefecture.name)
                        .fontWeight(.black)
                        .font(.system(size: 55))
                        .shadow(radius: 20)
                        .padding(10)
                    
                    VStack(alignment: .custom){
                        HStack(spacing: 0){
                            Text("県庁所在地：　")
                                .alignmentGuide(.custom) { $0[.trailing] }
                            Text("\(prefecture.capital)")
                        }
                        HStack(spacing: 0){
                            Text("市民の日：　")
                                .alignmentGuide(.custom) { $0[.trailing] }
                            Text(prefecture.citizenDay?.toString() ?? "なし")
                        }
                        HStack(spacing: 0){
                            Text("海：　")
                                .alignmentGuide(.custom) { $0[.trailing] }
                            Text(prefecture.hasCoastLine ? "あり":"なし")
                        }
                    }
                    
                    Text("概要：")
                        .padding(.top)
                }
                
                Button{
                    withAnimation{ isMapExpanded = true }
                    
                }label: {
                    AsyncImage(url: prefecture.logoUrl){ image in
                        VStack{
                            image
                                .resizable()
                                .scaledToFit()
                            HStack{
                                Spacer()
                                Text("位置を確認")
                                    .lineLimit(1)
                                Image(systemName: "hand.tap.fill")
                            }.foregroundColor(.gray)
                        }
                        .padding()
                    } placeholder: {
                        ProgressView()
                    }
                }.layoutPriority(-1)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
                Button{
                withAnimation{ isBreafViewExpanded = true }
                
            }label:{
                VStack{
                    Text( prefecture.brief )
                    HStack{
                        Spacer()
                        Text("続きを読む")
                            .lineLimit(1)
                        Image(systemName: "hand.tap.fill")
                    }.foregroundColor(.gray)
                }.padding()
            }.buttonStyle(.plain)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
        }.padding(.horizontal)
            .padding(.bottom)
    }
}


struct InfoView_Previews: PreviewProvider {
    @State static var isDetailDisplayed = false
    @State static var isMapDisplayed = false
    
    static var previews: some View {
        DetailView(prefecture: PreviewData.prefecture, isBreafViewExpanded: $isDetailDisplayed, isMapExpanded: $isMapDisplayed)
    }
}

