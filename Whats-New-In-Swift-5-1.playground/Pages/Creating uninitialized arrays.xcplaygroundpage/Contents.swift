/*:
 [< Previous](@previous)           [Home](Introduction)

 ## Creating uninitialized arrays

[SE-0245](https://github.com/apple/swift-evolution/blob/master/proposals/0245-array-uninitialized-initializer.md) introduces a new initializer for arrays that doesn’t pre-fill values with a default. This was previously available as a private API, which meant Xcode wouldn’t list it in its code completion but you could still use it if you wanted – and if you were happy to take the risk that it wouldn’t be withdrawn in the future!

To use the initializer, tell it the capacity you want, then provide a closure to fill in the values however you need. Your closure will be given an unsafe mutable buffer pointer where you can write your values, as well as an `inout` second parameter that lets you report back how many values you actually used.

For example, we could make an array of 10 random integers like this:
*/
let randomNumbers = Array<Int>(unsafeUninitializedCapacity: 10) { buffer, initializedCount in
    for x in 0..<10 {
        buffer[x] = Int.random(in: 0...10)
    }
    
    initializedCount = 10
}
/*:
 There are some rules here:

 1. You don’t need to use all the capacity you ask for, but you can’t go *over* capacity. So, if you ask for a capacity of 10 you can set `initializedCount` to 0 through 10, but not 11.
 2. If you don’t initialize elements that end up being in your array – for example if you set `initializedCount` to 5 but don’t actually provide values for elements 0 through 4 – then they are likely to be filled with random data. This is A Bad Idea.
 3. If you don’t set `initializedCount` it will be 0, so any data you assigned will be lost.

 Now, we *could* have rewritten the above code using `map()`, like this:
*/
let randomNumbers2 = (0...9).map { _ in Int.random(in: 0...10) }
/*:
 That’s certainly easier to read, but it’s less efficient: it creates a range, creates a new empty array, sizes it up to the correct amount, loops over the range, and calls the closure once for each range item.
 
 &nbsp;

 [< Previous](@previous)           [Home](Introduction)
 */
