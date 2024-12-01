import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() async {
        let site = ExampleSite()

        do {
            try await site.publish()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ExampleSite: Site {
    var name = "Romain Rabouan"
    var titleSuffix = " – Romain Rabouan - Portfolio"
    var url: URL = URL("https://www.yoursite.com")

    var builtInIconsEnabled = true
    var syntaxHighlighters = [SyntaxHighlighter.swift, .python, .ruby]
    var feedConfiguration = FeedConfiguration(mode: .full, contentCount: 20, image: .init(url: "https://www.yoursite.com/images/icon32.png", width: 32, height: 32))
    var robotsConfiguration = Robots()
    var author = "Romain Rabouan"

    var homePage = Home()
    var theme = MyTheme()

    var pages: [any StaticPage] {
        Home()
        BlogPage()
    }

    var layouts: [any ContentPage] {
        Story()
        CustomStory()
    }
}
