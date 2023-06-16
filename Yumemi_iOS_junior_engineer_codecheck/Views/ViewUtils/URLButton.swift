//
//  URLButton.swift
//  Yumemi_iOS_junior_engineer_codecheck
//
//  Created by 松本幸太郎 on 2023/06/04.
//

import SwiftUI

struct URLButton<Label>: View where Label: View {
    let url: URL
    var label: Label

    init(_ url: URL, @ViewBuilder label: () -> Label) {
        self.url = url
        self.label = label()
    }

    var body: some View {
        Button {
            UIApplication.shared.open(
                url,
                options: [.universalLinksOnly: false],
                completionHandler: { completed in
                    print("URLButton: \(completed.description)")
                })
        } label: {
            label
        }

    }
}

extension URLButton where Label == Text {
    init(_ url: URL, title: String.LocalizationValue) {
        self.url = url
        self.label = Text(String(localized: title))
    }

    init(_ title: String.LocalizationValue, url: URL) {
        self.url = url
        self.label = Text(String(localized: title))
    }
}

struct URLButton_Previews: PreviewProvider {
    static var previews: some View {
        URLButton("Github", url: URL(string: "https://github.com")!)
    }
}
