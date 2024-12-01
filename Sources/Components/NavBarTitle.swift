//
// NavBar.swift
// IgniteSamples
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

import Foundation
import Ignite

/// Displays a global "Social Footer", with each social icon linking to an
/// external site in a new browser tab, demonstrating how to create reusable
/// components with builtIn icons, external links and custom attributes.
public struct NavBarTitle: Component {
    public func body(context: PublishingContext) -> [any PageElement] {
        Group {
            Text {
                "Romain Rabouan"
            }
            .font(.title1)
            Text {
                "Apple Platforms Software Engineer"
            }
            .font(.title2)
        }
        .horizontalAlignment(.center)
        .margin(.top, .extraLarge)
    }
}
