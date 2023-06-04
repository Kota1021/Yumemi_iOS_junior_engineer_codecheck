//
//  HistoryCardView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//

import SwiftUI

struct HistoryCardView: View {
    let width:CGFloat = 200
    let height:CGFloat = 300
    
    let imageWidth:CGFloat = 200
    let imageHeight:CGFloat = 150
    
    var body: some View {
            VStack{
                AsyncImage(url: URL(string: "https://find47.jp/ja/i/vqLsw/image_file?type=detail_thumb")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
            .frame(width: imageWidth, height: imageHeight)
                
                VStack(alignment: .leading){
                    Text("Prefecture")
                        .font(.largeTitle)
                    Text("Name")
                    Text("Birthday")
                    Text("BloodType")
                    Text("Date")
                }.padding()
                Spacer()
            }.frame(width: width,height: height)
            .background(Color(.secondarySystemBackground) )
            .clipShape(RoundedRectangle(cornerRadius: 8) )
            .padding()
    }
}

struct HistoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCardView()
    }
}
