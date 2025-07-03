# detectxm
This package provides a way to check if TXM is supported on your Apple device.

> [!NOTE]
> This package returns `false` by default for non-Apple platforms, as this package is mainly meant for use on Apple platforns.

## Example Usage
```swift
import Foundation
import detectxm

print(ProcessInfo.processInfo.hasTXM)
```

## License
MIT, see [`LICENSE`](LICENSE) for details.
