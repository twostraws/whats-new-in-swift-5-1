/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Warnings for ambiguous `none` cases

 Swift’s optionals are implemented as an enum of two cases: `some` and `none`. This gave rise to the possibility of confusion if we created our own enums that had a `none` case, then wrapped that inside an optional.

 For example:
*/
enum BorderStyle {
    case none
    case solid(thickness: Int)
}
/*:
 Used as a non-optional this was always clear:
*/
let border1: BorderStyle = .none
print(border1)
/*:
 That will print “none”. But if we used an optional for that enum – if we didn’t know what border style to use – then we’d hit problems:
*/
let border2: BorderStyle? = .none
print(border2)
/*:
 That prints “nil”, because Swift assumes `.none` means the optional is empty, rather than an optional with the value `BorderStyle.none`.

 In Swift 5.1 this confusion now prints a warning: “Assuming you mean 'Optional<BorderStyle>.none'; did you mean 'BorderStyle.none' instead?” This avoids the source compatibility breakage of an error, but at least informs developers that their code might not quite mean what they thought.

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
