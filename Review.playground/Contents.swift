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
