//
//  HistoryCardView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//

import SwiftUI

struct HistoryCardView: View {
    let thumbnailURL:URL
    let prefecture: String
    let name: String
    let birthday: String
    let bloodType: String
    let fetchDate: String
    
    let width:CGFloat = 200
    let height:CGFloat = 300
    
    let imageWidth:CGFloat = 200
    let imageHeight:CGFloat = 150
    
    var body: some View {
            VStack{
                AsyncImage(url: thumbnailURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
            .frame(width: imageWidth, height: imageHeight)
                
                VStack(alignment: .leading){
                    Text(prefecture)
                        .font(.largeTitle)
                    Text(name)
                    Text(birthday)
                    Text(bloodType)
                    Text(fetchDate)
                }.padding()
                Spacer()
            }.frame(width: width,height: height)
            .background(Color(.secondarySystemBackground) )
            .clipShape(RoundedRectangle(cornerRadius: 8) )
            .padding()
    }
}




struct Previews_HistoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCardView(thumbnailURL: URL(string: "https://images.unsplash.com/photo-1598439210625-5067c578f3f6")!, prefecture: "prefecture", name: "name", birthday: "yyyyMMdd", bloodType: "a", fetchDate: "yyyyMMdd")
    }
}
