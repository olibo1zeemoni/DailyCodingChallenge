import Cocoa

"""
Given k sorted singly linked lists, write a function to merge all the lists into one sorted singly linked list.
"""
class ListNode {
    var val: Int
    var next: ListNode?
    
    init(_ val: Int) {
        self.val = val
//        self.next = nil
    }
}

// Min-Heap (Priority Queue) based merging function
func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    // Custom comparator for ListNode to be used in the priority queue
    class ListNodeComparator: Comparable {
        static func < (lhs: ListNodeComparator, rhs: ListNodeComparator) -> Bool {
            return lhs.node.val < rhs.node.val
        }
        
        static func == (lhs: ListNodeComparator, rhs: ListNodeComparator) -> Bool {
            return lhs.node.val == rhs.node.val
        }
        
        let node: ListNode
        
        init(_ node: ListNode) {
            self.node = node
        }
    }
    
    // Priority queue (min-heap) to store the nodes
    var heap = [ListNodeComparator]()
    
    // Insert the head of each list into the heap
    for list in lists {
        if let node = list {
            heap.append(ListNodeComparator(node))
        }
    }
    
    // Heapify the array to maintain the heap property
    heap.sort()
    
    // Dummy head to simplify result list construction
    let dummy = ListNode(0)
    var current: ListNode? = dummy
    
    // While there are nodes in the heap
    while !heap.isEmpty {
        // Extract the node with the smallest value (at the front of the sorted heap)
        let minNode = heap.removeFirst().node
        current?.next = minNode
        current = minNode
        
        // If there are more nodes in the extracted list, insert the next node into the heap
        if let next = minNode.next {
            heap.append(ListNodeComparator(next))
            // Maintain the heap property after each insertion
            heap.sort()
        }
    }
    
    // Return the merged list, starting from dummy's next
    return dummy.next
}

// Helper function to create a linked list from an array
func createLinkedList(_ arr: [Int]) -> ListNode? {
    let dummy = ListNode(0)
    var current = dummy
    for num in arr {
        current.next = ListNode(num)
        current = current.next!
    }
    return dummy.next
}

// Helper function to print a linked list
func printList(_ head: ListNode?) {
    var current = head
    while current != nil {
        print(current!.val, terminator: " -> ")
        current = current?.next
    }
    print("nil")
}

// Example usage:
let list1 = createLinkedList([1, 4, 5])
let list2 = createLinkedList([1, 3, 4])
let list3 = createLinkedList([2, 6])

let mergedList = mergeKLists([list1, list2, list3])
printList(mergedList)  // Output: 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> 5 -> 6 -> nil
