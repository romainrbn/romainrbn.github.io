---
author: Romain Rabouan
description: A study of Morphology in Swift.
date: 2024-12-01 15:30
tags: Localization
published: true
image: /images/photos/localization.png
---
# Localized Strings are powerful

Let's dive in the new Morphology and inflection APIs in Swift.

## How can we have multiple usages of a String with only one Localization Key?

Since iOS 15, Apple gives developers the opportunity to change a localized string depending on the context, without having to use StringsDict.

For example, now you can have:

```swift
"Points: %lld" = "You have ^[%lld [Points]](inflect: true)";
```

This way, the string will adapt depending on the argument passed into %ldd

- %lld = 0 ⇒ You have 0 point
- %lld = 1 ⇒ You have 1 point
- %lld = 2 ⇒ You have 2 point**s**

And the good thing is that it changes automatically with the language. In french, we would have:

- %lld = 0 ⇒ You have 0 point**s** (because the 0 takes a **s** in french)
    
    etc.
    

In case we are not sure that Foundation will detect which word is the name to adapt here, we can easily specify which word is the noun. For example, if we take back the above example:

```swift
"Points: %lld" = "You have ^[%lld [Points](grammar: { partOfSpeech: \"noun\" })](inflect: true)";
```

This solution (compared to usual StringsDict) can be good for small project or developers, but it is only available for Apple Platforms, and so would be hard for us to implement in HealthMate. Moreover, having a syntax inside the .strings file can be a bit messy, and it is available only in French, English and Spanish for now…)

## Morphologies

Apple also introduced a new set of tools in the Foundation framework: Morphologies.

This allows us to use the above syntax even further.

Let’s take an example in Swift:

```swift
func buildPostLikeString() -> AttributedString {
	var string = AttributedString(localized: 
		"^[They liked your post](inflect: true, inflectionAlternative: 'She liked your post')"
	)
	var morphology = Morphology()
	morphology.grammaticalGender = .feminine
	string.inflect = InflectionRule(morphology: morphology)
	return string.inflected()
}
```

As you can see here, we can set an alternative string for the main string, using `inflectionAlternative`

This can be used to change the string depending on the user choice of gender, like shown above. (Apple now asks about your gender of choice when you first start your iPhone).

You can even access the user gender with:

```swift
let userGender = Morphology.user.grammaticalGender
```

and use it in your strings. 🎉
