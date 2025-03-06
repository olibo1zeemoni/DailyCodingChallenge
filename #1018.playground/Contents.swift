import Cocoa
import Foundation

var prompt = """
        This problem was asked by Microsoft.

        Given a clock time in hh:mm format, determine, to the nearest degree, the angle between the hour and the minute hands.

        Bonus: When, during the course of a day, will the angle be zero?
    """

func angleBetweenClockHands(hour: Int, minute: Int) -> Int {
    // Calculate the position of the minute hand in degrees
    let minuteAngle = Double(minute) * 6.0

    // Calculate the position of the hour hand in degrees, taking into account the minutes passed
    let hourAngle = (Double(hour % 12) * 30.0) + (Double(minute) * 0.5)

    // Find the absolute difference between the two angles
    var angle = abs(hourAngle - minuteAngle)

    // If the angle is greater than 180 degrees, take the smaller equivalent angle
    if angle > 180 {
        angle = 360 - angle
    }

    return Int(round(angle))
}

// Example usage:
let time = "03:15"
let components = time.split(separator: ":").map { Int($0)! }
let hour = components[0]
let minute = components[1]
let angle = angleBetweenClockHands(hour: hour, minute: minute)
print("The angle at \(time) is \(angle) degrees.")  // For "03:15", should print 7 degrees

// BONUS: Finding the times when the angle is zero
func timesWhenAngleIsZero() -> [String] {
    var result = [String]()
    var hour = 0
    var minute = 0

    while hour < 12 {
        let formattedTime = String(format: "%02d:%02d", hour, minute)
        result.append(formattedTime)

        // Move forward approximately 65 minutes to the next overlap
        minute += 65
        if minute >= 60 {
            minute -= 60
            hour += 1
        }
    }

    return result
}

print("Times when the angle is zero:", timesWhenAngleIsZero())
// Output should include: ["12:00", "01:05", "02:10", "03:15", ..., "11:55"]
let number = 12345.6789
let scientificString = String(format: "%.4e", number)
print(scientificString) // Output: "1.23e+04"
