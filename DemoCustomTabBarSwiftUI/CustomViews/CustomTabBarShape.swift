//
//  CustomTabBarShape.swift
//  DemoCustomTabBarSwiftUI
//
//  Created by Dimpy Patel on 30/06/25.
//

import Foundation
import SwiftUI

// MARK: - TabBar Items
struct TabBarItems {
    let imageIcon: String
    let selectedImageIcon: String
    let title: String
}

// MARK: - TabBar Shape
struct CustomTabBarShape: Shape {
    
    // Constants used for the shape
    private enum Constants {
        static let cornerRadius: CGFloat = 20
        static let smallCornerRadius: CGFloat = 15
        static let buttonRadius: CGFloat = 30
        static let buttonPadding: CGFloat = 9
    }
    
    // Function to define the shape's path
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Move to the starting point at the bottom-left corner
        var x = rect.minX
        var y = rect.maxY
        path.move(to: CGPoint(x: x, y: y))
        
        // Add the rounded corner on the top-left corner
        x += Constants.cornerRadius
        y = Constants.buttonRadius + Constants.cornerRadius
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: Constants.cornerRadius,
            startAngle: .degrees(180),
            endAngle: .degrees(270),
            clockwise: false
        )
        // Add a small corner leading to the main half-circle
        x = rect.midX - Constants.buttonRadius - (Constants.buttonPadding / 2) - Constants.smallCornerRadius
        y = Constants.buttonRadius - Constants.smallCornerRadius
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: Constants.smallCornerRadius,
            startAngle: .degrees(90),
            endAngle: .degrees(35), // 0
            clockwise: true
        )
        // Add the main half-circle
        x = rect.midX
        y += Constants.smallCornerRadius + Constants.buttonPadding
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: Constants.buttonRadius + Constants.buttonPadding,
            startAngle: .degrees(215), // 180
            endAngle: .degrees(325), // 0
            clockwise: false
        )
        // Add a trailing small corner
        x += Constants.buttonRadius + (Constants.buttonPadding / 2) + Constants.smallCornerRadius
        y = Constants.buttonRadius - Constants.smallCornerRadius
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: Constants.smallCornerRadius,
            startAngle: .degrees(145), // 180
            endAngle: .degrees(90),
            clockwise: true
        )
        // Add the rounded corner on the top-right corner
        x = rect.maxX - Constants.cornerRadius
        y = Constants.buttonRadius + Constants.cornerRadius
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: Constants.cornerRadius,
            startAngle: .degrees(270),
            endAngle: .degrees(0),
            clockwise: false
        )
        // Connect the bottom corner
        x = rect.maxX
        y = rect.maxY
        path.addLine(to: CGPoint(x: x, y: y))
        
        // Close the path to complete the shape
        path.closeSubpath()
        return path
    }
}
