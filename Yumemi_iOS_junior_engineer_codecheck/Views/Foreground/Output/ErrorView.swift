//
//  ErrorView.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import Alamofire
import SwiftUI

struct ErrorView: View {
    let error: Error
    var body: some View {
        Text(
            "Error occored while fetching a lucky prefecture.\nPlease contact to the developper.\nContact:松本幸太郎#####"
        )
        Text(error.localizedDescription)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var error = AFError.createURLRequestFailed(error: MyError.someError)
    enum MyError: Error {
        case someError
    }

    static var previews: some View {
        ErrorView(error: error)
    }

}

extension AFError: Equatable {
    public static func == (lhs: Alamofire.AFError, rhs: Alamofire.AFError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
}
