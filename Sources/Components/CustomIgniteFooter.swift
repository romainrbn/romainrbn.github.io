//
// NavBar.swift
// IgniteSamples
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

import Foundation
import Ignite

public struct CustomIgniteFooter: Component {
    public init() { }

    public func body(context: PublishingContext) -> [any PageElement] {
        Group {
            Divider()
            Image("swift.png")
                .frame(width: 35, height: 35, alignment: .center)
                .horizontalAlignment(.center)
            Text {
                "This website was built in Swift using "
                Link("Ignite", target: URL("https://github.com/twostraws/Ignite"))
            }
            .foregroundStyle(Color.orangeRed)
            .horizontalAlignment(.center)
        }
        .margin(.top, .extraLarge)
    }
}
