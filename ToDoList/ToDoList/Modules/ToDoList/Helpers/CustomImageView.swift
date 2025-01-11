//
//  CustomButton.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 11.01.2025.
//
import UIKit

final class CustomImageView: UIImageView {
        override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
            return bounds.insetBy(dx: -15, dy: -15).contains(point)
        }
}
