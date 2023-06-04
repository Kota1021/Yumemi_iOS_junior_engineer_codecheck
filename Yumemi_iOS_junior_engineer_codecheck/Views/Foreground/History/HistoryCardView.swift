//
//  HistoryCardView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//

import SwiftUI

struct HistoryCardView: View {
//    @EnvironmentObject var screen:ScreenSize
    
    let width:CGFloat = 150
    let height:CGFloat = 150
    
    var body: some View {
        GeometryReader{ geo in
            HStack{
                VStack(alignment: .leading){
                    Text("Prefecture")
                        .font(.largeTitle)
                    Text("Name")
                    Text("Birthday")
                    Text("BloodType")
                    Text("Date")
                }.padding()
                Spacer()
                
                AsyncImage(url: URL(string: "https://find47.jp/ja/i/vqLsw/image_file?type=detail_thumb")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                
            }
                .background(Color(.systemGroupedBackground) )
                .clipShape(RoundedRectangle(
                                cornerRadius: 8,
                                style: .continuous ) )
                .padding()
        }
    }
}

struct HistoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCardView()
            .environmentObject(ScreenSize(size: PreviewData.screenSize))
    }
}
