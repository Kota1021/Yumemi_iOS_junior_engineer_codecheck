//
//  HistoryCardView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//

import SwiftUI

struct HistoryCardView: View {
    let history:StoredHistory
//    let history:History
    let thumbnailURL:URL
    
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
                    Text(history.prefecture)
                        .font(.largeTitle)
                    Text(history.name)
                    Text(history.stringBirthday )
                    Text(history.bloodType.rawValue)
                    Text(history.stringFetchDate )
                }.padding()
//                VStack(alignment: .leading){
//                    Text(history.prefecture)
//                        .font(.largeTitle)
//                    Text(history.userInput.name)
//                    Text(history.userInput.birthday.toString())
//                    Text(history.userInput.bloodType.rawValue)
//                    Text(history.fetchDateString)
//                }.padding()
                Spacer()
            }.frame(width: width,height: height)
            .background(Color(.secondarySystemBackground) )
            .clipShape(RoundedRectangle(cornerRadius: 8) )
            .padding()
    }
}

//struct HistoryCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryCardView(history: PreviewData.history, thumbnailURL: URL(string: "https://static-cse.canva.com/blob/1064408/1600w-wK95f3XNRaM.jpg")! )
//    }
//}


