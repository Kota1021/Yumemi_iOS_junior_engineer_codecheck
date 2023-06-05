//
//  InfoView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI
import AudioToolbox

struct DetailView: View {
    @EnvironmentObject var screen:ScreenSize
    let prefecture:Prefecture
    @Binding var isBreafViewExpanded:Bool
    @Binding var isMapExpanded:Bool
    
    var body: some View {
        VStack{
//        VStack(alignment: .leading){
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
                    Spacer()
                    Text("概要：")
                        .padding(.top)
                }
                
                // How to separate iPadOS from iOS with Conditional compilation block ?
                if screen.height < 1000{
                    CollapsedMap(isMapExpanded: $isMapExpanded, url: prefecture.logoUrl)
                }else{
                    
                GeometryReader{ proxy in
                    ExpandedMap(isDisplayed:$isMapExpanded, viewSize:proxy.size, pinLocation:  prefecture.location)
                }
                    
                }
                
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


