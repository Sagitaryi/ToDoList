//
//  Extension+.swift
//  ToDoList
//
//  Created by Алексей Чумаков on 11.12.2024.
//
import UIKit

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttributes(
            [.foregroundColor: UIColor.grayToDo,
             .strikethroughStyle: NSUnderlineStyle.single.rawValue],
            range: NSMakeRange(0,attributeString.length))
        return attributeString
    }

    func applyDefault() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttributes(
            [.foregroundColor: UIColor.whiteToDo,
             .strikethroughStyle: 0],
            range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
