/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Matching optional enums against non-optionals

 Swift has always been smart enough to handle switch/case pattern matching between optionals and non-optionals for strings and integers, but before Swift 5.1 that wasn’t extended to enums.

 Well, in Swift 5.1 we can now use switch/case pattern matching to match optional enums with non-optionals, like this:
*/
enum BuildStatus {
    case starting
    case inProgress
    case complete
}

let status: BuildStatus? = .inProgress

switch status {
case .inProgress:
    print("Build is starting…")
case .complete:
    print("Build is complete!")
default:
    print("Some other build status")
}
/*:
Swift is able to compare the optional enum directly with the non-optional cases, so that code will print “Build is starting…”
 
 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
