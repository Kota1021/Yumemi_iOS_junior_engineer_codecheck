//
//  ViewForResearch.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import SwiftUI
import Alamofire

struct ViewForResearch: View {
    @State private var output: Result<LuckyPrefacture, AFError>? = nil
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image("4181")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .offset(x: 160, y: 0)//iPhone 14 Proの場合
                    .overlay{
                        VStack{
                            Text("Lucky Prefecture")
                                .foregroundColor(.white)
                                .fontWeight(.black)
                                .font(.largeTitle)
                                .shadow(radius: 5)
                                .padding(.top, 40)
                            Spacer()
                        }
                    }
                
                VStack{
                    Spacer()
                    Group{
                        HStack{
                            Text("name")
                                .padding()
                            Spacer()
                        }
                        HStack{
                            Text("birthday")
                                .padding()
                            Spacer()
                        }
                        HStack{
                            Text("blood type")
                                .padding()
                            Spacer()
                        }
                        //                    InputView(output: $output)
                    }.background(Color("Background") )
                        .padding(.horizontal)
                }
            }
        }
        
    }
}

struct ViewForResearch_Previews: PreviewProvider {
    static var previews: some View {
        ViewForResearch()
    }
}
