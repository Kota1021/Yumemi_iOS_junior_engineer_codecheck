//
//  ImagePageView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/01.
//

import SwiftUI

struct ImagePageView: View {
    let imagesInfo:[PrefectureImageInfo]
    let viewSize:CGSize
    var body: some View {
        TabView{
            ForEach(imagesInfo){ imageInfo in
                VStack{
                    AsyncImage(url: imageInfo.url){ image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: viewSize.width, height: 300)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(width: viewSize.width, height: 300)
                    }
                    
                    HStack{
                        Text("\"\(imageInfo.title)\" © \(imageInfo.author) \n(Licensed under CC BY 4.0)")
                        Spacer()
                    }.padding()
                }
            }
        }.tabViewStyle(.page)
            .frame(height: 450)
    }
}

//struct ImagePageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagePageView()
//    }
//}
