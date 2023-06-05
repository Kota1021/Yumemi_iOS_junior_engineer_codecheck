//
//  SwiftyUserDefaultKeys.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//

import Foundation
import SwiftyUserDefaults
//cf. https://software.small-desk.com/development/2021/01/18/swiftui-color-userdefaults-swiftyuserdefaults/
extension DefaultsKeys {
    var userInfo:DefaultsKey<FetchInput> { .init("userInfo", defaultValue: FetchInput(name: "",
                                                                            birthday: YearMonthDay(year: 2000, month: 1, day: 1),
                                                                            bloodType: .a,
                                                                            today: YearMonthDay(from: Date() ) ) ) }
}
