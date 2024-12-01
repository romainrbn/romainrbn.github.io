//
//  Blog.swift
//  IgniteSamples
//
//  Created by Romain Rabouan on 01/12/2024.
//

import Foundation
import Ignite

struct BlogPage: StaticPage {
    var title = "Blog"

    func body(context: PublishingContext) async -> [BlockElement] {
        Text("Blog")
            .font(.title1)

        Section {
            for content in context.allContent {
                ContentPreview(for: content)
                    .width(3)
                    .margin(.bottom)
            }
        }
        .margin(.bottom, .extraLarge)
    }
}
