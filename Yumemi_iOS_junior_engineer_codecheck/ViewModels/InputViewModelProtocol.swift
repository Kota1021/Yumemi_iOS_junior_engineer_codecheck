//
//  InputViewModelProtocol.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/06.
//

import Foundation

protocol InputViewModelProtocol: ObservableObject {
    var name: String { get set }
    var birthday: Date { get set }
    var bloodType: ABOBloodType { get set }
    var input: FetchInput { get }

    var isTextFieldFocused: Bool { get set }
    var isBirthdayFocused: Bool { get set }
    var isBloodTypeFocused: Bool { get set }
    var isFetchButtonDisplayed: Bool { get }

    var dateRange: ClosedRange<Date> { get }
    func fetchLuckyPrefecture(onReceive actionOnReceive: @escaping () -> Void)
    func focus(at: InputField?)
    func viewDidDisappear()
}
