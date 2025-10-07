import Foundation


//MARK: getter, setter 
class Shape {
    var sides = 0
    private var _color = "white"
    var color: String {
        get {
            _color
        }
        set {
            _color = newValue
        }
    }
    
    func description() -> String{
        "The shape has \(sides) sides"
    }
}

var shape = Shape.init()
shape.sides = 7

//print(shape.description())

class Triangle: Shape {
    
    
    override var sides: Int {
        willSet {
//            print("sides is about to change to \(newValue)")
        }
        didSet {
//            print("sides did change from \(oldValue)")
        }
    }
    override func description() -> String {
        "This is a triangle"
    }
    
    override var color: String {
        didSet {
            print("color changed from \(oldValue) to \(super.color)")
        }
    }
    
}

var newTriangle = Triangle()
newTriangle.sides = 3
newTriangle.color = "black"
print(newTriangle.color)

//MARK: - reference type in action
class Todo {
    var id: Int
    init(id: Int) {
        self.id = id
    }
}
var todo = Todo(id: 1)
var newTodo = todo
newTodo.id = 2

//print("todo's id is \(todo.id)")
//print("new todo's id is \(newTodo.id)")

class NameSpace {
    var name: String
    var numberOfSides = 0
    
    init(name: String) {
        self.name = name
    }
    func description(){
        print("some description")
    }
}

class Square: NameSpace {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    override func description() {
//        super.description()
        print("a square of side lenght \(sideLength)")
    }
    
    func area() -> Double {
        sideLength * sideLength
    }
}

var newSquare = Square(sideLength: 5.0, name: "new square")
newSquare.description()
print(newSquare.area())

class EquilateralTriangle: NameSpace {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get{
            return sideLength * 3
        }
        
        set{
            sideLength = newValue/3
        }
    }
}

class SquareTriangle {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(name: String, sideLength: Double) {
        self.triangle = EquilateralTriangle(sideLength: sideLength, name: name)
        self.square = Square(sideLength: sideLength, name: name)
    }
}



class Circle: NameSpace {
    var radius: Double
    
    init(radius: Double, name: String) {
        self.radius = radius
        super.init(name: name)
    }
    
    override func description() {
        print("a circle of radius \(radius)")
    }
    
    func area() -> Double{
        3.14 * pow(radius, 2)
    }
}

let smallCircle = Circle(radius: 4.8, name: "small circle")
smallCircle.area()

//MARK: computed properties with only getters can be overwritten and getter&&Setter provided.
class Superclass {
    var storedVar: String = "Super"
    let storedLet: String = "Fixed"   // read-only stored
    var computedVar: String {
        get { "Super computed" }
//        set { /* maybe store somewhere or ignore */ }
    }
}

class Subclass: Superclass {
    override var computedVar: String {
        get { storedVar + "Sub computed"}
        set{ storedVar = newValue }
    }
}

//MARK: enums

enum Rank: Int, CaseIterable {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
    
}

//for rank in Rank.allCases {
//    print(rank.rawValue)
//}

let ace = Rank.ace
let king = Rank.king

func <(lhs: Rank, rhs: Rank) -> Bool {
    lhs.rawValue < rhs.rawValue
}

func >(lhs: Rank, rhs: Rank) -> Bool {
    lhs.rawValue > rhs.rawValue
}

ace < king
king > ace

enum Suit: CaseIterable {
    case spades, hearts, diamonds, clubs


    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
    
    func color() -> String {
        switch self {
        case .spades, .clubs:
            return "black"
        case .diamonds, .hearts:
            return "red"
        }
    }
    
}

struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    
    static func fullDeck() -> [Card] {
        var cards = [Card]()
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                let card = Card(rank: rank, suit: suit)
                cards.append(card)
            }
        }
        
        return cards
    }
}

Card.fullDeck().count

enum ServerResponse {
    case result(String, String)
    case failure(String)
    case unknown(String)
}

let success = ServerResponse.result("6:03 AM", "6:11 PM")
let failure = ServerResponse.failure("Couldn't fetch results")
let unknown = ServerResponse.unknown("Unknown result")

switch success {
case let .result(sunrise,sunset):
    print("Sunrise at \(sunrise) and sunset at \(sunset)")
case let .failure(message):
    print("Error: \(message)")
case .unknown(let string):
    print(string)
}

protocol ExampleProtocol {
    var simpleDescription: String {get}
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A simple class"
    
    var anotherProperty: Int = 3748
    
    func adjust() {
        simpleDescription += " now totally adjusted"
    }
}

struct SimpleStruct: ExampleProtocol {
    var simpleDescription: String = "A simple struct"
    
    mutating func adjust() {
        simpleDescription += " now totally adjusted"
    }
}

//let aSimpleClass = SimpleClass()
//aSimpleClass.adjust()
//let aDescription = aSimpleClass.simpleDescription
//print(aDescription)
//
//var aSimpleStruct = SimpleStruct()
//aSimpleStruct.adjust()
//var structDescription = aSimpleStruct.simpleDescription
//print(structDescription)
//
//let z: ExampleProtocol = SimpleClass()
//z.simpleDescription
//z.anotherProperty error due to boxed protocol type

extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    
    mutating func adjust() {
        
    }
    
    
}

//let x = 10
//x.simpleDescription
//
extension Double {
    var absoluteValue: Self {
        return self >= 0 ? self : self * -1.0
    }
}

var y = -12.0
y.absoluteValue

protocol Vehicle { }

struct Car: Vehicle { }
struct Van: Vehicle { }
struct Truck: Vehicle { }

var vehicles: [Vehicle] = [Car(),Van(),Truck()]

print("hello world")
