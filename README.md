# EasyText

[![CI Status](https://img.shields.io/travis/Nemocdz/EasyText.svg?style=flat)](https://travis-ci.org/Nemocdz/EasyText)
[![Version](https://img.shields.io/cocoapods/v/EasyText.svg?style=flat)](https://cocoapods.org/pods/EasyText)
[![License](https://img.shields.io/cocoapods/l/EasyText.svg?style=flat)](https://cocoapods.org/pods/EasyText)
[![Platform](https://img.shields.io/cocoapods/p/EasyText.svg?style=flat)](https://cocoapods.org/pods/EasyText)

EasyText is library written in Swift, which provide an easy and safe way to create a `NSAttributedString`.It use [`StringInterpolation`](https://github.com/apple/swift-evolution/blob/master/proposals/0228-fix-expressiblebystringinterpolation.md) in Swift 5.

## Features

- [x] Type safe
- [x] Support multiple platfoms, iOS and macOS
- [x] Support most of `NSAttributedString.Key`
- [x] Support usual operators, such as `+`,`+=`
- [x] Support `UIImage`/`NSImage`

## Example

```swift
let text:EasyText = "\("font is 30 pt and color is yellow", .font(.systemFont(ofSize: 20)), .color(.blue))"

textView.attributedText = text.attributedString
```

More examples in Example/iOS.

## Requirements

* iOS 9.0+/macOS 10.11+

* Swift 5.0+

## Installation

### Cocoapods

```ruby
pod 'EasyText','~> 1.0.0'
```

### Carthage

```
github "Nemocdz/EasyText" "1.0.0"
```

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/Nemocdz/EasyText.git", from: "1.0.0")
]
```

## Article

[使用 Swift 5 字符串插值快速构建 AttributeString](https://nemocdz.github.io/post/%E4%BD%BF%E7%94%A8-swift-5-%E5%AD%97%E7%AC%A6%E4%B8%B2%E6%8F%92%E5%80%BC%E7%AE%80%E5%8D%95%E6%9E%84%E5%BB%BA-attributestring/)

## Author

Nemocdz, nemocdz@gmail.com

## License

EasyText is available under the MIT license. See the LICENSE file for more info.
