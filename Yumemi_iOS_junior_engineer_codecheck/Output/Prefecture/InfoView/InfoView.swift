//
//  InfoView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI
import AudioToolbox

struct InfoView: View {
    let prefecture:Prefecture
    @Binding var isBreafViewExpanded:Bool
    @Binding var isMapExpanded:Bool
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(prefecture.name)
                    .fontWeight(.black)
                    .font(.system(size: 60))
                    .shadow(radius: 20)
                    .padding(10)
                
                AsyncImage(url: prefecture.logoUrl){ image in
                    image
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray6))
                        }
                        .onTapGesture {}//this empty .onTapGesture() helps ParentView's ScrollView to work smoothly
                        .onLongPressGesture(minimumDuration: 0.2) {
                            withAnimation{
                                isMapExpanded = true
                            }
                            UIImpactFeedbackGenerator(style: .heavy)
                                .impactOccurred()
                        }
                    
                } placeholder: {
                    ProgressView()
                }
            }.frame(height: 100)
            
            HStack(spacing: 0){
                Text("県庁所在地：　")
                Text("\(prefecture.capital)")
            }
            HStack(spacing: 0){
                Text("市民の日：　")
                Text(prefecture.citizenDay?.toString() ?? "なし")
            }
            HStack(spacing: 0){
                Text("海：　")
                Text(prefecture.hasCoastLine ? "あり":"なし")
            }
            Text("概要：")
                .padding(.top)
            VStack{
                Text( prefecture.brief )
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
            
    }
}


//struct InfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoView()
//    }
//}
