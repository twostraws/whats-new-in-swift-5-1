/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Ordered collection diffing

 [SE-0240](https://github.com/apple/swift-evolution/blob/master/proposals/0240-ordered-collection-diffing.md) introduces the ability to calculate and apply the differences between ordered collections. This could prove particularly interesting for developers who have complex collections in table views, where they want to add and remove lots of items smoothly using animations.

 The basic principle is straightforward: Swift 5.1 gives us a new `difference(from:)` method that calculates the differences between two ordered collections – what items to remove and what items to insert. This can be used with any ordered collection that contains `Equatable` elements.

 To demonstrate this, we can create an array of scores, calculate the difference from one to the other, then loop over those differences and apply each one to make our two collections the same.

 **Note:** Because Swift now ships inside Apple’s operating systems, new features like this one must be used with an `#available` check to make sure the code is being run on an OS that includes the new functionality. For features that will land in an unknown, unannounced operating system shipping at some point in the future, a special version number of “9999” is used to mean “we don’t know what the actual number is just yet.”

 Here’s the code:
*/
var scores1 = [100, 91, 95, 98, 100]
let scores2 = [100, 98, 95, 91, 100]

if #available(iOS 9999, *) {
    let diff = scores2.difference(from: scores1)
    
    for change in diff {
        switch change {
        case .remove(let offset, _, _):
            scores1.remove(at: offset)
        case .insert(let offset, let element, _):
            scores1.insert(element, at: offset)
        }
    }

    print(scores1)
}
/*:
 For more advanced animations, you can use the third value of the changes: `associatedWith`. So, rather than using `.insert(let offset, let element, _)` above you might write `.insert(let offset, let element, let associatedWith)` instead. This lets you track pairs of changes at the same time: moving an item two places down in your collection is a removal then an insertion, but the `associatedWith` value ties those two changes together so you treat it as a move instead.

 Rather than applying changes by hand, you can apply the whole collection using a new `applying()` method, like this:
*/
if #available(iOS 9999, *) {
    let diff = scores2.difference(from: scores1)
    let result = scores1.applying(diff) ?? []
}
/*:
 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
