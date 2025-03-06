import UIKit
import PlaygroundSupport

class ClockViewController: UIViewController {
    // Clock face
    let clockFace = UIView()
    
    // Clock hands
    let hourHand = UIView()
    let minuteHand = UIView()
    let secondHand = UIView()
    let hourMarks = UIView()
    
    // Timer for updating the clock
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's frame to 400x400
                view.frame = CGRect(x: 0, y: 0, width: 350, height: 350)
        
        // Set up the clock face
        clockFace.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        clockFace.center = view.center
        clockFace.layer.cornerRadius = 150
        clockFace.layer.borderWidth = 2
        clockFace.layer.borderColor = UIColor.black.cgColor
        view.addSubview(clockFace)
        
        // Set up hour marks
        hourMarks.frame = CGRect(x: 0, y: 0, width: 7, height: 15)
        hourMarks.backgroundColor = UIColor.green
        hourMarks.center = clockFace.center
        hourMarks.layer.anchorPoint = CGPoint(x: 2.0, y: 1.5)
        view.addSubview(hourMarks)
        
        // Set up the hour hand
        hourHand.frame = CGRect(x: 0, y: 0, width: 8, height: 80)
        hourHand.backgroundColor = UIColor.black
        hourHand.center = clockFace.center
        hourHand.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        view.addSubview(hourHand)
        
        // Set up the minute hand
        minuteHand.frame = CGRect(x: 0, y: 0, width: 6, height: 120)
        minuteHand.backgroundColor = UIColor.black
        minuteHand.center = clockFace.center
        minuteHand.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        view.addSubview(minuteHand)
        
        // Set up the second hand
        secondHand.frame = CGRect(x: 0, y: 0, width: 4, height: 140)
        secondHand.backgroundColor = UIColor.red
        secondHand.center = clockFace.center
        secondHand.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        view.addSubview(secondHand)
        
        // Start the timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
        
        // Initialize the clock
        updateClock()
    }
    
    @objc func updateClock() {
        // Get the current time
        let calendar = Calendar.current
        let now = Date()
        let hours = calendar.component(.hour, from: now)
        let minutes = calendar.component(.minute, from: now)
        let seconds = calendar.component(.second, from: now)
        
        // Calculate angles for each hand
        let hourAngle = CGFloat(hours % 12) * .pi / 6 + CGFloat(minutes) * .pi / 360
        let minuteAngle = CGFloat(minutes) * .pi / 30 + CGFloat(seconds) * .pi / 1800
        let secondAngle = CGFloat(seconds) * .pi / 30
        
        // Apply the rotations
        hourHand.transform = CGAffineTransform(rotationAngle: hourAngle)
        minuteHand.transform = CGAffineTransform(rotationAngle: minuteAngle)
        secondHand.transform = CGAffineTransform(rotationAngle: secondAngle)
    }
}

// Set up the Playground
let clockVC = ClockViewController()
clockVC.view.backgroundColor = .white

PlaygroundPage.current.liveView = clockVC
