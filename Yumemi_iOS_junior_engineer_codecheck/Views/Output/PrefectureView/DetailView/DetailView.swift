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
                        .font(.system(size: 60))
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
                
                AsyncImage(url: prefecture.logoUrl){ image in
                    VStack{
                        image
                            .resizable()
                            .scaledToFit()
                        HStack{
                            Spacer()
                            Text("位置を表示")
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
                                isMapExpanded = true
                            }
                            UIImpactFeedbackGenerator(style: .heavy)
                                .impactOccurred()
                        }
                    
                } placeholder: {
                    ProgressView()
                }.layoutPriority(-1)
            }
            
            
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
            .onLongPressGesture(minimumDuration: 0.1) {
                withAnimation{
                    isBreafViewExpanded = true
                }
                UIImpactFeedbackGenerator(style: .heavy)
                    .impactOccurred()
            }
    
        }.padding(.horizontal)
        
    }
}


struct InfoView_Previews: PreviewProvider {
    @State static var isDetailDisplayed = false
    @State static var isMapDisplayed = false
    
    static var previews: some View {
        DetailView(prefecture: PreviewData.prefecture, isBreafViewExpanded: $isDetailDisplayed, isMapExpanded: $isMapDisplayed)
    }
}

//cf. https://www.objc.io/blog/2020/03/05/swiftui-alignment-guides/
struct CustomAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        return context[.leading]
    }
}

extension HorizontalAlignment {
    static let custom: HorizontalAlignment = HorizontalAlignment(CustomAlignment.self)
}
