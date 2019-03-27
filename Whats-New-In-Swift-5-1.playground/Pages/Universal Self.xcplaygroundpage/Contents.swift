/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Universal `Self`

 [SE-0068](https://github.com/apple/swift-evolution/blob/master/proposals/0068-universal-self.md) expands Swift’s use of `Self` so that it refers to the containing type when used inside classes, structs, and enums. This is particularly useful for *dynamic* types, where the exact type of something needs to be determined at runtime.

 As an example, consider this code:
*/
class NetworkManager {
    class var maximumActiveRequests: Int {
        return 4
    }
    
    func printDebugData() {
        print("Maximum network requests: \(NetworkManager.maximumActiveRequests).")
    }
}
/*:
 That declares a static `maximumActiveRequests` property for a network manager, and adds a `printDebugData()` method to print the static property. That works fine right now, but when `NetworkManager` is subclassed things become more complicated:
*/
class ThrottledNetworkManager: NetworkManager {
    override class var maximumActiveRequests: Int {
        return 1
    }
}
/*:
 That subclass changes `maximumActiveRequests` so that it allows only one request at a time, but if we call `printDebugData()` it will print out the value from its parent class:
*/
let manager = ThrottledNetworkManager()
manager.printDebugData()
/*:
 That *should* print out 1 rather than 4, and that’s where SE-0068 comes in: we can now write `Self` (with a capital S) to refer to the current type. So, we can rewrite `printDebugData()` to this:
*/
class ImprovedNetworkManager {
    class var maximumActiveRequests: Int {
        return 4
    }

    func printDebugData() {
        print("Maximum network requests: \(Self.maximumActiveRequests).")
    }
}
/*:
 This means `Self` works the same way as it did for protocols in earlier Swift versions.

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
