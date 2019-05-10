/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Improvements to synthesized memberwise initializers

 [SE-0242](https://github.com/apple/swift-evolution/blob/master/proposals/0242-default-values-memberwise.md) introduces major improvements to one of Swift’s most commonly used features: memberwise initializers for structs.

 In earlier versions of Swift, a memberwise initializer was automatically created to accept parameters matching the properties of a struct, like this:
*/
struct User {
    var name: String
    var loginCount: Int = 0
}

let piper = User(name: "Piper Chapman", loginCount: 0)
/*:
 In Swift 5.1 this has been enhanced so that the memberwise initializer now uses default parameter values for any properties that have them. In the `User` struct we’ve given `loginCount` a default value of 0, which means we can either specify it or leave it to the memberwise initializer:
*/
let gloria = User(name: "Gloria Mendoza", loginCount: 0)
let suzanne = User(name: "Suzanne Warren")
/*:
 This lets us avoid repeating code, which is always welcome.

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
