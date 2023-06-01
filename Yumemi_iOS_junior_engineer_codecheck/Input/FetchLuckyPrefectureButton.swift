////
////  FetchLuckyPrefectureButton.swift
////  Yumemi_iOS_junior_engineer_codecheck
////
////  Created by 松本幸太郎 on 2023/06/01.
////
//
//import SwiftUI
//
//struct FetchLuckyPrefectureButton: View {
//    @Binding var fetchLuckyPrefectureButtonTapped:Bool
//    var body: some View {
//        Button{
//            print("fetch button tapped")
//            let birthday = YearMonthDay(from: self.birthday)
//            let today = YearMonthDay(from: Date() )
//            
//            let input = FortuneInput(name: self.name,
//                                     birthday: birthday,
//                                     bloodType: self.bloodType,
//                                     today: today)
//            print("input: \(input)")
//            Task{
//                output = await fetchLuckyPrefecture(input: input)
//            }
//        }label:{
//            Image(systemName: "paperplane.fill")
//                .resizable()
//                .frame(width: 50, height: 50)
//            
//        }.buttonStyle(.borderedProminent)
//            .compositingGroup()
//            .shadow(color: .white ,radius: 8)
//    }
//}
//
//struct FetchLuckyPrefectureButton_Previews: PreviewProvider {
//    static var previews: some View {
//        FetchLuckyPrefectureButton()
//    }
//}
