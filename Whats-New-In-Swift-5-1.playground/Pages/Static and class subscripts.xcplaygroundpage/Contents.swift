/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Static and class subscripts

 [SE-0254](https://github.com/apple/swift-evolution/blob/master/proposals/0254-static-subscripts.md) adds the ability to mark subscripts as being *static*, which means they apply to types rather than instances of a type.

 Static properties and methods are used when one set of values is shared between all instances of that type. For example, if you had one centralized type to store your app settings, you might write code like this:
*/
public enum OldSettings {
    private static var values = [String: String]()
    
    static func get(_ name: String) -> String? {
        return values[name]
    }

    static func set(_ name: String, to newValue: String?) {
        print("Adjusting \(name) to \(newValue ?? "nil")")
        values[name] = newValue
    }
}

OldSettings.set("Captain", to: "Gary")
OldSettings.set("Friend", to: "Mooncake")
print(OldSettings.get("Captain") ?? "Unknown")
/*:
 Wrapping the dictionary inside a type means that we can control access more carefully, and using an enum with no cases means we can’t try to instantiate the type – we can’t make various instances of `Settings`.

 With Swift 5.1 we can now use a static subscript instead, allowing us to rewrite our code to this:
*/
public enum NewSettings {
    private static var values = [String: String]()

    public static subscript(_ name: String) -> String? {
        get {
            return values[name]
        }
        set {
            print("Adjusting \(name) to \(newValue ?? "nil")")
            values[name] = newValue
        }
    }
}

NewSettings["Captain"] = "Gary"
NewSettings["Friend"] = "Mooncake"
print(NewSettings["Captain"] ?? "Unknown")
/*:
 Custom subscripts like this have always been possible for instances of types; this improvement makes static or class subscripts possible too.

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
