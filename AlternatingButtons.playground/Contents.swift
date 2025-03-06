import UIKit
import PlaygroundSupport


class AlternatingButtonControl: UIControl {
    private let buttonA: UIButton
    private let buttonB: UIButton
    
    private var isButtonAActive = true
    
    var onButtonPressed: ((String) -> Void)?
    
    init(buttonA: UIButton, buttonB: UIButton) {
        self.buttonA = buttonA
        self.buttonB = buttonB
        super.init(frame: .zero)
        
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons() {
        addSubview(buttonA)
        addSubview(buttonB)
        
        buttonA.addTarget(self, action: #selector(buttonATapped), for: .touchUpInside)
        buttonB.addTarget(self, action: #selector(buttonBTapped), for: .touchUpInside)
        
        updateButtonStates()
    }
    
    @objc private func buttonATapped() {
        guard isButtonAActive else { return }
        isButtonAActive = false
        updateButtonStates()
        onButtonPressed?("A")
    }
    
    @objc private func buttonBTapped() {
        guard !isButtonAActive else { return }
        isButtonAActive = true
        updateButtonStates()
        onButtonPressed?("B")
    }
    
    private func updateButtonStates() {
        buttonA.isEnabled = isButtonAActive
        buttonB.isEnabled = !isButtonAActive
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout buttons side by side
        let buttonWidth = bounds.width / 2
        buttonA.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: bounds.height)
        buttonB.frame = CGRect(x: buttonWidth, y: 0, width: buttonWidth, height: bounds.height)
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 400, height: 800))
        view.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.3)
        
        let buttonA = UIButton(type: .system)
        buttonA.setTitle("Button A", for: .normal)
        
        let buttonB = UIButton(type: .system)
        buttonB.setTitle("Button B", for: .normal)
        
        let alternatingControl = AlternatingButtonControl(buttonA: buttonA, buttonB: buttonB)
        alternatingControl.frame = CGRect(x: 50, y: 100, width: 200, height: 50)
        alternatingControl.onButtonPressed = { buttonName in
            print("Button \(buttonName) was pressed")
        }
        
        view.addSubview(alternatingControl)
    }
}

PlaygroundPage.current.liveView = ViewController()


// Create a view controller
//class MyViewController : UIViewController {
//    // Create a label
//    let label = UILabel()
//    
//    // Create a button
//    let button = UIButton(type: .system)
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 400, height: 800))
//        // Set the view background color
//        view.backgroundColor = .red
//        
//        // Configure the label
//        label.text = "Hello, World!"
//        label.textColor = .black
//        label.textAlignment = .center
//        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
//        label.center = CGPoint(x: view.center.x, y: view.center.y - 50)
//        view.addSubview(label)
//        
//        // Configure the button
//        button.setTitle("Tap Me", for: .normal)
//        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
//        button.center = view.center
//        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//        view.addSubview(button)
//        
//       
//    }
//    
//    // Action method for the button tap
//    @objc func buttonTapped() {
//        label.text = "Button Pressed!"
//    }
//}

// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MyViewController()
