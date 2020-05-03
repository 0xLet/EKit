# EKit

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
Test Case '-[EKitTests.EKitTests testAllEmojis]' passed (0.390 seconds).
Test Suite 'EKitTests' passed at 2020-05-03 12:17:09.440.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.390 (0.391) seconds
Test Suite 'EKitTests.xctest' passed at 2020-05-03 12:17:09.440.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.390 (0.391) seconds
Test Suite 'Selected tests' passed at 2020-05-03 12:17:09.440.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.390 (0.392) seconds
Program ended with exit code: 0
```
