import Cocoa

"""
This problem was asked by Google
Given a stack of N elements, interleave the first half of the stack with the second half reversed using only one other queue. This should be done in-place.

Recall that you can only push or pop from a stack, and enqueue or dequeue from a queue.

For example, if the stack is [1, 2, 3, 4, 5], it should become [1, 5, 2, 4, 3]. If the stack is [1, 2, 3, 4], it should become [1, 4, 2, 3].

Hint: Try working backwards from the end state.
"""


struct Stack<T> {
    private var elements: [T] = []
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        return elements.popLast()
    }
    
    func peek() -> T? {
        return elements.last
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
}

struct Queue<T> {
    private var elements: [T] = []
    
    mutating func enqueue(_ element: T) {
        elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        return elements.isEmpty ? nil : elements.removeFirst()
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
}

func interleaveStack<T>(_ stack: inout Stack<T>) {
    let n = stack.count
    var queue = Queue<T>()
    
    // Step 1: Move all elements from stack to queue
    for _ in 0..<n {
        if let element = stack.pop() {
            queue.enqueue(element)
        }
    }
    
    // Step 2: Dequeue the second half and push onto stack
    for _ in 0..<n/2 {
        if let element = queue.dequeue() {
            stack.push(element)
        }
    }
    
    // Step 3: Interleave the remaining elements
    for i in 0..<n/2 {
        if i % 2 == 0 {
            // Push from queue to stack
            if let element = queue.dequeue() {
                stack.push(element)
            }
        } else {
            // Move top element of stack to queue, then push from queue to stack
            if let top = stack.pop() {
                queue.enqueue(top)
            }
            if let element = queue.dequeue() {
                stack.push(element)
            }
        }
    }
    
    // Step 4: If odd number of elements, push the last element
    if n % 2 != 0 {
        if let lastElement = queue.dequeue() {
            stack.push(lastElement)
        }
    }
}

// Test the implementation
var stack = Stack<Int>()
for i in 1...5 {
    stack.push(i)
}

print("Original stack:")
var tempStack = stack
while let element = tempStack.pop() {
    print(element)
}

interleaveStack(&stack)

print("\nInterleaved stack:")
while let element = stack.pop() {
    print(element)
}
