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
    private var imageHeight:CGFloat{ viewSize.height * 4/5}
    private var reflectionHeight:CGFloat{ viewSize.height - imageHeight }
    private let blurRadius:CGFloat = 3
    
    var body: some View {
        TabView{
            ForEach(imagesInfo){ imageInfo in
                
                AsyncImage(url: imageInfo.url){ image in
                    VStack(spacing: 0){
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: viewSize.width, height: imageHeight)
                            .clipped()
                        
                        //reflected image
                        image
                            .resizable()
                            .scaledToFill()
                        /// 1. First, make the image wider/taller by blurRadius*2, because .blur modifier mixes border's color with the backgroud. and i dont want it happen.
                            .frame(width: viewSize.width + blurRadius*2, height: imageHeight + blurRadius*2)
                            .clipped()
                            //reflection effects
                            .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0) )
                            .blur(radius: blurRadius)
                        ///2. And then returns back to wanted size.
                            .frame(width: viewSize.width , height: reflectionHeight)
                            .offset(y: (imageHeight/2 - reflectionHeight/2))
                            .clipped()
                    }
                } placeholder: {
                    ProgressView()
                        .frame(width: viewSize.width, height: viewSize.height)
                }
                .overlay{
                    VStack(alignment: .leading,spacing: 0){
                        Spacer()
                            .frame(width: viewSize.width, height: imageHeight)
                        
                        Text("\"\(imageInfo.title)\" © \(imageInfo.author)")
                                .fontWeight(.bold)
                                .glowBorder(color: Color(.systemBackground), lineWidth: 3)
                                .padding(.top)
                                .padding(.leading)
                         
                        Text("(Licensed under CC BY 4.0)")
                            .glowBorder(color: Color(.systemBackground), lineWidth: 3)
                            .padding(.leading)
                        Spacer()
                        
                    }
                    .frame(height: viewSize.height)
                    
                }
                
            }
        }
        .tabViewStyle(.page)
        .frame(height: viewSize.height)
    }
}

struct ImagePageView_Previews: PreviewProvider {
    
    static var previews: some View {
        ImagePageView(imagesInfo: PreviewData.prefecture.images, viewSize: PreviewData.screenSize)
    }
}
