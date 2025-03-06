import PlaygroundSupport
import SwiftUI

struct AnalogClockView: View {
    @State private var currentTime = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Clock face
                Circle()
                    .fill(Color.white)
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 4)
                    )
                    .padding()

                // Hour markers
                ForEach(0..<12) { hour in
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 2, height: geometry.size.width * 0.1)
                        .offset(y: -geometry.size.width * 0.4)
                        .rotationEffect(.degrees(Double(hour) * 30))
                }

                // Hour hand
                ClockHand(
                    width: geometry.size.width, height: geometry.size.height,
                    handLength: 0.3, angle: getHourHandAngle()
                )
                .stroke(Color.black, lineWidth: 4)

                // Minute hand
                ClockHand(
                    width: geometry.size.width, height: geometry.size.height,
                    handLength: 0.4, angle: getMinuteHandAngle()
                )
                .stroke(Color.black, lineWidth: 3)

                // Second hand
                ClockHand(
                    width: geometry.size.width, height: geometry.size.height,
                    handLength: 0.45, angle: getSecondHandAngle()
                )
                .stroke(Color.red, lineWidth: 1)

                // Center circle
                Circle()
                    .fill(Color.black)
                    .frame(width: 15, height: 15)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onReceive(timer) { input in
            currentTime = input
        }
    }

    private func getHourHandAngle() -> Double {
        let hour = Calendar.current.component(.hour, from: currentTime) % 12
        let minute = Calendar.current.component(.minute, from: currentTime)
        return Double(hour * 30 + minute / 2)
    }

    private func getMinuteHandAngle() -> Double {
        let minute = Calendar.current.component(.minute, from: currentTime)
        return Double(minute * 6)
    }

    private func getSecondHandAngle() -> Double {
        let second = Calendar.current.component(.second, from: currentTime)
        return Double(second * 6)
    }
}

struct ClockHand: Shape {
    let width: CGFloat
    let height: CGFloat
    let handLength: CGFloat
    let angle: Double

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: width / 2, y: height / 2))
        path.addLine(
            to: CGPoint(
                x: width / 2 + handLength * width * sin(angle * .pi / 180),
                y: height / 2 - handLength * height * cos(angle * .pi / 180)
            ))
        return path
    }
}

// Create the SwiftUI view that provides a preview of the analog clock
let clockView = AnalogClockView()
    .frame(width: 300, height: 300)

// Wrap the view in a UIHostingController, which is used to present SwiftUI views in UIKit
let hostingController = UIHostingController(rootView: clockView)

// Set the hosting controller's view as the playground live view
PlaygroundPage.current.liveView = hostingController
