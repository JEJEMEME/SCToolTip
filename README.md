
# SCToolTipView: Simple SwiftUI custom tooltip.
# Overview

A library that provides tooltip screens that can be used with SwiftUI View.

# Features
- You can customize the text in the tooltip.
- The size of the tooltip is calculated to fit the text length and height.
- You can change the direction of the tooltip's speech bubble.
Top: Left, Center, Right
Center: Left, Center, Right
Bottom: Left, Center, Right
- You can enable the Cancel button.
- Contains a closure that can receive touch actions.

# Requirements
iOS 15.0 or later
Swift 5.5 or later
Xcode 14.0 or later
# Usage
```swift
import SCToolTip

struct ContentView: View {
    var body: some View {
        SCToolTipView(description: "Hello World",
                      arrowAlignment: .TopLeft,
                      showCancelButton: false, onTapGesture: { /* Some Action */ })
    }
}

```
# Installation

The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler. It is in early development, but this SDK does support its use on supported platforms.

Once you have your Swift package set up, adding the SDK as a dependency is as easy as adding it to the dependencies value of your Package.swift.

```swift
dependencies: [
    .package(url: "https://github.com/JEJEMEME/SCToolTip.git")
]
```
or File -> Add Packages... -> Search https://github.com/JEJEMEME/SCToolTip.git -> Install
                                        

# Contribution
Contributions are welcome! If you'd like to improve SCToolTipView, please feel free to fork the repository, make changes, and submit a pull request.

# License
SCToolTipView is available under the MIT license. See the LICENSE file for more info.

# Acknowledgements
Created by JEJEMEME, a passionate Swift developer and open-source contributor.
