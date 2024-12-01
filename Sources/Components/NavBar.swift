//
// NavBar.swift
// IgniteSamples
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

import Foundation
import Ignite

/// An example navigation bar, demonstrating how to create reusable components.
struct NavBar: Component {
    func body(context: PublishingContext) -> [any PageElement] {
        NavigationBar(logo: NavigationBarTitle(title: "Romain Rabouan", subtitle: "Apple Platforms Software Engineer")) {
            Link("Download my Resume", target: "resume.pdf")
            Link("Projects", target: "https://www.google.com/")
            Link("Blog", target: BlogPage())
        }
        .navigationItemAlignment(.trailing)
        .navigationBarStyle(.dark)
        .background(.slateGray)
        .position(.fixedTop)
    }
}

struct NavigationBarTitle: InlineElement {
    var attributes: CoreAttributes = Body {
        AnyBaseElement()
    }.attributes

    let title: String
    let subtitle: String

    func render(context: PublishingContext) -> String {
        """
        <div style="text-align: left;">
        <div style="display: block; font-size: 2rem; font-weight: bold;">\(title)</div>
        <div style="display: block; font-size: 1.2rem; font-weight: medium;">\(subtitle)</div>
        </div>
        """
    }
}

struct AnyBaseElement: BaseElement {
    func render(context: PublishingContext) -> String { "" }
}
