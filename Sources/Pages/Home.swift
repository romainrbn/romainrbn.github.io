//
// Home.swift
// IgniteSamples
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Home"

    func body(context: PublishingContext) async -> [BlockElement] {
        Text("👋 Hey, I'm Romain, a Software Engineer and Apple Platforms enthusiast based in Paris, France. 🇫🇷")
            .font(.title2)

        Text("🩺 I'm currently working at Withings, the leader in connected health devices.")
            .font(.lead)

        Group {
            Link(
                "Download my Resume",
                target: "resume.pdf"
            )
            .linkStyle(.button)
            .role(.primary)

            Link("Contact me", target: "mailto:romain.rabouan1@gmail.com")
                .linkStyle(.button)
                .role(.success)
                .margin()
        }

        Group {
            Text("Latest Blog Posts")
                .font(.title2)
                .margin(.top, .extraLarge)

            Link("See All", target: BlogPage())
                .linkStyle(.button)
                .role(.info)
        }
        .margin(.bottom, .large)

        Section {
            for content in Array(context.allContent.prefix(3)) {
                ContentPreview(for: content)
                    .width(3)
                    .margin(.bottom)
            }
        }
        .margin(.bottom, .extraLarge)

        Group {
            CustomIgniteFooter()
        }
    }
}

extension PageElement {
    /// Applies a border to all sides of this element.
    /// - Parameters:
    ///   - width: The width of the border (default is "1px").
    ///   - color: The color of the border (default is "black").
    ///   - style: The style of the border (e.g., "solid", "dashed"). Defaults to "solid".
    /// - Returns: A copy of the current element with the border applied.
    public func border(width: String = "1px", color: String = "black", style: String = "solid") -> Self {
        return self.style("border: \(width) \(style) \(color)")
    }

    /// Applies a border to specific sides of this element.
    /// - Parameters:
    ///   - edges: The edges where the border should be applied.
    ///   - width: The width of the border (default is "1px").
    ///   - color: The color of the border (default is "black").
    ///   - style: The style of the border (e.g., "solid", "dashed"). Defaults to "solid".
    /// - Returns: A copy of the current element with the border applied to the specified edges.
    public func border(_ edges: Edge, width: String = "1px", color: String = "black", style: String = "solid") -> Self {
        var copy = self

        if edges.contains(.all) {
            return copy.style("border: \(width) \(style) \(color)")
        }

        if edges.contains(.leading) {
            copy = copy.style("border-left: \(width) \(style) \(color)")
        }

        if edges.contains(.trailing) {
            copy = copy.style("border-right: \(width) \(style) \(color)")
        }

        if edges.contains(.top) {
            copy = copy.style("border-top: \(width) \(style) \(color)")
        }

        if edges.contains(.bottom) {
            copy = copy.style("border-bottom: \(width) \(style) \(color)")
        }

        return copy
    }
}
