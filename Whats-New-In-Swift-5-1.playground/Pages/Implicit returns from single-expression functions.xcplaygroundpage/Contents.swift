/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Implicit returns from single-expression functions

 [SE-0255](https://github.com/apple/swift-evolution/blob/master/proposals/0255-omit-return.md) has removed a small but important inconsistency in the language: single-expression functions that return a value can now remove the `return` keyword and Swift will understand it implicitly.

 In previous versions of Swift, single-line closures that returned a value you could omit the `return` keyword because the only line of code that was there *must* be the one that returned a value. So, these two pieces of code were identical:
*/
let doubled1 = [1, 2, 3].map { $0 * 2 }
let doubled2 = [1, 2, 3].map { return $0 * 2 }
/*:
 In Swift 5.1, this behavior has now been extended to functions as well: if they contain a single expression – effectively a single piece of code that evaluates to a value – then you can leave off the `return` keyword, like this:
*/
func double(_ number: Int) -> Int {
    number * 2
}
/*:
 That will probably cause some people to do a double take at first, but I’m sure it will become second nature over time.

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
