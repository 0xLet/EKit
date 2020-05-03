# EKit

<img src="logo.png" width="256">

## E.emoji

[All Emojis](emojis.md) generated with [emoji list](https://unicode.org/Public/emoji/12.0/emoji-test.txt)

### Example Usage

```swift
// Without EKit
// let japanFlag = "\u{1F1EF}\u{1F1F5}"

// With EKit
let japanFlag = E.flag_japan.rawValue

print(japanFlag) // Output: 🇯🇵
```

### Last Run
```
Test Case '-[EKitTests.EKitTests testLoadAllFullQualifiedEmojis]' passed (0.187 seconds).
Test Suite 'EKitTests' passed at 2020-05-03 15:02:17.863.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.367 (0.367) seconds
Test Suite 'EKitPackageTests.xctest' passed at 2020-05-03 15:02:17.864.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.367 (0.368) seconds
Test Suite 'All tests' passed at 2020-05-03 15:02:17.864.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.367 (0.368) seconds
```
