/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Opaque return types

 [SE-0244](https://github.com/apple/swift-evolution/blob/master/proposals/0244-opaque-result-types.md) introduces the concept of opaque types into Swift. An opaque type is one where we’re told about the capabilities of an object without knowing specifically what kind of object it is.

 At first glance that sounds a lot like a protocol, but opaque return types take the concept of protocols significantly further because they are able to work with associated types, they require the same type to be used internally each time, and they allow us to hide implementation details.

 As an example, if we wanted to launch different kinds of fighters from a Rebel base we might write code like this:
*/
protocol Fighter { }
struct XWing: Fighter { }

func launchFighter() -> Fighter {
    return XWing()
}

let red5 = launchFighter()
/*:
 Whoever calls that function knows it will return some sort of `Fighter` but doesn’t know precisely what. As a result, we could add `struct YWing: Fighter { }` or other types, and have any of them be returned.

 But there’s a problem: what if we wanted to check whether a specific fighter was Red 5? You *might* think the solution is to make `Fighter` conform to the `Equatable` protocol so we can use `==`. However, as soon as you do that Swift will throw up a particularly dreaded error for the `launchFighter` function: “Protocol 'Fighter' can only be used as a generic constraint because it has Self or associated type requirements.”

 The “Self” part of that error is what is hitting us here. The `Equatable` protocol has to compare two instances of itself (“Self”) to see whether they are the same, but Swift has no guarantee that the two equatable things are remotely the same – we could be comparing a Fighter with an array of integers, for example.

 Opaque types solve this problem because even though *we* just see a protocol being used, internally the Swift compiler knows exactly what that protocol actually resolves to – it knows it’s an `XWing`, an array of strings, or whatever.

 To send back an opaque type, use the keyword `some` before your protocol name:
*/
func launchOpaqueFighter() -> some Fighter {
    return XWing()
}
/*:
 From the caller’s perspective that still gets back a `Fighter`, which might be an `XWing`, a `YWing`, or something else that conforms to the `Fighter` protocol. But from the *compiler’s* perspective it knows exactly what is being returned, so it can make sure we follow all the rules correctly.

 For example, consider a function that returned `some Equatable` like this:
*/
func makeInt() -> some Equatable {
    Int.random(in: 1...10)
}
/*:
 When we call that, all we know is that it is some sort of `Equatable` value, however if call it twice then we can compare the results of those two calls because Swift knows for sure it will be the same underlying type:
*/
let int1 = makeInt()
let int2 = makeInt()
print(int1 == int2)
/*:
 The same is *not* true if we had a *second* function that returned `some Equatable`, like this:
*/
func makeString() -> some Equatable {
    "Red"
}
/*:
 Even though from our perspective both send us back an `Equatable` type, and we *can* compare the results of two calls to `makeString()` or two calls to `makeInt()`, Swift won’t let us compare the return value of `makeString()` to the return value of `makeInt()` because it knows comparing a string and an integer doesn’t make any sense.

 An important proviso here is that functions with opaque return types must always return one specific type. If for example we tried to use `Bool.random()` to randomly launch an `XWing` or a `YWing` then Swift would refuse to build our code because the compiler can no longer tell what will be sent back.

 You might well think “if we always need to return the same type, why not just write the function as `func launchFighter() -> XWing`? While that might work sometimes, it creates new problems such as:

 - We end up with types we don’t really want to expose to the world. For example, if we used `someArray.lazy.drop { … }` we get sent back a `LazyDropWhileSequence` – a dedicated and highly specific type from the Swift standard library. All we actually care about is that this thing is a sequence; we don’t need to know how Swift’s internals work.

 - We lose the ability to change our mind later. Making `launchFighter()` return only an `XWing` means we can’t switch to a different type in the future, and given how much Disney relies on Star Wars toy sales that would be a problem! By returning an opaque type we can return X-Wings today, then move to B-Wings in a year – we only ever return one in any given build of our code, but we can still have the flexibility to change our mind.

 In some respects all this might sound similar to generics, which also solve the “Self or associated type requirements” problem. Generics allow us to write code like this:
*/
protocol ImperialFighter {
    init()
}

struct TIEFighter: ImperialFighter { }
struct TIEAdvanced: ImperialFighter { }

func launchImperialFighter<T: ImperialFighter>() -> T {
    return T()
}
/*:
 That defines a new protocol that requires conforming types to be initializable with no parameters, defines two structs that conform to that protocol, then creates a generic function to use it. However, the difference here is that now *callers* of `launchImperialFighter()` are the ones to choose what kind of fighter they get, like this:
*/
let fighter1: TIEFighter = launchImperialFighter()
let fighter2: TIEAdvanced = launchImperialFighter()
/*:
 If you *want* callers to be able to select their data type then generics work well, but if you want the *function* to decide the return type then they fall down;

 So, opaque result types allow us to do several things:

 - Our functions decide what type of data gets returned, not the caller of those functions.
 - We don’t need to worry about Self or associated type requirements, because the compiler knows exactly what type is inside.
 - We get to change our minds in the future whenever we need to.
 - We don’t expose private internal types to the outside world.

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
